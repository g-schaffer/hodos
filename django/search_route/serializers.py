from rest_framework import serializers
from search_route.models import Route
from point_of_route.serializers import PointOfRouteSerializer
from user_management.serializes import StrictUserSerializer
################### ROUTE ###################
class RouteSerializer(serializers.ModelSerializer):
    user = StrictUserSerializer()

    class Meta:
        model = Route
        fields = (
            'id',
            'name', 
            'description',
            'image',
            'user',
            'visited_user',
            'avg_time',
        )

class DetailRouteSerializer(serializers.ModelSerializer):
    points = PointOfRouteSerializer(many=True, read_only=True)

    class Meta:
        model = Route
        fields = '__all__'