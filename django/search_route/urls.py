from django.urls import path
from search_route.views import AllRoutesAPIView, CreateRouteAPIView, RouteAPIView, DeleteRouteAPIView, UpdateAPIView, PublishedRoutesAPIView, VisitedRoutesAPIView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path("all", AllRoutesAPIView.as_view(), name = "all_routes"), # returns all routes of ALL USERS
    path("published", PublishedRoutesAPIView.as_view(), name = "published_routes"), # returns all PUBLISHED routes of USER
    path("visited", VisitedRoutesAPIView.as_view(), name = "visited_routes"), # returns all VISITED routes of USER
    path("visited/link", VisitedRoutesAPIView.as_view(), name = "visited_routes"), # returns all VISITED routes of USER
    path("create", CreateRouteAPIView.as_view(), name = "create_route"), # creates a new route for USER
    path("<route_id>", RouteAPIView.as_view(), name="retrieve_route"),
    path("delete/<id>", DeleteRouteAPIView.as_view(), name="retrieve_route"),
    path("update/<id>", UpdateAPIView.as_view(), name="update_route"), # updates a route for USER
]

urlpatterns += static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)