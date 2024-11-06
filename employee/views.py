from django.http import JsonResponse
from django.shortcuts import redirect, render
from django.views import View
from employee.models import *
from django.views.generic import TemplateView
from django.contrib.auth import authenticate, login,logout,update_session_auth_hash
from django.contrib import messages
from django.core.validators import validate_email
from django.core.exceptions import ValidationError
from employee.helper import is_ajax, renderhelper
from employee.constant_variables import PAGINATION_COUNT
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.template import loader
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required
from django.template import loader
from django.contrib.auth.mixins import UserPassesTestMixin



class LoginView(TemplateView):
    template_name = 'dashboard/login/login.html'

    def post(self, request, *args, **kwargs):
        email = self.request.POST.get('email')
        password = self.request.POST.get('pass')
        user = authenticate(request, email=email, password=password)
        
        if user is not None:
            if user.is_active:
                login(request, user)
                welcome_message = (
                    f"Welcome to the Employee Dashboard, {user.name}!" if not user.is_admin
                    else f"Welcome to the Employee Dashboard, Admin"
                )
                messages.success(request, welcome_message)
                return redirect('employee:index')
            else:
                messages.error(request, 'You are not a verified user')
                return redirect('employee:login')
        else:
            messages.error(request, 'Invalid Credentials')
            return redirect('employee:login')

@method_decorator(login_required(login_url='/login/'),name='dispatch')
class LogoutView(TemplateView):
    template_name = 'dashboard/login/login.html'

    def get(self, request, *args, **kwargs):
        logout(request)
        return redirect('employee:login')

class RegisterView(TemplateView):
    template_name = 'dashboard/register/register.html'

    def post(self,request):
        email = self.request.POST.get('email')
        name = self.request.POST.get('name')
        position = self.request.POST.get('position')
        password = self.request.POST.get('pass')
        confirm_password = self.request.POST.get('cpass')

        try:
            validate_email(email)
        except ValidationError as e:
            messages.error(request, "Invalid email..Please try again..!!")
            return redirect('employee:register')
        
        if email and name and position and password and confirm_password:
            if password == confirm_password:
                if Employee.objects.filter(email=email).exists():
                    messages.error(request, "Email already exists")
                    return redirect('employee:register')
                else:
                    employee = Employee.objects.create_user(
                        email = email,
                        password = password
                    )
                    employee.name = name
                    employee.position = position
                    employee.save()
                    messages.success(request, "Employee created successfully")
                    return redirect('employee:login')
            else:
                messages.error(request, "Password and confirm password does not match")
                return redirect('employee:register')
        else:
            messages.error(request, "Please fill all fields")
            return redirect('employee:register')
        
        

class CheckEmailAvailability(View):
    def get(self, request, *args, **kwargs):
        email = self.request.GET.get('email')
        if Employee.objects.filter(email=email).exists():
            return JsonResponse({'status':False, 'message':'Email is not available'},status=200)
        return JsonResponse({'status':True, 'message':'Email is available'},status=200)
        

@method_decorator(login_required(login_url='/login/'),name='dispatch')
class IndexView(TemplateView):
    template_name = 'dashboard/index/index.html'

@method_decorator(login_required(login_url='/login/'),name='dispatch')
class ChangePasswordView(TemplateView):
    template_name = 'dashboard/profile/change_password.html'
    def get(self,request):
        return render(request, self.template_name)
    
    def post(self,request):
        old_password = self.request.POST.get('old_password')
        new_password1 = self.request.POST.get('new_password1')
        new_password2 = self.request.POST.get('new_password2')

        if not request.user.check_password(old_password):
            messages.error(request, 'Invalid old password.')
        elif new_password1 != new_password2:
            messages.error(request, 'New passwords do not match.')
        else:
            user = request.user
            user.set_password(new_password1)
            user.save()
            update_session_auth_hash(request, user)  # Update session with new password hash
            messages.success(request, 'Your password has been changed successfully.')
            return redirect('employee:change_password')

@method_decorator(login_required(login_url='/login/'),name='dispatch')
class ProfileView(TemplateView):
    template_name = 'dashboard/profile/profile.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        employee = Employee.objects.get(email=self.request.user.email)
        custom_fields = employee.custom_fields.all()
        context['employee'] = employee
        context['custom_fields'] = custom_fields
        return context
    

@method_decorator(login_required(login_url='/login/'),name='dispatch')
class EmployeeListView(UserPassesTestMixin,TemplateView):
    template_name = 'dashboard/employees/employee_list.html'

    def test_func(self):
        return self.request.user.is_admin

    def get(self, request, *args, **kwargs):
        context = {}
        path = "Employee"
        page = request.GET.get("page", 1)
        
        search = request.GET.get("search")
        delete = request.GET.get("delete")
        status = request.GET.get("status")
        sts = request.GET.get("sts")

        cd = Employee.objects.filter(is_admin=False).order_by('-id')

        if is_ajax(request):
            if search:
                cd = cd.filter(name__icontains=search)
            if sts:
                cd = cd.filter(is_active=sts)
            if status:
                if status == '1':
                    status = True
                else:
                    status = False
                item_id = request.GET.get("item_id")
                Employee.objects.filter(id=item_id).update(is_active=status)
            if delete:
                item_id = request.GET.get("item_id")
                try:
                    datas = Employee.objects.get(id=item_id)
                except Employee.DoesNotExist:
                    datas = None
                if datas:
                    datas.delete()
            paginator = Paginator(cd, PAGINATION_COUNT)
            try:
                datas = paginator.get_page(page)
            except PageNotAnInteger:
                datas = paginator.get_page(1)
            except EmptyPage:
                datas = paginator.get_page(paginator.num_pages)
            context['datas'] = datas
            context['page'] = page
            template = loader.get_template(self.template_name)
            html_content = template.render(context, request)
            return JsonResponse({'status': True, 'template': html_content})

        paginator = Paginator(cd, PAGINATION_COUNT)
        try:
            datas = paginator.get_page(page)
        except PageNotAnInteger:
            datas = paginator.get_page(1)
        except EmptyPage:
            datas = paginator.get_page(paginator.num_pages)
        context['datas'] = datas
        context['page'] = page
        context['path'] = path
        return renderhelper(request, 'employees', 'employee_view', context)
    

@method_decorator(login_required(login_url='/login/'),name='dispatch')
class EmployeeCreateView(UserPassesTestMixin,TemplateView):
    template_name = 'dashboard/employees/employee_create.html'

    def test_func(self):
        return self.request.user.is_admin
    
    def post(self,request):
        name = request.POST.get('name')
        email = request.POST.get('email')
        position = request.POST.get('position')
        password = request.POST.get('pass')
        confirm_password = request.POST.get('cpass')
        field_title = request.POST.getlist('field_title[]')
        field_value = request.POST.getlist('field_value[]')

        try:
            validate_email(email)
        except ValidationError as e:
            messages.error(request, "Invalid email..Please try again..!!")
            return redirect('employee:employee_create')
        
        if email and name and position and password and confirm_password:
            if password == confirm_password:
                if Employee.objects.filter(email=email).exists():
                    messages.error(request, "Email already exists")
                    return redirect('employee:employee_create')
                else:
                    employee = Employee.objects.create_user(
                        email = email,
                        password = password
                    )
                    employee.name = name
                    employee.position = position
                    employee.save()
                    if field_title and field_value:
                        for title, value in zip(field_title, field_value):
                            if title.strip() and value.strip():
                                custom_field = EmployeeCustomField(employee=employee, field_title=title.strip(), field_value=value.strip())
                                custom_field.save()
                    
                    messages.success(request, "Employee created successfully")
                    return redirect('employee:employees')
            else:
                messages.error(request, "Password and confirm password does not match")
                return redirect('employee:register')
        else:
            messages.error(request, "Please fill all fields")
            return redirect('employee:employee_create')
        
class ShowCustomFiledsView(TemplateView):
    template_name = 'dashboard/employees/custom_fields_table.html'
    def get(self,request):
        id = request.GET.get('id')
        try:
            employee = Employee.objects.get(id=id)
            if employee:
                custom_fields = EmployeeCustomField.objects.filter(employee=employee).order_by('-id')
                context = {
                    'custom_fields': custom_fields,
                    'employee': employee
                }
                template = loader.get_template(self.template_name)
                html_content = template.render(context, request)
                return JsonResponse({'status': True, 'template': html_content})
        except Employee.DoesNotExist:
            return JsonResponse({'status': False, 'message': 'Employee not found'},status=404)

class DeleteCustomFiledsView(TemplateView):
    template_name = 'dashboard/employees/custom_fields_table.html'
    def get(self,request):
        id = request.GET.get('id')
        try:
            custom_field =EmployeeCustomField.objects.get(id=id)
            custom_field.delete()

            custom_fields = EmployeeCustomField.objects.filter(employee=custom_field.employee).order_by('-id')
            context = {
                'custom_fields': custom_fields,
                'employee': custom_field.employee
            }

            template = loader.get_template(self.template_name)
            html_content = template.render(context, request)
            return JsonResponse({'status': True, 'template': html_content})
        except EmployeeCustomField.DoesNotExist:
            return JsonResponse({'status': False, 'message': 'Field not found'},status=404)


@method_decorator(login_required(login_url='/login/'),name='dispatch')
class EmployeeUpdateView(UserPassesTestMixin,TemplateView):
    template_name = 'dashboard/employees/employee_create.html'

    def test_func(self):
        return self.request.user.is_admin

    def get(self, request, id):
        data = Employee.objects.get(pk=id)
        custom_fields = data.custom_fields.all()
        return render(request, self.template_name, {'list': data,'custom_fields':custom_fields})

    def post(self,request,id):
        data = Employee.objects.get(pk=id)
        name = request.POST.get('name')
        email = request.POST.get('email')
        position = request.POST.get('position')
        field_title = request.POST.getlist('field_title[]')
        field_value = request.POST.getlist('field_value[]')

        data.name = name
        data.email = email
        data.position = position
        data.save()
        existing_custom_fields = EmployeeCustomField.objects.filter(employee=data)
        existing_custom_fields.delete()
        if field_title and field_value:
            for title, value in zip(field_title, field_value):
                if title.strip() and value.strip(): 
                    custom_field = EmployeeCustomField(employee=data, field_title=title.strip(), field_value=value.strip())
                    custom_field.save()

        messages.success(request, "Employee updated successfully")
        return redirect('employee:employees')
    

class DeleteFieldView(View):
    def get(self,request):
        id = request.GET.get('id')
        try:
            field = EmployeeCustomField.objects.get(id=id)
            field.delete()
            return JsonResponse({'status': True, 'message': 'Field deleted successfully'})
        except EmployeeCustomField.DoesNotExist:
            return JsonResponse({'status': False, 'message': 'Field not found'})