from django.db import models
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser

class EmployeeManager(BaseUserManager):
    def create_user(self, email, password=None):
        """
        Creates and saves a User with the given email and password.
        """
        if not email:
            raise ValueError("Employees must have an email address")

        user = self.model(
            email=self.normalize_email(email),
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None):
        """
        Creates and saves a superuser with the given email and password.
        """
        user = self.create_user(
            email,
            password=password,
        )
        user.is_admin = True
        user.save(using=self._db)
        return user



class Employee(AbstractBaseUser):
    email = models.EmailField(verbose_name='email address',max_length=255,unique=True)
    name = models.CharField(max_length=200,null=True,blank=True)
    position = models.CharField(max_length=100,null=True,blank=True)

    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)

    objects = EmployeeManager()

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    @property
    def is_staff(self):
        "Is the user a member of staff?"
        # Simplest possible answer: All admins are staff
        return self.is_admin

class EmployeeCustomField(models.Model):
    employee = models.ForeignKey(Employee, on_delete=models.CASCADE,related_name='custom_fields')
    field_title = models.CharField(max_length=100,null=True,blank=True)
    field_value = models.CharField(max_length=255,null=True,blank=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.employee.name} - {self.field_title} : {self.field_value}'
