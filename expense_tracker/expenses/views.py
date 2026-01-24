from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.db.models import Sum, Q
from django.utils import timezone
from datetime import datetime, timedelta
from decimal import Decimal, InvalidOperation
from django.core.paginator import Paginator
from django.http import HttpResponse
import csv
from .models import Expense, Category
from .forms import ExpenseForm, CATEGORY_GROUPS, CURRENCY_CHOICES
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import login, logout
from django.contrib.auth.views import LoginView
from django.views.decorators.clickjacking import xframe_options_sameorigin
from django.db.models.functions import TruncMonth

class CustomLoginView(LoginView):
    template_name = 'registration/login.html'

    def form_valid(self, form):
        messages.success(self.request, 'Welcome back! You have successfully logged in.')
        return super().form_valid(form)

def custom_logout(request):
    logout(request)
    messages.info(request, "Thanks for using MoneyFlow. See you soon!")
    return redirect('login')

def register(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            messages.success(request, 'Successfully registered. Welcome!')
            return redirect('expense_list')
    else:
        form = UserCreationForm()
    return render(request, 'registration/register.html', {'form': form})

@login_required
@xframe_options_sameorigin
def add_expense(request):
    form = ExpenseForm(request.POST or None, user=request.user)
    if form.is_valid():
        expense = form.save(commit=False)
        expense.user = request.user
        expense.save()
        messages.success(request, 'Expense added successfully.')
        if request.GET.get('modal') == '1':
            return HttpResponse(
                """
                <html><body>
                <script>
                window.parent.postMessage('close-expense-modal', '*');
                window.parent.location.reload();
                </script>
                </body></html>
                """,
                content_type='text/html'
            )
        return redirect('expense_list')
    return render(request, 'expenses/add_expense.html', {'form': form})

def _apply_filters(request, base_qs):
    category_group = request.GET.get('category_group', '')
    date_mode = request.GET.get('date_mode', '')
    day = request.GET.get('day', '')
    month = request.GET.get('month', '')
    year = request.GET.get('year', '')
    amount_sort = request.GET.get('amount_sort', '')
    q = request.GET.get('q', '').strip()
    amount_min = request.GET.get('amount_min', '').strip()
    amount_max = request.GET.get('amount_max', '').strip()
    currency = request.GET.get('currency', '').strip()

    period_qs = base_qs

    if date_mode == 'day' and day and month and year:
        try:
            parsed_date = datetime.strptime(f"{day}/{month}/{year}", '%d/%m/%Y').date()
            period_qs = period_qs.filter(date=parsed_date)
        except ValueError:
            pass
    elif date_mode == 'month' and month and year:
        try:
            period_qs = period_qs.filter(date__year=int(year), date__month=int(month))
        except ValueError:
            pass
    elif date_mode == 'year' and year:
        try:
            period_qs = period_qs.filter(date__year=int(year))
        except ValueError:
            pass

    filtered_qs = period_qs
    if category_group:
        filtered_qs = filtered_qs.filter(category__name__startswith=f"{category_group} - ")

    if q:
        filtered_qs = filtered_qs.filter(
            Q(description__icontains=q) |
            Q(category__name__icontains=q)
        )

    if currency:
        filtered_qs = filtered_qs.filter(currency=currency)

    try:
        if amount_min:
            filtered_qs = filtered_qs.filter(amount__gte=Decimal(amount_min.replace(',', '')))
        if amount_max:
            filtered_qs = filtered_qs.filter(amount__lte=Decimal(amount_max.replace(',', '')))
    except (InvalidOperation, ValueError):
        pass

    order_by = ['-date', '-id']
    if amount_sort == 'asc':
        order_by = ['amount', '-date', '-id']
    elif amount_sort == 'desc':
        order_by = ['-amount', '-date', '-id']

    return {
        'period_qs': period_qs,
        'filtered_qs': filtered_qs,
        'category_group': category_group,
        'date_mode': date_mode,
        'day': day,
        'month': month,
        'year': year,
        'amount_sort': amount_sort,
        'q': q,
        'amount_min': amount_min,
        'amount_max': amount_max,
        'currency': currency,
        'order_by': order_by,
    }


@login_required
def expense_list(request):
    base_qs = Expense.objects.filter(user=request.user)
    filters = _apply_filters(request, base_qs)

    expenses = filters['filtered_qs'].order_by(*filters['order_by'])
    paginator = Paginator(expenses, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    all_vnd_expenses = Expense.objects.filter(user=request.user, currency='VND')
    total_amount = all_vnd_expenses.aggregate(total=Sum('amount'))['total'] or 0
    today = timezone.localdate()
    month_total = all_vnd_expenses.filter(date__year=today.year, date__month=today.month).aggregate(total=Sum('amount'))['total'] or 0

    vnd_in_view = filters['filtered_qs'].filter(currency='VND')
    filtered_total_vnd = vnd_in_view.aggregate(total=Sum('amount'))['total'] or 0
    distinct_days = vnd_in_view.values('date').distinct().count() or 0
    avg_daily_vnd = (filtered_total_vnd / distinct_days) if distinct_days else 0

    max_expense = filters['filtered_qs'].order_by('-amount', '-date').first()

    chart_currency = filters['currency'] or 'VND'
    chart_qs = filters['filtered_qs']
    if filters['currency']:
        chart_qs = chart_qs.filter(currency=filters['currency'])
    else:
        chart_qs = chart_qs.filter(currency='VND')

    chart_rows = (
        chart_qs
        .values('category__name')
        .annotate(total=Sum('amount'))
        .order_by('-total')[:8]
    )

    def display_label(name):
        if not name:
            return 'Uncategorized'
        if ' - ' in name:
            return name.rsplit(' - ', 1)[1]
        return name

    chart_labels = [display_label(row['category__name']) for row in chart_rows]
    chart_values = [float(row['total'] or 0) for row in chart_rows]

    def build_time_series(days):
        end_date = today
        start_date = end_date - timedelta(days=days - 1)
        timeline_days = [start_date + timedelta(days=i) for i in range(days)]

        time_rows = (
            chart_qs.filter(date__range=(start_date, end_date))
            .values('date')
            .annotate(total=Sum('amount'))
            .order_by('date')
        )
        time_map = {row['date']: float(row['total'] or 0) for row in time_rows}
        return {
            'labels': [d.strftime('%d/%m') for d in timeline_days],
            'values': [time_map.get(d, 0) for d in timeline_days],
        }

    time_series_data = {
        '7': build_time_series(7),
        '14': build_time_series(14),
        '30': build_time_series(30),
    }

    end_date = today
    week_start = end_date - timedelta(days=6)
    prev_week_start = week_start - timedelta(days=7)
    prev_week_end = week_start - timedelta(days=1)

    week_total = chart_qs.filter(date__range=(week_start, end_date)).aggregate(total=Sum('amount'))['total'] or 0
    prev_week_total = chart_qs.filter(date__range=(prev_week_start, prev_week_end)).aggregate(total=Sum('amount'))['total'] or 0

    insights = []
    if week_total or prev_week_total:
        if prev_week_total:
            delta = ((week_total - prev_week_total) / prev_week_total) * 100
            trend = 'tăng' if delta > 0 else 'giảm'
            insights.append(f"Tuần này bạn chi {int(week_total):,} {chart_currency}, {trend} {abs(delta):.0f}% so với tuần trước.")
        else:
            insights.append(f"Tuần này bạn chi {int(week_total):,} {chart_currency}, tuần trước chưa có dữ liệu.")

    total_in_range = chart_qs.aggregate(total=Sum('amount'))['total'] or 0
    if total_in_range:
        top_row = chart_qs.values('category__name').annotate(total=Sum('amount')).order_by('-total').first()
        if top_row:
            share = (top_row['total'] / total_in_range) * 100
            top_label = display_label(top_row['category__name'])
            if share >= 40:
                insights.append(f"Chi tiêu đang lệch vào '{top_label}' ({share:.0f}%). Cân nhắc cắt bớt nếu không thật sự cần.")
            elif share >= 25:
                insights.append(f"'{top_label}' đang chiếm {share:.0f}% tổng chi. Giữ mắt ở mục này nhé.")
    if not insights:
        insights.append("Chưa đủ dữ liệu để phân tích. Hãy thêm vài khoản chi nữa nhé.")

    category_groups_with_counts = []
    for group in CATEGORY_GROUPS.keys():
        count = filters['period_qs'].filter(category__name__startswith=f"{group} - ").count()
        category_groups_with_counts.append({'name': group, 'count': count})

    context = {
        'expenses': page_obj,
        'page_obj': page_obj,
        'total_amount': total_amount,
        'month_total': month_total,
        'filtered_total_vnd': filtered_total_vnd,
        'avg_daily_vnd': avg_daily_vnd,
        'max_expense': max_expense,
        'count': expenses.count(),
        'category_group': filters['category_group'],
        'date_mode': filters['date_mode'],
        'day': filters['day'],
        'month': filters['month'],
        'year': filters['year'],
        'amount_sort': filters['amount_sort'],
        'q': filters['q'],
        'amount_min': filters['amount_min'],
        'amount_max': filters['amount_max'],
        'currency': filters['currency'],
        'currency_choices': CURRENCY_CHOICES,
        'category_groups_with_counts': category_groups_with_counts,
        'chart_labels': chart_labels,
        'chart_values': chart_values,
        'chart_currency': chart_currency,
        'time_series_data': time_series_data,
        'insights': insights,
    }
    return render(request, 'expenses/expense_list.html', context)


@login_required
def export_expenses(request):
    base_qs = Expense.objects.filter(user=request.user)
    filters = _apply_filters(request, base_qs)
    export_qs = filters['filtered_qs'].order_by('-date', '-id')

    response = HttpResponse(content_type='text/csv; charset=utf-8')
    response['Content-Disposition'] = 'attachment; filename="expenses_export.csv"'
    response.write('\ufeff')
    writer = csv.writer(response)
    writer.writerow(['Date', 'Category', 'Amount', 'Currency', 'Description'])

    for item in export_qs:
        writer.writerow([
            item.date.strftime('%d/%m/%Y'),
            item.category_label,
            f"{item.amount:.2f}",
            item.currency,
            item.description or '-',
        ])

    return response


@login_required
def profile_view(request):
    base_qs = Expense.objects.filter(user=request.user)
    total_transactions = base_qs.count()
    total_amount = base_qs.aggregate(total=Sum('amount'))['total'] or 0

    months = (
        base_qs.annotate(month=TruncMonth('date'))
        .values('month')
        .distinct()
        .count()
    )
    avg_monthly = (total_amount / months) if months else 0

    top_category_row = (
        base_qs.values('category__name')
        .annotate(total=Sum('amount'))
        .order_by('-total')
        .first()
    )
    top_category = top_category_row['category__name'] if top_category_row else None

    spending_profile = 'Balanced'
    if avg_monthly and avg_monthly < 3000000:
        spending_profile = 'Saver'
    elif avg_monthly and avg_monthly > 8000000:
        spending_profile = 'Spender'

    profile_explain = {
        'Saver': 'You keep monthly spending consistently low.',
        'Balanced': 'You maintain a steady spending rhythm.',
        'Spender': 'You spend above the typical monthly range.',
    }[spending_profile]

    insight = 'You tend to spend more toward the end of the month.'
    if total_transactions < 5:
        insight = 'Add more transactions to unlock deeper insights.'

    context = {
        'total_transactions': total_transactions,
        'total_amount': total_amount,
        'avg_monthly': avg_monthly,
        'top_category': top_category,
        'spending_profile': spending_profile,
        'profile_explain': profile_explain,
        'insight': insight,
    }
    return render(request, 'expenses/profile.html', context)


@login_required
def settings_view(request):
    if request.method == 'POST':
        messages.success(request, 'Settings saved.')
    return render(request, 'expenses/settings.html')


@login_required
@xframe_options_sameorigin
def edit_expense(request, pk):
    expense = get_object_or_404(Expense, pk=pk, user=request.user)
    form = ExpenseForm(request.POST or None, instance=expense, user=request.user)
    if form.is_valid():
        form.save()
        messages.success(request, 'Expense updated successfully.')
        if request.GET.get('modal') == '1':
            return HttpResponse(
                """
                <html><body>
                <script>
                window.parent.postMessage('close-expense-modal', '*');
                window.parent.location.reload();
                </script>
                </body></html>
                """,
                content_type='text/html'
            )
        return redirect('expense_list')
    return render(request, 'expenses/edit_expense.html', {'form': form, 'expense': expense})


@login_required
def delete_expense(request, pk):
    expense = get_object_or_404(Expense, pk=pk, user=request.user)
    if request.method == 'POST':
        expense.delete()
        messages.success(request, 'Expense deleted successfully.')
        return redirect('expense_list')
    return redirect('expense_list')
