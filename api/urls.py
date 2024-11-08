from django.urls import path
from api.views import *
from rest_framework_simplejwt.views import TokenRefreshView


urlpatterns = [
    path('login/',LoginViewSet.as_view(),name='login'),
    path('register/',RegisterViewSet.as_view(),name='register'),
    path('refresh/',TokenRefreshView.as_view(),name='token_refresh'),
    path('reset-password/',ResetPasswordViewSet.as_view(),name='reset_password'),
    path('logout/',LogoutViewSet.as_view(),name='logout'),

    path('employee/',EmployeeViewSet.as_view(),name='employee'),
    path('delete-employee-custom-field/',DeleteEmployeeCustomField.as_view(),name='delete_employee_custom_field'),
    path('profile/',EmployeeProfileViewSet.as_view(),name='employee_profile'),
]