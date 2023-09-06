from django.db import models
from helpers.models import TrackingModel
from django.utils.translation import gettext_lazy as _



def upload_to_point_of_interests(instance, filename):
    return 'point_of_interests/{filename}'.format(filename = filename)


class Point_of_interest(TrackingModel):
    name = models.CharField(max_length=100)
    description = models.CharField(max_length=255)
    url_image = models.ImageField( _('Image'), upload_to = upload_to_point_of_interests, default ='point_of_interests/default.jpg')

    class Meta:
        db_table = 'point_of_interest'

    def __str__(self):
        return self.name