from rest_framework import serializers
from .models import UserProfile
class GoogleSocialAuthSerializer(serializers.Serializer):
    auth_token = serializers.CharField()


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ('user_id', 'email', 'name', 'profile_pic', 'dob', 'city', 'pincode', 'blood_type', 'profile_filled')