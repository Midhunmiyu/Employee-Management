from rest_framework.permissions import BasePermission

class IsNotAdminUser(BasePermission):
    def has_permission(self, request, view):
        return request.user and request.user.is_authenticated and not request.user.is_admin