from django.contrib import admin
from .models import Category, Expense

@admin.register(Expense)
class ExpenseAdmin(admin.ModelAdmin):
    list_display = ('user', 'category', 'amount', 'date')
    list_filter = ('date', 'category')

admin.site.register(Category)
