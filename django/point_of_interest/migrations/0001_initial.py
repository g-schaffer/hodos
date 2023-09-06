# Generated by Django 4.0.8 on 2022-10-18 19:29

from django.db import migrations, models
import point_of_interest.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Point_of_interest',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('update_at', models.DateTimeField(auto_now_add=True)),
                ('name', models.CharField(max_length=100)),
                ('description', models.CharField(max_length=255)),
                ('url_image', models.ImageField(default='point_of_interests/default.jpg', upload_to=point_of_interest.models.upload_to_point_of_interests, verbose_name='Image')),
            ],
            options={
                'db_table': 'point_of_interest',
            },
        ),
    ]
