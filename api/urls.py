from django.urls import path
from api.views import *


urlpatterns = [
    path('login/',LoginViewSet.as_view(),name='login'),
    path('register/',RegisterViewSet.as_view(),name='register'),
    path('employee/',EmployeeViewSet.as_view(),name='employee'),
    path('delete-employee-custom-field/',DeleteEmployeeCustomField.as_view(),name='delete_employee_custom_field'),
]