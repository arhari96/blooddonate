from django.db import models

# Constants for blood group choices
BLOOD_GROUP_CHOICES = [
    ('A+', 'A+'),
    ('A-', 'A-'),
    ('B+', 'B+'),
    ('B-', 'B-'),
    ('AB+', 'AB+'),
    ('AB-', 'AB-'),
    ('O+', 'O+'),
    ('O-', 'O-'),
]

class UserProfile(models.Model):
    AUTH_PROVIDERS = {
        'facebook': 'facebook',
        'google': 'google',
        'twitter': 'twitter',
        'email': 'email'
    }

    username = models.CharField(max_length=255, unique=True, db_index=True)         
    email = models.EmailField(max_length=255, unique=True, db_index=True)
    is_verified = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    auth_provider = models.CharField(
        max_length=255,
        blank=False,
        null=False,
        default=AUTH_PROVIDERS.get('email')
    )
    user_id = models.CharField(max_length=255, unique=True)
    name = models.CharField(max_length=255)
    profile_pic = models.URLField(blank=True)
    dob = models.DateField(null=True, blank=True)
    city = models.CharField(max_length=100, blank=True)
    pincode = models.CharField(max_length=10, blank=True)
    blood_type = models.CharField(max_length=10, choices=BLOOD_GROUP_CHOICES, blank=True)
    profile_filled = models.BooleanField(default=False)

    def __str__(self):
        return self.name

class NeedBlood(models.Model):
    blood_group = models.CharField(max_length=3, choices=BLOOD_GROUP_CHOICES)
    patient_name = models.CharField(max_length=100)
    age = models.IntegerField()
    request_date = models.DateField()
    location = models.CharField(max_length=200)
    detail = models.TextField()
    contact_number = models.CharField(max_length=10)
    contact_person_name = models.CharField(max_length=25)
    donated = models.BooleanField(default=False)
    donated_date = models.DateField(null=True, blank=True)
    requested_user = models.ForeignKey(
        UserProfile,
        on_delete=models.CASCADE,
        related_name='blood_requests'
    )
    donated_user = models.ForeignKey(
        UserProfile,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='blood_donations'
    )

    def __str__(self):
        return f"{self.name} - {self.blood_group}"

    def donate_blood(self, donated_user):
        self.donated = True
        self.donated_user = donated_user
        self.save()
