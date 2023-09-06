from django.db import models
from helpers.models import TrackingModel
from user_management.models import User
from django.utils.translation import gettext_lazy as _
from search_route.models import Route


class Comment(TrackingModel):
    user = models.ForeignKey(to=User,on_delete=models.CASCADE, related_name='comments', related_query_name='comment')
    route = models.ForeignKey(to= Route, on_delete= models.CASCADE, related_name='comments', related_query_name='comment')
    title = models.CharField(max_length=255)
    content = models.TextField()

    class Meta:
        db_table = 'comments'

    def __str__(self):
        return self.title

