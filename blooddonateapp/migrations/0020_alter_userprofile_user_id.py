# Generated by Django 5.0.3 on 2024-10-28 05:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blooddonateapp', '0019_needblood_approved_needblood_donated_units_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userprofile',
            name='user_id',
            field=models.CharField(max_length=255),
        ),
    ]