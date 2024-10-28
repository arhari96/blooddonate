# Generated by Django 5.0.3 on 2024-04-25 12:44

import uuid
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blooddonateapp', '0007_alter_userprofile_options_alter_userprofile_managers_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userprofile',
            name='email',
            field=models.EmailField(max_length=255, unique=True),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='username',
            field=models.CharField(default=uuid.uuid1, max_length=255, unique=True),
        ),
    ]