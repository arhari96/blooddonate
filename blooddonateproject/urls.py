"""
URL configuration for blooddonateproject project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.contrib import admin
from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from django.conf import settings
from django.conf.urls.static import static
from blooddonateapp.views import (
    DonateBloodView,
    GoogleSocialAuthView,
    RequestandViewBloodRequest,
    Test,
    UpdateUserProfile,
    LikePost,
    UnlikePost,
    get_blood_requests,
    donate_blood,
    PendingRequests,
    get_user_detail,
)


urlpatterns = [
    path("api/token/", TokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("api/token/refresh/", TokenRefreshView.as_view(), name="token_refresh"),
    path("admin/", admin.site.urls),
    path("api/google/", GoogleSocialAuthView.as_view()),
    path("api/get_user_detail/", get_user_detail, name="get_user_detail"),
    path("api/update-profile/", UpdateUserProfile.as_view(), name="update-profile"),
    path("api/test/", Test.as_view(), name="test"),
    path(
        "api/blood-requests/",
        RequestandViewBloodRequest.as_view(),
        name="blood_requests_list",
    ),
    path("api/donate-blood/", DonateBloodView.as_view(), name="donate_blood"),
    path("api/donate-blood/<int:pk>/", donate_blood, name="donate_blood"),
    path("api/all-blood-requests/", get_blood_requests, name="get_blood_requests"),
    path("api/pending-requests/", PendingRequests.as_view(), name="pending_requests"),
    path("posts/<int:pk>/like/", LikePost.as_view(), name="like_post"),
    path("posts/<int:pk>/dislike/", UnlikePost.as_view(), name="dislike_post"),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
