from django.contrib import admin
from django.urls import path, include
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi

# use to get media files (images)
from django.conf.urls.static import static
from django.conf import settings

schema_view = get_schema_view(
   openapi.Info(
      title="Hodos backend API",
      default_version='v1',
      description="Test description",
      terms_of_service="https://www.google.com/policies/terms/",
      contact=openapi.Contact(email="contact@hodos-app.local"),
      license=openapi.License(name="BSD License"),
   ),
   public=True,
   permission_classes=[permissions.AllowAny],
   authentication_classes=[]
)

urlpatterns = [
   
   path('swagger.json', schema_view.without_ui(cache_timeout=0), name='schema-json'),
   path('', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
   path('redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),

   path('admin/', admin.site.urls),
   path('api/auth/', include('user_management.urls')), 
   path('api/routes/', include("search_route.urls")),
   path('api/point_of_interest/', include("point_of_interest.urls")),
   path('api/point_of_route/', include("point_of_route.urls")),
   path('api/reviews/', include("review.urls")),
   
    # path("", include("navigation.urls")),

   # path('social_auth/', include(('social_auth.urls', 'social_auth'),
   #                               namespace="social_auth")),

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
