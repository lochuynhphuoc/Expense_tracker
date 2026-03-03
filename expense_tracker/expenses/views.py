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
from .models import Expense, Category, UserSettings
from .forms import ExpenseForm, CATEGORY_GROUPS, CURRENCY_CHOICES, UserSettingsForm
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import login, logout
from django.contrib.auth.views import LoginView
from django.views.decorators.clickjacking import xframe_options_sameorigin
from django.db.models.functions import TruncMonth

class CustomLoginView(LoginView):
    template_name = 'registration/login.html'

    def form_valid(self, form):
        user = form.get_user()
        settings = UserSettings.objects.filter(user=user).first()
        lang = settings.language if settings else 'en'
        message = 'Chào mừng bạn quay lại! Đăng nhập thành công.' if lang == 'vi' else 'Welcome back! You have successfully logged in.'
        messages.success(self.request, message)
        return super().form_valid(form)

def custom_logout(request):
    lang = _get_language(request)
    logout(request)
    message = 'Cảm ơn bạn đã sử dụng MoneyFlow. Hẹn gặp lại!' if lang == 'vi' else 'Thanks for using MoneyFlow. See you soon!'
    messages.info(request, message)
    return redirect('login')

def register(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            lang = _get_language(request)
            message = 'Đăng ký thành công. Chào mừng bạn!' if lang == 'vi' else 'Successfully registered. Welcome!'
            messages.success(request, message)
            return redirect('expense_list')
    else:
        form = UserCreationForm()
    return render(request, 'registration/register.html', {'form': form})


def _get_language(request):
    if not request.user.is_authenticated:
        return 'en'
    settings = UserSettings.objects.filter(user=request.user).first()
    return settings.language if settings else 'en'

@login_required
@xframe_options_sameorigin
def add_expense(request):
    form = ExpenseForm(request.POST or None, user=request.user)
    if form.is_valid():
        expense = form.save(commit=False)
        expense.user = request.user
        expense.save()
        lang = _get_language(request)
        message = 'Đã thêm chi tiêu.' if lang == 'vi' else 'Expense added successfully.'
        messages.success(request, message)
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
    page_size = request.GET.get('page_size', '').strip()

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

    try:
        page_size = int(page_size)
    except (TypeError, ValueError):
        page_size = 10
    if page_size not in {10, 25, 50, 100}:
        page_size = 10

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
        'page_size': page_size,
        'order_by': order_by,
    }


@login_required
def expense_list(request):
    lang = _get_language(request)
    is_vi = lang == 'vi'
    base_qs = Expense.objects.filter(user=request.user)
    filters = _apply_filters(request, base_qs)

    expenses = filters['filtered_qs'].order_by(*filters['order_by'])
    paginator = Paginator(expenses, filters['page_size'])
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

    chart_currency = filters['currency'] or 'VND'
    chart_qs = filters['filtered_qs']
    if filters['currency']:
        chart_qs = chart_qs.filter(currency=filters['currency'])
    else:
        chart_qs = chart_qs.filter(currency='VND')

    filtered_total_in_view = chart_qs.aggregate(total=Sum('amount'))['total'] or 0

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

    top_category_row = (
        chart_qs.values('category__name')
        .annotate(total=Sum('amount'))
        .order_by('-total')
        .first()
    )
    max_category = None
    if top_category_row:
        max_category = {
            'total': top_category_row['total'] or 0,
            'label': display_label(top_category_row['category__name']),
            'currency': chart_currency,
        }

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
            if is_vi:
                trend = 'tăng' if delta > 0 else 'giảm'
                insights.append(f"Tuần này bạn chi {int(week_total):,} {chart_currency}, {trend} {abs(delta):.0f}% so với tuần trước.")
            else:
                trend = 'up' if delta > 0 else 'down'
                insights.append(f"You spent {int(week_total):,} {chart_currency} this week, {trend} {abs(delta):.0f}% vs last week.")
        else:
            insights.append(
                f"Tuần này bạn chi {int(week_total):,} {chart_currency}, tuần trước chưa có dữ liệu."
                if is_vi else
                f"You spent {int(week_total):,} {chart_currency} this week; no data for last week."
            )

    total_in_range = chart_qs.aggregate(total=Sum('amount'))['total'] or 0
    if total_in_range:
        top_row = chart_qs.values('category__name').annotate(total=Sum('amount')).order_by('-total').first()
        if top_row:
            share = (top_row['total'] / total_in_range) * 100
            top_label = display_label(top_row['category__name'])
            if share >= 40:
                insights.append(
                    f"Chi tiêu đang lệch vào '{top_label}' ({share:.0f}%). Cân nhắc cắt bớt nếu không thật sự cần."
                    if is_vi else
                    f"Spending is skewed toward '{top_label}' ({share:.0f}%). Consider trimming it."
                )
                insights.append(
                    f"Mục '{top_label}' đang dẫn dắt xu hướng chi tiêu. Hãy thử đặt giới hạn mềm cho mục này trong tuần tới."
                    if is_vi else
                    f"'{top_label}' is driving your spend pattern. Try a soft cap for this category next week."
                )
            elif share >= 25:
                insights.append(
                    f"'{top_label}' đang chiếm {share:.0f}% tổng chi. Giữ mắt ở mục này nhé."
                    if is_vi else
                    f"'{top_label}' makes up {share:.0f}% of total spend. Keep an eye on it."
                )
                insights.append(
                    f"Mức chi của '{top_label}' đủ lớn để tạo đà. Một vài điều chỉnh nhỏ có thể tạo khác biệt."
                    if is_vi else
                    f"'{top_label}' is big enough to move the needle. Small tweaks here could pay off."
                )
            else:
                insights.append(
                    f"Chi tiêu khá cân bằng, không có mục nào vượt trội. Đây là dấu hiệu tốt để giữ nhịp ổn định."
                    if is_vi else
                    "Spending looks balanced with no dominant category. That is a solid baseline to maintain."
                )
        top_two_rows = list(
            chart_qs.values('category__name')
            .annotate(total=Sum('amount'))
            .order_by('-total')[:2]
        )
        if len(top_two_rows) == 2:
            top_two_total = (top_two_rows[0]['total'] or 0) + (top_two_rows[1]['total'] or 0)
            top_two_share = (top_two_total / total_in_range) * 100
            if top_two_share >= 60:
                label_a = display_label(top_two_rows[0]['category__name'])
                label_b = display_label(top_two_rows[1]['category__name'])
                insights.append(
                    f"Hai mục '{label_a}' và '{label_b}' đang chiếm {top_two_share:.0f}% tổng chi. Đây là cụm nên ưu tiên tối ưu trước."
                    if is_vi else
                    f"'{label_a}' and '{label_b}' account for {top_two_share:.0f}% of total spend. Optimizing these two will have the biggest impact."
                )

        series_30 = time_series_data.get('30', {})
        values_30 = series_30.get('values', [])
        labels_30 = series_30.get('labels', [])
        if values_30:
            avg_30 = sum(values_30) / len(values_30)
            max_30 = max(values_30)
            if avg_30 > 0 and max_30 >= avg_30 * 2.5:
                max_index = values_30.index(max_30)
                spike_label = labels_30[max_index] if max_index < len(labels_30) else ''
                insights.append(
                    f"Có một ngày chi tiêu tăng vọt ({spike_label}). Bạn có thể xem lại giao dịch ngày đó để tìm nguyên nhân."
                    if is_vi else
                    f"There was a one-day spend spike ({spike_label}). Review that day to see what drove it."
                )

        active_days = chart_qs.values('date').distinct().count()
        if active_days and active_days <= 5:
            insights.append(
                f"Dữ liệu hiện mới có {active_days} ngày chi tiêu. Thêm đều đặn hơn để phân tích chính xác hơn."
                if is_vi else
                f"There are only {active_days} active spend days so far. Add more days for sharper insights."
            )
    if not insights:
        insights.append(
            "Chưa đủ dữ liệu để phân tích. Hãy thêm vài khoản chi nữa nhé."
            if is_vi else
            "Not enough data for insights yet. Add a few expenses first."
        )

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
        'filtered_total_in_view': filtered_total_in_view,
        'avg_daily_vnd': avg_daily_vnd,
        'max_category': max_category,
        'count': expenses.count(),
        'filtered_count': filters['filtered_qs'].count(),
        'page_size': filters['page_size'],
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
    lang = _get_language(request)
    is_vi = lang == 'vi'
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

    spending_profile_key = 'balanced'
    if avg_monthly and avg_monthly < 3000000:
        spending_profile_key = 'saver'
    elif avg_monthly and avg_monthly > 8000000:
        spending_profile_key = 'spender'

    if is_vi:
        spending_profile = {
            'saver': 'Tiết kiệm',
            'balanced': 'Cân bằng',
            'spender': 'Chi tiêu mạnh',
        }[spending_profile_key]
        profile_explain = {
            'saver': 'Bạn giữ mức chi tiêu hàng tháng khá thấp.',
            'balanced': 'Bạn duy trì nhịp chi tiêu ổn định.',
            'spender': 'Bạn chi tiêu cao hơn mức trung bình.',
        }[spending_profile_key]
        insight = 'Bạn có xu hướng chi nhiều hơn vào cuối tháng.'
        if total_transactions < 5:
            insight = 'Thêm nhiều giao dịch để mở khóa phân tích sâu hơn.'
    else:
        spending_profile = {
            'saver': 'Saver',
            'balanced': 'Balanced',
            'spender': 'Spender',
        }[spending_profile_key]
        profile_explain = {
            'saver': 'You keep monthly spending consistently low.',
            'balanced': 'You maintain a steady spending rhythm.',
            'spender': 'You spend above the typical monthly range.',
        }[spending_profile_key]
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
    settings, _ = UserSettings.objects.get_or_create(user=request.user)
    if request.method == 'POST':
        lang = request.POST.get('language', settings.language)
        form = UserSettingsForm(request.POST, instance=settings, language=lang)
        if form.is_valid():
            form.save()
            message = 'Đã lưu cài đặt.' if lang == 'vi' else 'Settings saved.'
            messages.success(request, message)
            return redirect('settings')
    else:
        form = UserSettingsForm(instance=settings, language=settings.language)
    return render(request, 'expenses/settings.html', {'form': form})


@login_required
@xframe_options_sameorigin
def edit_expense(request, pk):
    expense = get_object_or_404(Expense, pk=pk, user=request.user)
    form = ExpenseForm(request.POST or None, instance=expense, user=request.user)
    if form.is_valid():
        form.save()
        lang = _get_language(request)
        message = 'Đã cập nhật chi tiêu.' if lang == 'vi' else 'Expense updated successfully.'
        messages.success(request, message)
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
