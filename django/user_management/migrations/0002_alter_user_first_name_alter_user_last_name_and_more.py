# Generated by Django 4.0.8 on 2022-10-28 14:08

from django.db import migrations, models
import user_management.models


class Migration(migrations.Migration):

    dependencies = [
        ('user_management', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='first_name',
            field=models.CharField(blank=True, max_length=255, verbose_name='first name'),
        ),
        migrations.AlterField(
            model_name='user',
            name='last_name',
            field=models.CharField(blank=True, max_length=255, verbose_name='last name'),
        ),
        migrations.AlterField(
            model_name='user',
            name='url_image',
            field=models.ImageField(blank=True, default='users/default.jpg', upload_to=user_management.models.upload_to, verbose_name='Image'),
        ),
    ]
