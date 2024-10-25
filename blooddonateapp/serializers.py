from rest_framework import serializers
from .models import DonorImages, Comment, NeedBlood
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


class DonorImagesSerializer(serializers.ModelSerializer):
    class Meta:
        model = DonorImages
        fields = ("image",)


class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = "__all__"


class NeedBloodSerializer(serializers.ModelSerializer):
    requested_user = UserProfileSerializer(read_only=True)
    donated_user = UserProfileSerializer(read_only=True)
    donor_images = DonorImagesSerializer(many=True, read_only=True)
    likes_count = (
        serializers.SerializerMethodField()
    )  # Add a custom field for likes count
    comments_count = serializers.SerializerMethodField()
    liked = serializers.SerializerMethodField()

    class Meta:
        model = NeedBlood
        fields = "__all__"

    def get_likes_count(self, obj):
        # Get the count of likes for the blood request
        return obj.likes.count()

    def get_comments_count(self, obj):
        # Get the count of comments for the blood request
        return obj.comments.count()

    def get_liked(self, obj):
        # Check if the current user has liked this blood request
        print(self.context)
        user = self.context["request"].user
        if user.is_authenticated:
            return obj.likes.filter(user=user).exists()
        return False

    def get_donor_images(self, obj):
        # Only return image URLs if the blood has been donated
        if obj.donated:
            request = self.context.get("request")
            if request is not None:
                base_url = request.build_absolute_uri("/")[
                    :-1
                ]  # Remove the trailing slash
                image_urls = [
                    base_url + image.image.url for image in obj.donor_images.all()
                ]
                return image_urls
        return []

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
