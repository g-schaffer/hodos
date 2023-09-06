from django.contrib import admin

from .models import Route, Rating

class RouteAdmin(admin.ModelAdmin):
    readonly_fields = ('id',)

class RatingAdmin(admin.ModelAdmin):
    readonly_fields = ('user','route', 'rating')

admin.site.register(Route, RouteAdmin)
admin.site.register(Rating)