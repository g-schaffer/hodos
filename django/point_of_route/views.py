from django.shortcuts import render
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from point_of_route.serializers import * 
from rest_framework.permissions import IsAuthenticated
from .permissions import UserID
from rest_framework.parsers import MultiPartParser, FormParser
from .models import *
from rest_framework import response, status, permissions, views


# ################### POINT_OF_ROUTE ###################
class PointOfRouteAPIView(ListCreateAPIView):

     serializer_class = PointOfRouteSerializer
     permission_classes = (IsAuthenticated, )

     parser_classes = [MultiPartParser, FormParser]

 
     queryset = Point_of_route.objects.all()

     def perform_create(self, serializer, format = None):
         return serializer.save(user=self.request.user)

     def get_queryset(self):
         return Point_of_route.objects.filter(user=self.request.user)



################## Update and delete ####################################
class PointOfRouteDetailAPIView(RetrieveUpdateDestroyAPIView):

    serializer_class = PointOfRouteSerializer
    permission_classes = (IsAuthenticated, UserID, )

    parser_classes = [MultiPartParser, FormParser]

    queryset = Point_of_route.objects.all()

    lookup_field = "id"

    def perform_create(self, serializer):
        return serializer.save(user=self.request.user)

    def get_queryset(self, ):
         return Point_of_route.objects.filter(user=self.request.user)

class FullRoutesAPIView(views.APIView):
    
    serializer_class = PointOfRouteSerializer
    permission_classes = (IsAuthenticated, UserID, )
    parser_classes = [MultiPartParser, FormParser]

    def get(self, route_id):
        points = Point_of_route.objects.filter(route_id=route_id)
        serializer = PointOfRouteSerializer(points, many=True)
        return response.Response(serializer.data, status=status.HTTP_200_OK)