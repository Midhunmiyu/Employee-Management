from django.urls import path
from employee.views import *

app_name = 'employee'

urlpatterns = [
   path('',LoginView.as_view(),name='login'),

   path('register/',RegisterView.as_view(),name='register'),
   path('check-email-availability/',CheckEmailAvailability.as_view(),name='check_email_availability'),
   
   path('profile/',ProfileView.as_view(),name='profile'),
   path('change-password/',ChangePasswordView.as_view(),name='change_password'),
   path('logout/',LogoutView.as_view(),name='logout'),

   path('dashboard/',IndexView.as_view(),name='index'),

   path('employees/',EmployeeListView.as_view(),name='employees'),
   path('employee-create/',EmployeeCreateView.as_view(),name='employee_create'),
   path('show-custom-fields/',ShowCustomFiledsView.as_view(),name='show_custom_fields'),
   path('delete-custom-field/',DeleteCustomFiledsView.as_view(),name='delete_custom_fields'),
   path('employee-update/<int:id>',EmployeeUpdateView.as_view(),name='employee_update'),
   path('delete-field/',DeleteFieldView.as_view(),name='delete_field'),
]