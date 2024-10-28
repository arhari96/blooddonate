from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.views import APIView
from django.shortcuts import get_object_or_404
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.generics import GenericAPIView, ListAPIView
from rest_framework.exceptions import AuthenticationFailed
from . import google
from .models import NeedBlood, UserProfile, Donor
from firebase_admin import messaging
import asyncio
from .serializers import (
    BloodRequestSerializer,
    FcmTokenUpdateSerializer,
    GoogleSocialAuthSerializer,
    NeedBloodSerializer,
    UserProfileSerializer,
    DonorSerializer,
)
from dotenv import load_dotenv
import os
import jwt


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def get_user_detail(request):
    user = request.user
    serializer = UserProfileSerializer(user)
    return Response(
        {
            "status": "success",
            "message": "User details retrieved successfully",
            "data": serializer.data,
        }
    )


class GoogleSocialAuthView(GenericAPIView):
    permission_classes = [AllowAny]

    serializer_class = GoogleSocialAuthSerializer

    def post(self, request):
        load_dotenv()
        client_key_ios = os.getenv("CLIENT_KEY_IOS")
        client_key_android = os.getenv("CLIENT_KEY_ANDROID")
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        auth_token = serializer.validated_data["auth_token"]

        user_data = google.Google.validate(auth_token)
        try:
            user_data["sub"]
        except:
            raise AuthenticationFailed(
                "The token is invalid or expired. Please login again."
            )

        if (
            user_data["aud"] != client_key_ios
            and user_data["aud"] != client_key_android
        ):
            return Response(
                {"status": "failed", "message": "Oops, who are you?", "data": {}},
                status=status.HTTP_401_UNAUTHORIZED,
            )

        user_id = user_data["sub"]
        email = user_data["email"]
        name = user_data["name"]
        profile_pic = user_data["picture"]  # Get profile picture if available

        # Check if user already exists
        user, created = UserProfile.objects.get_or_create(
            email=email, defaults={"user_id": user_id, "name": name}
        )

        if created:
            # If the user was just created, set additional profile fields
            user.profile_pic = profile_pic
            user.save()

            refresh = RefreshToken.for_user(user)
            access_token = str(refresh.access_token)
            message = "Account created successfully"
        else:

            refresh = RefreshToken.for_user(user)
            access_token = str(refresh.access_token)
            message = "Logged in successfully"
        # Generate tokens for the user
        refresh = RefreshToken.for_user(user)
        access_token = str(refresh.access_token)

        # Serialize user profile
        user_profile_serializer = UserProfileSerializer(user)
        response_data = {
            "status": "success",
            "message": message,
            "data": {
                "user_profile": user_profile_serializer.data,
                "token": access_token,
            },
        }
        # Return response with JWT token and user profile
        return Response(response_data, status=status.HTTP_200_OK)


class UpdateUserProfile(APIView):
    permission_classes = [IsAuthenticated]

    def put(self, request):
        print(request)
        user_profile = request.user
        serializer = UserProfileSerializer(
            user_profile, data=request.data, partial=True
        )
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            jwt_payload = {"user_id": user_profile.user_id, "email": user_profile.email}
            jwt_token = jwt.encode(
                jwt_payload, os.getenv("SECRET_KEY"), algorithm="HS256"
            )

            response_data = {
                "status": "success",
                "message": "Your profile updated successfully",
                "data": {
                    "user_profile": UserProfileSerializer(user_profile).data,
                    "token": jwt_token,
                },
            }
            return Response(response_data, status=status.HTTP_200_OK)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class FcmTokenUpdateView(APIView):
    permission_classes = [IsAuthenticated]  # Only authenticated users can update

    def patch(self, request):
        serializer = FcmTokenUpdateSerializer(
            data=request.data
        )  # Use serializer (if used)
        serializer.is_valid(raise_exception=True)

        user = request.user  # Access the authenticated user (requires authentication)
        user.fcm_token = serializer.validated_data["fcm_token"]  # Update the token
        user.save()

        return Response({"message": "FCM token updated successfully."})


class Test(APIView):
    def post(self, request):

        return Response({"message": "Hello, World!"}, status=status.HTTP_200_OK)


class TokenRefreshView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        refresh_token = request.data.get("refresh_token")
        if not refresh_token:
            return Response({"error": "Refresh token is required"}, status=400)

        try:
            refresh_token = RefreshToken(refresh_token)
            access_token = refresh_token.access_token
        except Exception as e:
            return Response({"error": "Invalid refresh token"}, status=400)

        return Response({"access_token": str(access_token)})


class RequestandViewBloodRequest(APIView):
    """
    View to list all blood requests and create a new request.
    """

    permission_classes = [IsAuthenticated]

    def get(self, request):
        blood_requests = NeedBlood.objects.filter(approved=True).order_by(
            "-request_date"
        )
        serializer = NeedBloodSerializer(
            blood_requests, many=True, context={"request": request}
        )
        response_data = {
            "status": "success",
            "message": "List fetched successfully",
            "data": serializer.data,
        }
        return Response(response_data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = NeedBloodSerializer(
            data=request.data, context={"request": request}
        )
        if serializer.is_valid():
            serializer.save(requested_user=request.user)
            data = serializer.data
            requested_user_data = UserProfile.objects.get(id=request.user.id)

            title = f"New Blood Request for {data['blood_group']}"
            body = f"{requested_user_data.name} has requested for blood {data['blood_group']}"
            message = messaging.Message(
                data={"title": title, "body": body},
                topic="blood_request_approve",
            )

            try:
                message_response = messaging.send(message)
                print("Message Response:", message_response)
            except Exception as e:
                print("Error:", e)

            response_data = {
                "message": "Blood request created successfully",
                "status": "success",
                "data": serializer.data,
            }
            print(response_data)
            return Response(response_data, status=status.HTTP_201_CREATED)

        response_data = {
            "message": "Blood request not created",
            "status": "failure",
            "data": serializer.errors,
        }
        return Response(response_data, status=status.HTTP_400_BAD_REQUEST)


class NeedBloodView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = NeedBloodSerializer(data=request.data)
        if serializer.is_valid():
            # Setting the requested_user from the request's authenticated user
            need_blood = serializer.save(requested_user=request.user)

            # Optionally send notifications
            self.send_notifications(need_blood.blood_group, need_blood.location)
            response_data = {
                "message": "Blood request created successfully",
                "status": "success",
                "data": serializer.data,
            }
            return Response(response_data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def send_notifications(self, blood_group, location):
        matched_users = UserProfile.objects.filter(
            blood_type=blood_group, is_active=True
        )
        for user in matched_users:
            print(
                f"Notification sent to {user.email} about blood requirement at {location}"
            )


class ListBloodRequestsView(ListAPIView):
    queryset = NeedBlood.objects.all().order_by("-request_date")
    serializer_class = NeedBloodSerializer

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)
        response_data = {
            "status": "success",
            "message": "List fetched successfully",
            "data": serializer.data,
        }
        return Response(response_data, status=status.HTTP_200_OK)


class DonateBloodView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        # Retrieve the 'id' of the NeedBlood object from the request
        need_blood_id = request.data.get("id")
        if not need_blood_id:
            return Response(
                {"message": "Missing blood request ID."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        # Find the NeedBlood instance or return a 404 error
        need_blood = get_object_or_404(NeedBlood, id=need_blood_id)

        # Check if the blood has already been donated
        if need_blood.donated:
            return Response(
                {"message": "Blood has already been donated for this request."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        return Response(
            {
                "status": "success",
                "message": "Blood donation successful. Thank you for donating blood!",
                "data": "Success",
            },
            status=status.HTTP_200_OK,
        )


@api_view(["Get"])
def get_blood_requests(request):
    blood_requests = NeedBlood.objects.all()
    serializer = BloodRequestSerializer(blood_requests, many=True)
    return Response(
        {
            "status": "success",
            "message": "Blood requests fetched successfully",
            "data": serializer.data,
        },
        status=status.HTTP_200_OK,
    )


@api_view(["POST"])
def donate_blood(request, pk):
    need_blood = get_object_or_404(NeedBlood, id=pk)
    need_blood.update_donated_units(1)
    existing_donor = Donor.objects.filter(
        blood_request=need_blood, user=request.user
    ).first()

    if existing_donor:
        existing_donor.units_donated += 1
        existing_donor.save()
        return Response(
            {
                "status": "success",
                "message": f"Thank you for your continued support! You have now donated {existing_donor.units_donated} units of blood for this request.",
                "data": "",
            },
            status=status.HTTP_200_OK,
        )
    else:
        # Create a new donor record
        Donor.objects.create(
            blood_request=need_blood, user=request.user, units_donated=1
        )
        return Response(
            {
                "status": "success",
                "message": "Thank you for your first donation! You have successfully donated 1 unit of blood for this request.",
                "data": "",
            },
            status=status.HTTP_201_CREATED,
        )


class PendingRequests(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        pending_requests = NeedBlood.objects.filter(approved=False)
        serializer = BloodRequestSerializer(pending_requests, many=True)
        return Response(
            {
                "status": "success",
                "message": "Pending blood requests fetched successfully",
                "data": serializer.data,
            },
            status=status.HTTP_200_OK,
        )

    def post(self, request):
        request_id = request.data.get("id")
        need_blood = get_object_or_404(NeedBlood, id=request_id)
        need_blood.approved = True
        need_blood.save()
        notification_title = f"{need_blood.blood_group} Blood Request"
        notification_body = f"{need_blood.patient_name} needs {need_blood.number_of_units} units of {need_blood.blood_group} blood."
        message = messaging.Message(
            data={
                "title": notification_title,
                "body": notification_body,
            },
            topic="blood_requests",
        )
        result = messaging.send(message)
        return Response(
            {
                "status": "success",
                "message": "Blood request approved successfully",
                "data": "Success",
            },
            status=status.HTTP_200_OK,
        )


@api_view(["GET"])
def test_notification(request):
    message = messaging.Message(
        data={
            "title": "Test Notification",
            "body": "This is a test notification.",
        },
        topic="blood_request_approve",
    )
    result = messaging.send(message)
    print(result)
    return Response(
        {
            "status": "success",
            "message": "Test notification sent successfully",
            "data": "Success",
        },
        status=status.HTTP_200_OK,
    )


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def get_donor_list(request):
    donor_list = Donor.objects.filter(user=request.user)
    serializer = DonorSerializer(donor_list, many=True)
    return Response(
        {
            "status": "success",
            "message": "Donor list fetched successfully",
            "data": serializer.data,
        },
        status=status.HTTP_200_OK,
    )
