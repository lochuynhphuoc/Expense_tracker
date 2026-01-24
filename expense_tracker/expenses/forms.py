from datetime import date
from decimal import Decimal, InvalidOperation
from django import forms
from .models import Expense, Category


CATEGORY_GROUPS = {
    'Thực phẩm - Đồ uống': [
        'Nguyên liệu thực phẩm',
        'Bánh và đồ uống',
        'Nhà hàng quán ăn',
    ],
    'Sinh hoạt - Tiện ích': [
        'Điện',
        'Nước',
        'Xăng dầu',
        'Truyền hình - Viễn thông',
        'Tạp hoá',
        'Phí dịch vụ căn hộ',
        'Thuê nhà',
        'Tiện ích khác',
    ],
    'Con cái - Gia đình': [
        'Trẻ em & người lớn tuổi',
        'Vật nuôi',
        'Tiêu vặt',
        'Học phí',
        'Hỗ trợ giáo dục',
        'Nội thất & thiết bị',
        'Tôn giáo & tâm linh',
    ],
    'Mua sắm': [
        'Quần áo & phụ kiện',
        'Đồ gia dụng',
        'Mua sắm trực tiếp',
        'Siêu thị/TTTM',
        'Sản phẩm cao cấp',
        'Thiết bị điện tử',
        'Hoa tươi & quà tặng',
        'Mua sẵm khác',
    ],
    'Sức khoẻ & Làm đẹp': [
        'Dược phẩm & y tế',
        'Thể dục thể thao',
        'Làm đẹp & Spa',
        'Khám chữa bệnh',
    ],
    'Đi lại & Giao thông': [
        'Phí giao thông & chuyển phát',
        'Phương tiện đi lại',
    ],
    'Giải trí & Du lịch': [
        'Dịch vụ lưu trú',
        'Du lịch & điểm vui chơi',
        'Phim ảnh & sự kiện',
        'Trò chơi',
    ],
    'Chi phí tài chỉnh': [
        'Trả nợ thẻ tín dụng',
        'Trả nợ vay',
        'Tài chỉnh khác',
    ],
    'Tăng quà & Từ thiện': [
        'Thiện nguyện',
        'Cho tặng',
        'Hiếu hỉ'
    ],
    'Tiết kiệm & Đầu tư': [
        'Tiết kiệm',
        'Đầu tư',
        'Cho vay',
        'Bảo hiểm nhân thọ',
    ],
    'Khác': [
        'Chi phí khác',
        'Chưa phân loại',
        'Dịch vụ công',
        'Hỗ trợ kinh doanh',
        'Phí thường niên',
    ],
}

CURRENCY_CHOICES = [
    ('VND', 'VNĐ'),
    ('USD', 'USD'),
    ('EUR', 'EUR'),
    ('JPY', 'JPY'),
    ('KRW', 'KRW'),
]

CATEGORY_KEYWORDS = {
    'Thực phẩm - Đồ uống - Bánh và đồ uống': [
        'highlands', 'starbucks', 'coffee', 'cafe', 'trà sữa', 'sua', 'tea', 'matcha', 'latte'
    ],
    'Thực phẩm - Đồ uống - Nhà hàng quán ăn': [
        'ăn', 'an', 'cơm', 'com', 'bún', 'bun', 'phở', 'pho', 'nhà hàng', 'quán', 'restaurant', 'food'
    ],
    'Đi lại & Giao thông - Phương tiện đi lại': [
        'grab', 'uber', 'taxi', 'bus', 'xe buýt', 'xe buyt', 'xe ôm', 'xăng', 'xang', 'đổ xăng'
    ],
    'Mua sắm - Siêu thị/TTTM': [
        'siêu thị', 'sieu thi', 'coop', 'vinmart', 'lotte', 'aeon', 'mm mega'
    ],
    'Sức khoẻ & Làm đẹp - Dược phẩm & y tế': [
        'thuốc', 'thuoc', 'pharmacy', 'nhà thuốc', 'drug', 'y tế', 'y te'
    ],
    'Sức khoẻ & Làm đẹp - Khám chữa bệnh': [
        'khám', 'kham', 'bệnh viện', 'benh vien', 'clinic', 'doctor'
    ],
}


def seed_default_categories(user):
    for group, items in CATEGORY_GROUPS.items():
        for item in items:
            Category.objects.get_or_create(
                user=user,
                name=f"{group} - {item}",
            )

class ExpenseForm(forms.ModelForm):
    currency = forms.ChoiceField(choices=CURRENCY_CHOICES)

    class Meta:
        model = Expense
        fields = ['category', 'amount', 'currency', 'date', 'description']
        widgets = {
            'date': forms.DateInput(format='%d/%m/%Y', attrs={'placeholder': 'dd/mm/yyyy', 'class': 'input datepicker'}),
        }

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user', None)
        super().__init__(*args, **kwargs)
        self.user = user
        if user:
            seed_default_categories(user)
            self.fields['category'].queryset = Category.objects.filter(user=user).order_by('name')
            grouped_choices = []
            for group, items in CATEGORY_GROUPS.items():
                group_choices = []
                for item in items:
                    name = f"{group} - {item}"
                    category = self.fields['category'].queryset.filter(name=name).first()
                    if category:
                        group_choices.append((category.id, item))
                if group_choices:
                    grouped_choices.append((group, group_choices))
            self.fields['category'].choices = [('', 'Select a category')] + grouped_choices
        self.fields['category'].required = False
        self.fields['amount'].widget.attrs.update({
            'inputmode': 'numeric',
            'placeholder': '0',
            'autocomplete': 'off',
        })
        self.fields['amount'].widget = forms.TextInput(attrs=self.fields['amount'].widget.attrs)
        self.fields['date'].input_formats = ['%d/%m/%Y']
        self.fields['date'].initial = date.today().strftime('%d/%m/%Y')
        self.fields['currency'].initial = 'VND'
        for field in self.fields.values():
            existing_class = field.widget.attrs.get('class', '')
            field.widget.attrs['class'] = (existing_class + ' input').strip()

    def clean_amount(self):
        raw = str(self.cleaned_data.get('amount', '')).replace(',', '').strip()
        try:
            return Decimal(raw)
        except (InvalidOperation, ValueError):
            raise forms.ValidationError('Số tiền không hợp lệ.')

    def clean_category(self):
        category = self.cleaned_data.get('category')
        if category:
            return category
        if not self.user:
            return category

        description = (self.cleaned_data.get('description') or '').lower()
        if description:
            for category_name, keywords in CATEGORY_KEYWORDS.items():
                if any(keyword in description for keyword in keywords):
                    matched, _ = Category.objects.get_or_create(user=self.user, name=category_name)
                    return matched

        default_name = 'Khác - Chưa phân loại'
        category, _ = Category.objects.get_or_create(user=self.user, name=default_name)
        return category
