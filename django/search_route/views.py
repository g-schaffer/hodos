from django.shortcuts import render
from rest_framework.generics import ListCreateAPIView, ListAPIView, RetrieveUpdateDestroyAPIView, CreateAPIView
from search_route.serializers import RouteSerializer, DetailRouteSerializer
from rest_framework.permissions import IsAuthenticated
from .permissions import UserID
from rest_framework.parsers import MultiPartParser, FormParser
from .models import Route
from rest_framework import response, status, permissions, views
from rest_framework import viewsets
from user_management.models import User
from .models import Route, Rating
from django.urls import reverse
from point_of_route.views import FullRoutesAPIView
from point_of_route.models import Point_of_route
from user_management.serializes import UserSerializer
import json

# get all routes without points of route
class AllRoutesAPIView(ListAPIView):

    serializer_class = RouteSerializer
    permission_classes = (IsAuthenticated, )
    parser_classes = [MultiPartParser, FormParser]

    def get(self, serializer):
        all_routes = Route.objects.all()
        serializer = self.serializer_class(all_routes, many= True)
        data = serializer.data
        return response.Response(data, status=status.HTTP_201_CREATED)


# create route
class CreateRouteAPIView(CreateAPIView):

    permission_classes = (IsAuthenticated, )
    parser_classes = [MultiPartParser, FormParser]

    def post(self, request, format = None):
        new_data = request.data
        user = User.objects.get(id=request.user.id)
        route = Route(name=request.data.get("name"), description=request.data.get("description"), image=request.data.get('image'), user_id=user.id)
        route.save()
        print(route)
        points = json.loads(request.data.get("points"))
        print("route id => "+ str(route.id))

        for point in points:
            Point_of_route(latitude=point["latitude"], longitude=point["longitude"], index=point["index"], route_id=route.id).save()
        route.save()
        return response.Response("route created !", status=status.HTTP_201_CREATED)

# get route with points of route
class RouteAPIView(views.APIView):
    
    permission_classes = (IsAuthenticated, UserID, )
    parser_classes = [MultiPartParser, FormParser]

    def get(self, request, route_id):
        route = Route.objects.get(id=route_id)
        points = FullRoutesAPIView().get(route_id=route_id).data
        self.get_rating(route_id)
        return response.Response({
                "id": route.id,
                "name": route.name,
                "description": route.description,
                "avg_time": route.avg_time,
                "user" : UserSerializer(route.user).data,
                "travelled_by" : str(route.visited_user.all().count()),
                "note": self.get_rating(route_id),
                "points": points
            })

    def get_rating(self, route_id):
        try:

            all_rating = Rating.objects.filter(route=route_id)
            sum_rating = 0
            n_rating = all_rating.all().count()
            for rating in all_rating:
                sum_rating += rating.rating
            return int(sum_rating/n_rating)
            
        except Exception as e:
            print(e)
            return -1

        
# delete route
class DeleteRouteAPIView(views.APIView):
    
    permission_classes = (IsAuthenticated, UserID, )
    parser_classes = [MultiPartParser, FormParser]

    def delete(self, request, id):
        try:
            route = Route.objects.get(id=id)
        except:
            return response.Response("route not found !", status=status.HTTP_404_NOT_FOUND)
        
        user = User.objects.get(id=request.user.id)
        if route.user_id == user.id:
            route.delete()
        else:
            return response.Response("you are not allowed to delete this route !", status=status.HTTP_401_UNAUTHORIZED)
        
        return response.Response("route deleted !", status=status.HTTP_200_OK)


# update route
class UpdateAPIView(views.APIView):

    permission_classes = (IsAuthenticated, UserID, )
    parser_classes = [MultiPartParser, FormParser]

    def put(self, request, id):
        try:
            route = Route.objects.get(id=id)
        except:
            return response.Response("route not found !", status=status.HTTP_404_NOT_FOUND)
        
        user = User.objects.get(id=request.user.id)

        if not request.data.get("name") or not request.data.get("description") or not request.data.get("image"):
            return response.Response("please fill in all the fields !", status=status.HTTP_400_BAD_REQUEST)

        if route.user_id == user.id:
            route.name = request.data.get("name")
            route.description = request.data.get("description")
            route.image = request.data.get("image")
            route.save()
        else:
            return response.Response("you are not allowed to update this route !", status=status.HTTP_401_UNAUTHORIZED)
        
        return response.Response("route updated !", status=status.HTTP_200_OK)


    def patch(self, request, id):
        try:
            route = Route.objects.get(id=id)
        except:
            return response.Response("route not found !", status=status.HTTP_404_NOT_FOUND)
        
        user = User.objects.get(id=request.user.id)
        if route.user_id == user.id:
            print(request.data)
            route.name = request.data.get("name")
            route.description = request.data.get("description")
            route.image = request.data.get("image")
            route.save()
        else:
            return response.Response("you are not allowed to update this route !", status=status.HTTP_401_UNAUTHORIZED)
        
        return response.Response("route updated !", status=status.HTTP_200_OK)

# get all published routes of a user
class PublishedRoutesAPIView(views.APIView):

    permission_classes = (IsAuthenticated, UserID, )
    parser_classes = [MultiPartParser, FormParser]

    def get(self, request):
        all_routes = Route.objects.all().filter(user_id=request.user.id)
        serializer = self.serializer_class(all_routes, many= True)
        data = serializer.data
        return response.Response(data, status=status.HTTP_201_CREATED)

# get all visited routes of a user
class VisitedRoutesAPIView(views.APIView):

    serializer_class = RouteSerializer
    permission_classes = (IsAuthenticated, )
    parser_classes = [MultiPartParser, FormParser]

    def get(self, request):
        visited_routes = Route.objects.filter(visited_user__id=request.user.id)
        serializer = self.serializer_class(visited_routes, many= True)
        data = serializer.data
        return response.Response(data, status=status.HTTP_201_CREATED)

    def post(self, request):
        user = User.objects.get(id=request.user.id)
        route = Route.objects.get(id=request.data.get("route_id"))
        route.visited_user.add(user)
        return response.Response({"route visited !"}, status=status.HTTP_201_CREATED)