from django.shortcuts import render
from allauth.socialaccount.providers.google.views import GoogleOAuth2Adapter
from allauth.socialaccount.providers.oauth2.client import OAuth2Client
from dj_rest_auth.registration.views import SocialLoginView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView
from google.oauth2 import id_token
from google.auth.transport import requests
from rest_framework import serializers
from . import google
from rest_framework.exceptions import AuthenticationFailed
from django.http import JsonResponse
from .serializers import GoogleSocialAuthSerializer
from django.views.decorators.csrf import csrf_exempt
class GoogleLoginView(SocialLoginView):
    adapter_class = GoogleOAuth2Adapter
    client_class = OAuth2Client
# Create your views here.
@csrf_exempt
def validate_tokens(request):
    access_token = request.POST.get('access_token')
    id_tokens = request.POST.get('id_token')
    print(id_tokens)

    # Validate access token (if needed)
    # Perform necessary actions with the access token

    try:
        # Verify ID token
        CLIENT_ID = '220216598383-3o9lbsri9joieov0bh8kf1lrlj6p83oo.apps.googleusercontent.com'
        idinfo = id_token.verify_oauth2_token (id_tokens, requests.Request(), CLIENT_ID)

        # Check if the token is valid for the given client ID
        if idinfo['iss'] not in ['accounts.google.com', 'https://accounts.google.com']:
            raise ValueError('Wrong issuer.')

        # Here you can access user information like email, name, etc.
        user_email = idinfo['email']
        user_name = idinfo.get('name', '')

        # Respond with user information
        return JsonResponse({'email': user_email, 'name': user_name})

    except ValueError as e:
        # Token validation failed
        return JsonResponse({'error': str(e)}, status=400)
    
class GoogleSocialAuthView(GenericAPIView):

    # serializer_class = GoogleSocialAuthSerializer

    # def post(self, request):
    #     """

    #     POST with "auth_token"

    #     Send an idtoken as from google to get user information

    #     """

    #     serializer = self.serializer_class(data=request.data)
    #     # serializer.is_valid(raise_exception=True)
    #     # data = ((serializer.validated_data)['auth_token'])
    #     return Response(request.data, status=status.HTTP_200_OK)
    serializer_class = GoogleSocialAuthSerializer

    def post(self, request):
        """
        POST with "auth_token"
        Send an idtoken as from google to get user information
        """
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        auth_token = serializer.validated_data['auth_token']
        
        user_data = google.Google.validate(auth_token)
        try:
            user_data['sub']
        except:
            raise serializers.ValidationError(
                'The token is invalid or expired. Please login again.'
            )

        if user_data['aud'] != "407408718192.apps.googleusercontent.com":
            raise AuthenticationFailed('oops, who are you?')

        user_id = user_data['sub']
        email = user_data['email']
        name = user_data['name']
        
        # Return user details directly without registering
        return Response({
            'user_id': user_id,
            'email': email,
            'name': name,
            'data': user_data,
            'provider': 'google'
        }, status=status.HTTP_200_OK)