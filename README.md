# How to run

## 1.create a virtual environment
Create a virtual environment and activate it using the commands provided below.
```bash
py -m venv venv

source venv/Scripts/activate
```
## 2.clone the project
```bash
git clone https://github.com/Midhunmiyu/Employee-Management.git

cd Employee_Management/
```

## 3.Installation

```bash
pip install -r requirements.txt
```

## 4.Database
I use PostgreSQL as my database. Please adjust the database settings accordingly to match your configuration.


```bash
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'employee_management',
        'USER': 'postgres',
        'PASSWORD': '8157',
        'HOST': 'localhost',
        'PORT': '5432'
    }
}
```
Next, import my database schema file named employee_management.sql into your database. After the import, run the migration command.

```bash
python manage.py migrate
```
## 4.Run project
```python
python manage.py runserver

```

## Test API
I've provided the Postman collections file for you. You can import it into Postman to test the API.
