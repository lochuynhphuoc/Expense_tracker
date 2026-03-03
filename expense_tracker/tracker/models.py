from django.db import models
from django.contrib.auth.models import User

class Category(models.Model):
    name = models.CharField(max_length=100)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.name

    def display_label(self):
        if not self.name:
            return ''
        if ' - ' in self.name:
            head, tail = self.name.rsplit(' - ', 1)
            return f"{head}: {tail}"
        return self.name

class Expense(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    currency = models.CharField(max_length=3, default='VND')
    date = models.DateField()
    description = models.TextField(blank=True)

    def __str__(self):
        return f"{self.amount} - {self.category}"

    @property
    def category_label(self):
        if not self.category:
            return 'Chưa phân loại'
        return self.category.display_label()


class UserSettings(models.Model):
    WEEK_START_CHOICES = [
        ('monday', 'Monday'),
        ('sunday', 'Sunday'),
    ]
    INSIGHT_STRICTNESS_CHOICES = [
        ('chill', 'Chill'),
        ('balanced', 'Balanced'),
        ('strict', 'Strict'),
    ]
    THEME_CHOICES = [
        ('system', 'System'),
        ('light', 'Light'),
        ('dark', 'Dark'),
    ]
    LANGUAGE_CHOICES = [
        ('en', 'English'),
        ('vi', 'Vietnamese'),
    ]

    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='settings')
    budget_warning = models.BooleanField(default=True)
    insight_reminders = models.BooleanField(default=True)
    monthly_budget = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    week_start = models.CharField(max_length=10, choices=WEEK_START_CHOICES, default='monday')
    ai_auto_categorization = models.BooleanField(default=True)
    insight_strictness = models.CharField(max_length=10, choices=INSIGHT_STRICTNESS_CHOICES, default='balanced')
    theme = models.CharField(max_length=10, choices=THEME_CHOICES, default='system')
    language = models.CharField(max_length=5, choices=LANGUAGE_CHOICES, default='en')

    def __str__(self):
        return f"Settings for {self.user.username}"
