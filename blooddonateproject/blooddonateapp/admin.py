from django.contrib import admin

from .models import UserProfile, NeedBlood

admin.site.register([UserProfile, NeedBlood])
