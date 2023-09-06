from django.urls import path
from point_of_route.views import  PointOfRouteAPIView, PointOfRouteDetailAPIView, FullRoutesAPIView


urlpatterns = [
    path("interest", PointOfRouteAPIView.as_view(), name = "create_point_of_route"),
    path("<int:id>", PointOfRouteDetailAPIView.as_view(), name="update_point_of_route"),
    path("from_route_id/<route_id>", FullRoutesAPIView.as_view(), name="get_points_of_route"),
]

