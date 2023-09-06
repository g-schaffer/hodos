from django.urls import path
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    # path("", RoutesAPIView.as_view(), name = "routes"),
    # path("<int:id>", RouteDetailAPIView.as_view(), name="route"),
    # path("interest", PointOfRouteAPIView.as_view(), name = "create_route"),
    # # path('list', RouteListAPIView.as_view(), name= "list_routes"),
    # path("<int:id>", PointOfRouteDetailAPIView.as_view(), name="update_route"),
    # # path("<int:id>", DeleteRouteAPIView.as_view(), name="delete_route")

]

urlpatterns += static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)