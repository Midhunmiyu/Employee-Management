from django.contrib import admin
from employee.models import *

@admin.register(Employee)
class EmployeeAdmin(admin.ModelAdmin):
    list_display = ['id','email', 'name', 'position','is_active','is_admin']


@admin.register(EmployeeCustomField)
class EmployeeCustomFieldAdmin(admin.ModelAdmin):
    list_display = ['id','employee', 'field_title', 'field_value','created_at','updated_at']