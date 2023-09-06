from rest_framework import serializers
from point_of_route.models import Point_of_route
class PointOfRouteSerializer(serializers.ModelSerializer):

    class Meta:
        model = Point_of_route
        fields = (
            'index',
            'route',
            'latitude', 
            'longitude',
        )

