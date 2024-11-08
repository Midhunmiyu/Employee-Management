from faker import Faker
from employee.models import Employee

fake = Faker()

def create_employees(count):
    for i in range(count):
        employee = Employee.objects.create_user(
            email=fake.email(),
            password='12'
        )
        employee.name = fake.name() 
        employee.position = fake.job()
        employee.save()
    print('Employees created successfully')