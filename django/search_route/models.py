from django.db import models
from helpers.models import TrackingModel
from user_management.models import User
from django.utils.translation import gettext_lazy as _


def upload_to_routes(instance, filename):
    return 'routes/{filename}'.format(filename = filename)

class Route(TrackingModel):
    name = models.CharField(max_length=150)
    description = models.TextField()
    distance = models.DecimalField(max_digits=5, decimal_places=2, blank=True, default=0.00)
    image = models.ImageField( _('Image'), upload_to = upload_to_routes, default ='routes/default.jpg')
    user = models.ForeignKey(to = User,on_delete=models.CASCADE)
    visited_user = models.ManyToManyField(User, related_name='visited_user', blank=True)
    avg_time = models.TimeField(blank=True, null = True)

    class Meta:
        db_table = 'route'

    def __str__(self):
        return self.name + " " + str(self.id)

class Rating(TrackingModel):
    user = models.ForeignKey(to = User, on_delete = models.CASCADE)
    route = models.ForeignKey(to = Route, on_delete = models.CASCADE)
    rating = models.IntegerField(blank = False, default = -1)

    class Meta:
        db_table = "rating"

    def __str__(self):
        return self.user.email + " => " + str(self.rating) + "/5 for " + str(self.route)