# Generated by Django 4.0.8 on 2023-02-13 17:59

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('search_route', '0004_route_distance'),
    ]

    operations = [
        migrations.AddField(
            model_name='route',
            name='visited_user',
            field=models.ManyToManyField(blank=True, related_name='visited_user', to=settings.AUTH_USER_MODEL),
        ),
    ]
