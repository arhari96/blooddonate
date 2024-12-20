# Generated by Django 5.0.3 on 2024-05-01 07:57

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blooddonateapp', '0012_alter_needblood_donated_user'),
    ]

    operations = [
        migrations.AlterField(
            model_name='needblood',
            name='blood_group',
            field=models.CharField(max_length=3),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='blood_type',
            field=models.CharField(blank=True, max_length=10),
        ),
        migrations.CreateModel(
            name='DonorImages',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='donor_pics/')),
                ('need_blood', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='blooddonateapp.needblood')),
            ],
        ),
        migrations.AddField(
            model_name='needblood',
            name='donor_images',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='related_need_blood', to='blooddonateapp.donorimages'),
        ),
    ]
