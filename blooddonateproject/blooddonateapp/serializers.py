from rest_framework import serializers
from .models import UserProfile,NeedBlood

from django.contrib.auth import get_user_model
class GoogleSocialAuthSerializer(serializers.Serializer):
    auth_token = serializers.CharField()


User = get_user_model()

class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('user_id', 'email', 'name', 'profile_pic', 'dob', 'city', 'pincode', 'blood_type', 'profile_filled')
    
    def update(self, instance, validated_data):
        # When significant fields are updated, set profile_filled to True
        instance = super().update(instance, validated_data)
        if 'name' in validated_data or 'dob' in validated_data:  # Example of significant fields
            instance.profile_filled = True
            instance.save(update_fields=['profile_filled'])
        return instance

class NeedBloodSerializer(serializers.ModelSerializer):
    class Meta:
        model = NeedBlood
        fields = '__all__'
        read_only_fields = ('requested_user', 'donated', 'donated_date')  # These fields should not be editable directly by the user.
