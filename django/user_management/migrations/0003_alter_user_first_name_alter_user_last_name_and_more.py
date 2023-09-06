# Generated by Django 4.0.8 on 2022-10-28 14:34

from django.db import migrations, models
import user_management.models


class Migration(migrations.Migration):

    dependencies = [
        ('user_management', '0002_alter_user_first_name_alter_user_last_name_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='first_name',
            field=models.CharField(blank=True, max_length=255, null=True, verbose_name='first name'),
        ),
        migrations.AlterField(
            model_name='user',
            name='last_name',
            field=models.CharField(blank=True, max_length=255, null=True, verbose_name='last name'),
        ),
        migrations.AlterField(
            model_name='user',
            name='url_image',
            field=models.ImageField(blank=True, default='users/def0ault.jpg', null=True, upload_to=user_management.models.upload_to, verbose_name='Image'),
        ),
    ]
