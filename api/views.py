from rest_framework.permissions import IsAuthenticated,AllowAny,IsAdminUser
from rest_framework.views import APIView
from employee.models import *
from api.serializers import *
from rest_framework.response import Response
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework import status
from django.contrib.auth import authenticate
from rest_framework_simplejwt.tokens import RefreshToken
from api.pagination import CustomPagination
from api.renderers import UserRenderer


class RegisterViewSet(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        data = request.data
        try:
            serializer = EmployeeSerializer(data=data)
            if serializer.is_valid():
                serializer.save()
                return Response({'status': 'success','message': 'Registration done successfully','data':serializer.data}, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({'status': 'error','message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    

class LoginViewSet(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        email = request.data.get('email')
        password = request.data.get('password')
        if not email or not password:
            return Response({'status': 'error','message': 'Email and password are required'}, status=status.HTTP_400_BAD_REQUEST)
        try:
            user = authenticate(request, email=email, password=password)
            if user is not None and user.is_active:
                refresh = RefreshToken.for_user(user)
                access_token = str(refresh.access_token)
                refresh_token = str(refresh)
                return Response({'status': 'success','message': 'Login successfully', 'access_token': access_token, 'refresh_token': refresh_token}, status=status.HTTP_200_OK)
            else:
                return Response({'status': 'error','message': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)
        except Exception as e:
            return Response({'status': 'error','message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        

class LogoutViewSet(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def post(self, request):
        try:
            refresh_token = request.data.get('refresh_token')
            token = RefreshToken(refresh_token)
            token.blacklist()
            return Response({'status': 'success','message': 'Logout successfully'}, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({'status': 'error','message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
class ResetPasswordViewSet(APIView):
    renderer_classes = [UserRenderer]
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def post(self,request):
        try:
            data = request.data
            user = request.user
            serializer = ResetPasswordSerializer(user, data=data)
            if serializer.is_valid():
                serializer.save()
                return Response({'status': 'success','message': 'Password reset successfully'}, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e :
            return Response({'status': 'error','message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    

class EmployeeViewSet(APIView):
    renderer_classes = [UserRenderer]
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAdminUser]

    def get(self, request):
        try:
            employee_id = request.query_params.get('id')
            if employee_id:
                try:
                    employee = Employee.objects.get(id=employee_id)
                    serializer = EmployeeSerializer(employee)
                    return Response({'status': 'success', 'message': 'Employee data retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)
                except Employee.DoesNotExist:
                    return Response({'status': 'error', 'message': 'Employee not found'}, status=status.HTTP_404_NOT_FOUND)
            employees = Employee.objects.all().order_by('-id')
            paginator = CustomPagination()
            paginated_data = paginator.paginate_queryset(employees, request)
            serializer = EmployeeSerializer(paginated_data, many=True)
            response_data = {
                'status': 'success',
                'message': 'Employees data retrieved successfully',
                'data': serializer.data,
                'count': paginator.page.paginator.count,
                'next': paginator.get_next_link(),
                'previous': paginator.get_previous_link()

            }
            return Response(response_data,status=status.HTTP_200_OK)
        except Exception as e:
            return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    def post(self, request):
        try:
            data = request.data
            serializer = EmployeeSerializer(data=data)
            if serializer.is_valid():
                serializer.save()
                return Response({'status': 'success', 'message': 'Employee created successfully', 'data': serializer.data}, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    def patch(self, request):
        employee_id = request.query_params.get('id')
        data = request.data
        try:
            if employee_id:
                try:
                    employee = Employee.objects.get(id=employee_id)
                    serializer = EmployeeEditSerializer(employee, data=data, partial=True)
                    if serializer.is_valid():
                        serializer.save()
                        return Response({'status': 'success', 'message': 'Employee updated successfully', 'data': serializer.data}, status=status.HTTP_200_OK)
                    
                    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                except Employee.DoesNotExist:
                    return Response({'status': 'error', 'message': 'Employee not found'}, status=status.HTTP_404_NOT_FOUND)
            return Response({'status': 'error', 'message': 'Employee ID is required'}, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    def delete(self,request):
        try:
            employee_id = request.query_params.get('id')
            try:
                if employee_id:
                    employee = Employee.objects.get(id=employee_id)
                    employee.delete()
                    return Response({'status': 'success', 'message': 'Employee deleted successfully'}, status=status.HTTP_200_OK)
                return Response({'status': 'error', 'message': 'Employee ID is required'}, status=status.HTTP_400_BAD_REQUEST)
            except Employee.DoesNotExist:    
                return Response({'status': 'error', 'message': 'Employee not found'}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
class DeleteEmployeeCustomField(APIView):
    renderer_classes = [UserRenderer]
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAdminUser]

    def delete(self,request):
        try:
            custom_field_id = request.query_params.get('id')
            try:
                field = EmployeeCustomField.objects.get(id=custom_field_id)
                field.delete()
                return Response({'status': 'success', 'message': 'Field deleted successfully'}, status=status.HTTP_200_OK)
            except EmployeeCustomField.DoesNotExist:
                return Response({'status': 'error', 'message': 'Field not found'}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
class EmployeeProfileViewSet(APIView):
    renderer_classes = [UserRenderer]
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request):
        try:
            user = request.user
            serializer = EmployeeSerializer(user)
            return Response({'status': 'success', 'message': 'Employee data retrieved successfully', 'data': serializer.data}, status=status.HTTP_200_OK)
        except Exception as e :
            return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
    def patch(self, request):
        try:
            user = request.user
            data = request.data
            serializer = ProfileEditSerializer(user, data=data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response({'status': 'success', 'message': 'Profile updated successfully', 'data': serializer.data}, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)