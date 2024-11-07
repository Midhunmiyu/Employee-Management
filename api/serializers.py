from rest_framework import serializers
from employee.models import *
from django.core.validators import validate_email
from django.core.exceptions import ValidationError



class EmployeeCustomFieldSerializer(serializers.ModelSerializer):
    class Meta:
        model = EmployeeCustomField
        fields = ['id', 'field_title', 'field_value','created_at','updated_at']

class EmployeeSerializer(serializers.ModelSerializer):
    custom_fields = EmployeeCustomFieldSerializer(many=True,required=False)
    confirm_password = serializers.CharField(write_only=True)
    class Meta:
        model = Employee
        fields = ['id','email', 'name', 'position','password','confirm_password','is_active','is_admin','custom_fields']
        extra_kwargs = {
            'password': {'write_only': True},
            'confirm_password': {'write_only': True},
        }

    def validate(self, data):
        # print(data,'def validate***')
        password = data.get('password')
        confirm_password = data.get('confirm_password')
        name = data.get('name')
        email = data.get('email')
        position = data.get('position')
        if not email:
            raise serializers.ValidationError("Email is required")
        try:
            validate_email(email)
        except ValidationError:
            raise serializers.ValidationError("Invalid email")
        if not name:
            raise serializers.ValidationError("Name is required")
        if not position:
            raise serializers.ValidationError("Position is required")
        if not password:
            raise serializers.ValidationError("Password is required")
        if not confirm_password:
            raise serializers.ValidationError("Confirm password is required")
        if password != confirm_password:
            raise serializers.ValidationError("Password and confirm_password does not match")
        return data

    def create(self, validated_data):
        email = validated_data.get('email')
        name = validated_data.get('name')
        position = validated_data.get('position')
        password = validated_data.pop('password')
        employee = Employee.objects.create_user(
            email=email,
            password=password
        )
        employee.name = name
        employee.position = position
        employee.save()
        custom_fields = validated_data.pop('custom_fields',None)
        if custom_fields is not None:
            for field in custom_fields:
                field_title = field.get('field_title')
                field_value = field.get('field_value')
                if field_title.strip() and field_value.strip():
                    EmployeeCustomField.objects.create(employee=employee, field_title=field_title, field_value=field_value)
            
        return employee
    
class EmployeeEditSerializer(serializers.ModelSerializer):
    custom_fields = EmployeeCustomFieldSerializer(many=True,required=False)
    name = serializers.CharField(required=False)
    position = serializers.CharField(required=False)
    class Meta:
        model = Employee
        fields = ['id','email', 'name', 'position','is_active','is_admin','custom_fields']

    def validate(self, data):
        name = data.get('name',None)
        email = data.get('email',None)
        position = data.get('position',None)
        if name and name.strip() == '':
            raise serializers.ValidationError("Name cannot be empty")
        if email and self.instance.email != email:
            raise serializers.ValidationError("Email cannot be changed")
        if position and position.strip() == '':
            raise serializers.ValidationError("Position cannot be empty")
        return data
    
    def update(self,instance,validated_data):
        name = validated_data.get('name',None)
        position = validated_data.get('position',None)
        if name is not None:
            instance.name = name
        if position is not None:
            instance.position = position
        instance.save()
        custom_fields = validated_data.pop('custom_fields',None)
        if custom_fields:
            # existing_custom_fields = EmployeeCustomField.objects.filter(employee=instance)
            # existing_custom_fields.delete()
            for field in custom_fields:
                field_title = field.get('field_title')
                field_value = field.get('field_value')
                if field_title.strip() and field_value.strip():
                    EmployeeCustomField.objects.create(employee=instance, field_title=field_title, field_value=field_value)
        return instance