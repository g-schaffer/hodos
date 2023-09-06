from rest_framework import permissions

class UserID(permissions.BasePermission):

    def has_object_permission(self, request, view, obj):
        return obj.user == request.user

class RouteID(permissions.BasePermission):

    def has_object_permission(self, request, view, obj):
        return obj.route == request.route