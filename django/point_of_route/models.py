from django.db import models
from helpers.models import TrackingModel
from django.utils.translation import gettext_lazy as _
from search_route.models import Route
from user_management.models import User

class Point_of_route(TrackingModel):
    latitude = models.DecimalField(max_digits=5, decimal_places=2, blank=True)
    longitude = models.DecimalField(max_digits=5, decimal_places=2, blank=True)
    index = models.IntegerField(blank=True, default=-1)
    route = models.ForeignKey(to= Route, on_delete=models.CASCADE)

    class Meta:
        db_table = 'point_of_route'
