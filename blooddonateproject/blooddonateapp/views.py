from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from django.shortcuts import get_object_or_404
from rest_framework_simplejwt.tokens import RefreshToken,AccessToken
from rest_framework.permissions import IsAuthenticated
from rest_framework.generics import GenericAPIView,ListAPIView
from rest_framework.exceptions import AuthenticationFailed
from . import google
from .models import NeedBlood, UserProfile
from .serializers import GoogleSocialAuthSerializer, NeedBloodSerializer, UserProfileSerializer
from dotenv import load_dotenv
import os
import jwt

class GoogleSocialAuthView(GenericAPIView):

    serializer_class = GoogleSocialAuthSerializer

    def post(self, request):
        load_dotenv()
        client_key_ios = os.getenv('CLIENT_KEY_IOS')
        client_key_android = os.getenv('CLIENT_KEY_ANDROID')
        client_key_web = os.getenv('CLIENT_KEY_WEB')
        client_key_google = os.getenv('CLIENT_KEY_GOOGLE')
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        auth_token = serializer.validated_data['auth_token']
        
        user_data = google.Google.validate(auth_token)  
        print(user_data)
        try:
            user_data['sub']
        except:
            raise AuthenticationFailed('The token is invalid or expired. Please login again.')

        if user_data['aud'] != client_key_ios and user_data['aud'] != client_key_android:
            return Response({
           'status':'failed',
            'message': 'Oops, who are you?',
            'data': {}
        }, status=status.HTTP_401_UNAUTHORIZED)
        
            

        user_id = user_data['sub']
        email = user_data['email']
        name = user_data['name']
        profile_pic = user_data['picture']  # Get profile picture if available
        
        # Check if user already exists
        user, created = UserProfile.objects.get_or_create(email=email, defaults={'user_id': user_id, 'name': name})
        # Generate JWT token
        access_token = AccessToken.for_user(user)
        
        if created:
            # If the user was just created, set additional profile fields
            user.profile_pic = profile_pic
            user.save()
            message = "Account created successfully"
        else:
            message = "Logged in successfully"
        
        # Serialize user profile
        user_profile_serializer = UserProfileSerializer(user)
        response_data ={
          
            'status':'success',
            'message': message,
            'data':{
            'user_profile': user_profile_serializer.data,
              'token': str(access_token),
           
            }
        }
        print(response_data)
        # Return response with JWT token and user profile
        return Response(response_data, status=status.HTTP_200_OK)

class UpdateUserProfile(APIView):
    permission_classes = [IsAuthenticated]

    def put(self, request):
        user_profile = request.user.profile  # Assuming request.user contains the authenticated user
        serializer = UserProfileSerializer(user_profile, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        jwt_payload = {'user_id': user_profile.user_id, 'email': user_profile.email}
        jwt_token = jwt.encode(jwt_payload, os.getenv('SECRET_KEY'), algorithm='HS256')
        # Prepare response
        response_data = {
            'jwt_token': jwt_token,  # Generate new JWT token if needed
            'message': 'Your profile updated successfully',
            'user_profile': UserProfileSerializer(user_profile).data
        }
        
        return Response(response_data, status=status.HTTP_200_OK)

class Test(APIView):    
    def get(self, request):
        print(request.data)
        return Response({'message': 'Hello, World!'}, status=status.HTTP_200_OK)

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
    

class NeedBloodView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = NeedBloodSerializer(data=request.data)
        if serializer.is_valid():
            need_blood = serializer.save(requested_user=request.user)           
            def send_notifications(blood_group, location):
                matched_users = UserProfile.objects.filter(blood_type=blood_group, is_active=True)
                for user in matched_users:
                    print(f"Notification sent to {user.email} about blood requirement at {location}")

            # Optionally send notifications to matched blood group members
            # You can add the notification logic here
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ListBloodRequestsView(ListAPIView):
    queryset = NeedBlood.objects.all()
    serializer_class = NeedBloodSerializer


class DonateBloodView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, request_id):
        need_blood = get_object_or_404(NeedBlood, id=request_id)

        if need_blood.donated:
            return Response({'message': 'Blood has already been donated for this request.'}, status=status.HTTP_400_BAD_REQUEST)
        
        need_blood.donate_blood(donated_user=request.user)
        return Response({'message': 'Thank you for donating blood!'}, status=status.HTTP_200_OK)