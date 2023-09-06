from rest_framework import serializers
from point_of_interest.models import Point_of_interest



################### POINT_OF_INTEREST ###################
class PointOfInterestSerializer(serializers.ModelSerializer):

    class Meta:
        model = Point_of_interest
        fields = (
            'id',
            'name', 
            'description',
            'url_image'
        )
