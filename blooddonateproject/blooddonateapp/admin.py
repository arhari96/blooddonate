from django.contrib import admin
from .models import UserProfile, NeedBlood, DonorImages

admin.site.register([UserProfile, NeedBlood, DonorImages])
