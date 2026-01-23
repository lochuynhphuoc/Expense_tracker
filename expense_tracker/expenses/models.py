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
