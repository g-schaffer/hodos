# Generated by Django 4.0.8 on 2023-02-13 16:46

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('point_of_route', '0002_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='point_of_route',
            name='distance',
        ),
    ]
