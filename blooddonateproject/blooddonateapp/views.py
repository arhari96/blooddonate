from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView

from rest_framework_simplejwt.tokens import RefreshToken,AccessToken
from rest_framework.permissions import IsAuthenticated
from rest_framework.generics import GenericAPIView
from rest_framework.exceptions import AuthenticationFailed
from . import google
from .models import UserProfile
from .serializers import GoogleSocialAuthSerializer, UserProfileSerializer
from dotenv import load_dotenv
import os
import jwt

class GoogleSocialAuthView(GenericAPIView):

    serializer_class = GoogleSocialAuthSerializer

    def post(self, request):
        load_dotenv()
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        auth_token = serializer.validated_data['auth_token']
        
        user_data = google.Google.validate(auth_token)
        try:
            user_data['sub']
        except:
            raise AuthenticationFailed('The token is invalid or expired. Please login again.')

        if user_data['aud'] != os.getenv('CLIENT_KEY'):
            raise AuthenticationFailed('Oops, who are you?')

        user_id = user_data['sub']
        email = user_data['email']
        name = user_data['name']
        profile_pic = user_data.get('picture', '')  # Get profile picture if available
        
        # Check if user already exists
        user, created = UserProfile.objects.get_or_create(email=email, defaults={'user_id': user_id, 'name': name})
        access_token = AccessToken.for_user(user)

        # Generate refresh token
        refresh_token = RefreshToken.for_user(user)
        
        # Generate JWT token
        jwt_payload = {'user_id': user.user_id, 'email': user.email}
        jwt_token = jwt.encode(jwt_payload, os.getenv('SECRET_KEY'), algorithm='HS256')
        
        if created:
            # If the user was just created, set additional profile fields
            user.profile_pic = profile_pic
            user.save()
            message = "Account created successfully"
        else:
            message = "Logged in successfully"
        
        # Serialize user profile
        user_profile_serializer = UserProfileSerializer(user)
        
        # Return response with JWT token and user profile
        return Response({
            'access_token': jwt_token,
            'refresh_token': jwt_token,
            'message': message,
            'user_profile': user_profile_serializer.data
        }, status=status.HTTP_200_OK)



class TokenRefreshView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        refresh_token = request.data.get('refresh_token')
        if not refresh_token:
            return Response({'error': 'Refresh token is required'}, status=400)

        try:
            refresh_token = RefreshToken(refresh_token)
            access_token = refresh_token.access_token
        except Exception as e:
            return Response({'error': 'Invalid refresh token'}, status=400)

        return Response({'access_token': str(access_token)})