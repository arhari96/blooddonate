from rest_framework import serializers
from .models import NeedBlood, Donor
from django.conf import settings
from django.contrib.auth import get_user_model


class GoogleSocialAuthSerializer(serializers.Serializer):
    auth_token = serializers.CharField()


User = get_user_model()


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            "user_id",
            "email",
            "name",
            "profile_pic",
            "dob",
            "city",
            "pincode",
            "blood_type",
            "profile_filled",
            "admin",
        )

    def update(self, instance, validated_data):
        # When significant fields are updated, set profile_filled to True
        instance = super().update(instance, validated_data)
        if (
            "name" in validated_data or "dob" in validated_data
        ):  # Example of significant fields
            instance.profile_filled = True
            instance.save(update_fields=["profile_filled"])
        return instance


class FcmTokenUpdateSerializer(serializers.Serializer):
    fcm_token = serializers.CharField(required=True)

    def validate_fcm_token(self, value):
        # Implement validation logic here (optional)
        # You can check for token validity or format, etc.
        return value


class NeedBloodSerializer(serializers.ModelSerializer):
    requested_user = UserProfileSerializer(read_only=True)
    donated_user = UserProfileSerializer(read_only=True)

    class Meta:
        model = NeedBlood
        fields = "__all__"

    def create(self, validated_data):
        # Set requested_user to the authenticated user making the request
        validated_data["requested_user"] = self.context["request"].user
        instance = super().create(validated_data)
        return instance

    def update(self, instance, validated_data):
        instance = super().update(instance, validated_data)
        return instance


class BloodRequestSerializer(serializers.ModelSerializer):
    requested_user = UserProfileSerializer(read_only=True)

    class Meta:
        model = NeedBlood
        fields = "__all__"


class DonorSerializer(serializers.ModelSerializer):
    blood_request = NeedBloodSerializer(read_only=True)

    class Meta:
        model = Donor
        fields = "__all__"
