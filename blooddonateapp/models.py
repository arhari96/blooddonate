from django.db import models
from django.utils import timezone
from django.contrib.auth.models import AbstractUser
from django.core.exceptions import ObjectDoesNotExist


class UserProfile(AbstractUser):
    AUTH_PROVIDERS = {
        "facebook": "facebook",
        "google": "google",
        "twitter": "twitter",
        "email": "email",
    }

    email = models.EmailField(max_length=255, unique=True)
    is_verified = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    auth_provider = models.CharField(
        max_length=255, blank=False, null=False, default=AUTH_PROVIDERS["email"]
    )
    user_id = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    profile_pic = models.URLField(blank=True)
    dob = models.DateField(null=True, blank=True)
    city = models.CharField(max_length=100, blank=True)
    pincode = models.CharField(max_length=10, blank=True)
    blood_type = models.CharField(max_length=10, blank=True)
    profile_filled = models.BooleanField(default=False)
    fcm_token = models.TextField(null=True, blank=True)
    admin = models.BooleanField(default=False)

    def save(self, *args, **kwargs):
        # Check if the username is not set and the email is provided
        if not self.username and self.email:
            # Set the username to the email
            self.username = self.email
        # Call the super save method to save the object
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.name} ({self.email})"


class NeedBlood(models.Model):
    blood_group = models.CharField(max_length=3)
    patient_name = models.CharField(max_length=100)
    age = models.IntegerField()
    location = models.CharField(max_length=200)
    place = models.CharField(max_length=200, blank=True, null=True)
    detail = models.TextField()
    contact_number = models.CharField(max_length=10)
    contact_person_name = models.CharField(max_length=25)
    number_of_units = models.IntegerField(default=1)
    donated_units = models.IntegerField(default=0)
    approved = models.BooleanField(default=False)
    donated = models.BooleanField(default=False)
    request_date = models.DateField(auto_now_add=True)
    donated_date = models.DateField(null=True, blank=True)
    requested_user = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name="blood_requests"
    )

    def __str__(self):
        return f"{self.patient_name} - {self.blood_group}"

    def update_donated_units(self, units):
        self.donated_units += units
        if self.donated_units >= self.number_of_units:
            self.donated = True
            self.donated_date = timezone.now()
        self.save()

    def donate_blood(self, donated_user):

        self.donated = True
        self.donated_user = donated_user
        self.donated_date = timezone.now()
        self.save()


class Donor(models.Model):
    blood_request = models.ForeignKey(
        NeedBlood, on_delete=models.CASCADE, related_name="donors"
    )
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    units_donated = models.IntegerField()

    def __str__(self):
        return f"{self.user.username} donated {self.units_donated} units for {self.blood_request.patient_name}"
