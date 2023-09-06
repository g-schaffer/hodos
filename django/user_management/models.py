from email.policy import default
from django.utils import timezone
from django.db import models
from django.contrib.auth.validators import UnicodeUsernameValidator
from django.contrib.auth.models import  PermissionsMixin, AbstractBaseUser, UserManager
from helpers.models import TrackingModel
from django.apps import apps
from django.contrib.auth.hashers import make_password
from django.utils.translation import gettext_lazy as _
from rest_framework_simplejwt.tokens import RefreshToken
import random



def upload_to(instance, filename):
    return 'users/{filename}'.format(filename = filename)


class MyUserManager(UserManager):

    def _create_user(self, username, email, password, first_name, last_name, url_image, **extra_fields):
        """
        Create and save a user with the given username, email, and password.
        """
        
        if not username:
            username = "username#" + str(random.randint(0, 1_000_000_000))

        if not email:
            raise ValueError("The given email must be set")

        if not password:
            raise ValueError("No given password")

        email = self.normalize_email(email)
        GlobalUserModel = apps.get_model(
            self.model._meta.app_label, self.model._meta.object_name
        )
        username = GlobalUserModel.normalize_username(username)
        print(email)
        user = self.model(username=username, email=email, first_name = first_name, last_name = last_name, url_image = url_image, **extra_fields)
        user.password = make_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email, username = None, first_name = None, last_name = None, url_image = None, password = None, **extra_fields):

        extra_fields.setdefault("is_staff", False)
        extra_fields.setdefault("is_superuser", False)
        return self._create_user(username, email, password, first_name, last_name, url_image, **extra_fields)

    def create_superuser(self, username, email, first_name, last_name, url_image="", password=None, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)

        if extra_fields.get("is_staff") is not True:
            raise ValueError("Superuser must have is_staff=True.")
        if extra_fields.get("is_superuser") is not True:
            raise ValueError("Superuser must have is_superuser=True.")
        print(email)
        return self._create_user(username, email, password,first_name, last_name, url_image, **extra_fields)


AUTH_PROVIDERS = {
    'facebook': 'facebook', 'google': 'google',
    'twitter': 'twitter', 'email': 'email'
}

class User(TrackingModel, PermissionsMixin, AbstractBaseUser):
    """
    An abstract base class implementing a fully featured User model with
    admin-compliant permissions.

    Username and password are required. Other fields are optional.
    """

    username_validator = UnicodeUsernameValidator()

    username = models.CharField(
        _("username"),
        max_length=255,
        unique=True,
        help_text=_(
            "Required. 255 characters or fewer. Letters, digits and @/./+/-/_ only."
        ),
        validators=[username_validator],
        error_messages={
            "unique": _("A user with that username already exists."),
        },
    )
    first_name = models.CharField(_("first name"), max_length=255, blank=True, null=True)

    last_name = models.CharField(_("last name"), max_length=255, blank=True, null=True)

    url_image = models.ImageField( _('Image'), upload_to = upload_to, default ='users/def0ault.jpg', blank=True, null=True)
    
    email = models.EmailField(_("email address"), blank=False, unique=True)
    # email = models.CharField(_("email address"), max_length=255, blank=False, unique=True)
    
    is_staff = models.BooleanField(
        _("staff status"),
        default=False,
        help_text=_("Designates whether the user can log into this admin site."),
    )
    is_active = models.BooleanField(
        _("active"),
        default=True,
        help_text=_(
            "Designates whether this user should be treated as active. "
            "Unselect this instead of deleting accounts."
        ),
    )
    date_joined = models.DateTimeField(_("date joined"), default=timezone.now)

    email_verified =  models.BooleanField(
        _("email_verified"),
        default=False,
        help_text=_(
            "Designates whether this users email verified. "
        ),
    )
    
    auth_provider = models.CharField(
        max_length = 255, blank = False,
        null = False, default = AUTH_PROVIDERS.get('email')
    )
    objects = MyUserManager()

    EMAIL_FIELD = "email"
    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = ["username", "first_name", "last_name"]

    def __str__(self):
        return self.email + " " + str(self.id)


    def tokens(self):

       refresh = RefreshToken.for_user(self)
       return{
            'refresh': str(refresh),
            'access':str(refresh.access_token)
       }


    class Meta:
        db_table = 'user'

    
