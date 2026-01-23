from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.db.models import Sum
from django.utils import timezone
from datetime import datetime
from django.core.paginator import Paginator
from .models import Expense, Category
from .forms import ExpenseForm, CATEGORY_GROUPS
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import login, logout
from django.contrib.auth.views import LoginView

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
def add_expense(request):
    form = ExpenseForm(request.POST or None, user=request.user)
    if form.is_valid():
        expense = form.save(commit=False)
        expense.user = request.user
        expense.save()
        messages.success(request, 'Expense added successfully.')
        return redirect('expense_list')
    return render(request, 'expenses/add_expense.html', {'form': form})

@login_required
def expense_list(request):
    category_group = request.GET.get('category_group', '')
    date_mode = request.GET.get('date_mode', '')
    day = request.GET.get('day', '')
    month = request.GET.get('month', '')
    year = request.GET.get('year', '')
    amount_sort = request.GET.get('amount_sort', '')

    period_qs = Expense.objects.filter(user=request.user)

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

    if category_group:
        filtered_qs = period_qs.filter(category__name__startswith=f"{category_group} - ")
    else:
        filtered_qs = period_qs

    order_by = ['-date']
    if amount_sort == 'asc':
        order_by = ['amount', '-date']
    elif amount_sort == 'desc':
        order_by = ['-amount', '-date']

    expenses = filtered_qs.order_by(*order_by)
    paginator = Paginator(expenses, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    all_vnd_expenses = Expense.objects.filter(user=request.user, currency='VND')
    total_amount = all_vnd_expenses.aggregate(total=Sum('amount'))['total'] or 0
    today = timezone.localdate()
    vnd_expenses = filtered_qs.filter(currency='VND')
    month_total = all_vnd_expenses.filter(date__year=today.year, date__month=today.month).aggregate(total=Sum('amount'))['total'] or 0
    chart_rows = (
        all_vnd_expenses
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
    category_groups_with_counts = []
    for group in CATEGORY_GROUPS.keys():
        count = period_qs.filter(category__name__startswith=f"{group} - ").count()
        category_groups_with_counts.append({'name': group, 'count': count})

    context = {
        'expenses': page_obj,
        'page_obj': page_obj,
        'total_amount': total_amount,
        'month_total': month_total,
        'count': expenses.count(),
        'category_group': category_group,
        'date_mode': date_mode,
        'day': day,
        'month': month,
        'year': year,
        'amount_sort': amount_sort,
        'category_groups_with_counts': category_groups_with_counts,
        'chart_labels': chart_labels,
        'chart_values': chart_values,
    }
    return render(request, 'expenses/expense_list.html', context)


@login_required
def edit_expense(request, pk):
    expense = get_object_or_404(Expense, pk=pk, user=request.user)
    form = ExpenseForm(request.POST or None, instance=expense, user=request.user)
    if form.is_valid():
        form.save()
        messages.success(request, 'Expense updated successfully.')
        return redirect('expense_list')
    return render(request, 'expenses/edit_expense.html', {'form': form, 'expense': expense})


@login_required
def delete_expense(request, pk):
    expense = get_object_or_404(Expense, pk=pk, user=request.user)
    if request.method == 'POST':
        expense.delete()
        messages.success(request, 'Expense deleted successfully.')
        return redirect('expense_list')
    return render(request, 'expenses/delete_expense.html', {'expense': expense})
