from rest_framework import serializers
from .models import UserProfile,NeedBlood
class GoogleSocialAuthSerializer(serializers.Serializer):
    auth_token = serializers.CharField()


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ('user_id', 'email', 'name', 'profile_pic', 'dob', 'city', 'pincode', 'blood_type', 'profile_filled')
    

class NeedBloodSerializer(serializers.ModelSerializer):
    class Meta:
        model = NeedBlood
        fields = '__all__'
        read_only_fields = ('requested_user', 'donated', 'donated_date')  # These fields should not be editable directly by the user.
