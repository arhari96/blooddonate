from django.shortcuts import render
from allauth.socialaccount.providers.google.views import GoogleOAuth2Adapter
from allauth.socialaccount.providers.oauth2.client import OAuth2Client
from dj_rest_auth.registration.views import SocialLoginView

from google.oauth2 import id_token
from google.auth.transport import requests
from django.http import JsonResponse

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
