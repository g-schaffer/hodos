import email
from lib2to3.pgen2.tokenize import TokenError
from rest_framework import serializers
from user_management.models import User
from django.contrib.auth.password_validation import validate_password
from django.utils.encoding import force_str, DjangoUnicodeDecodeError
from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django.utils.http import urlsafe_base64_decode
from rest_framework.exceptions import AuthenticationFailed
from django.contrib.auth import authenticate
from rest_framework_simplejwt.tokens import RefreshToken
from .models import User

################# User data ##############################
class UserSerializer(serializers.ModelSerializer):
    
        class Meta:
            model = User
            fields = ('id', 'username', 'email', 'first_name', 'last_name', 'url_image')

class StrictUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('username', 'url_image')

################# Inscription #############################
class RegisterSerializer(serializers.ModelSerializer):

    password = serializers.CharField(max_length= 255, min_length= 6, write_only= True)
    email = serializers.EmailField(max_length= 128, min_length= 6)    
    username = serializers.CharField(required=False)
    url_image = serializers.ImageField(required=False)
    first_name = serializers.CharField(required=False)
    last_name = serializers.CharField(required=False)
    
    class Meta:
        model = User
        fields = ('username', 'email', 'password', 'first_name', 'last_name', 'url_image')


    def create(self, validated_data):
        return User.objects.create_user(**validated_data)


################# Email Verification #############################
class EmailVerificationSerializer(serializers.Serializer):

    token = serializers.CharField(max_length=555)

    class Meta:
        model = User
        fields = ['token']


################# Connexion #############################        
class LoginSerializer(serializers.Serializer):

    username = serializers.CharField(max_length= 255, min_length= 3, read_only= True)
    email = serializers.EmailField(max_length= 128, min_length= 6)
    password = serializers.CharField(max_length= 255, min_length= 3, write_only= True)
    tokens = serializers.SerializerMethodField()

    def get_tokens(self, obj):

        user = User.objects.get(email=obj['email'])

        return{
            'access': user.tokens()['access'],
            'refresh': user.tokens()['refresh']
        }

    class Meta:
        model = User
        fields = ('email','username', 'password', 'tokens')

    def validate(self, attrs):
        email = attrs.get('email', '')
        password = attrs.get('password', '')
        usrs = User.objects.filter(email=email)
        user = authenticate(email = email, password = password)
        if not user:
           raise AuthenticationFailed('Invalid credentials, no user')

        if not user.is_active:
           raise AuthenticationFailed('Account disabled, contact admin')

        if not user.email_verified:
           raise AuthenticationFailed('Email is not verified')

        return {
            'email':user.email,
            'username': user.username,
            'tokens': user.tokens
         }

        return super().validate(attrs)


class ResetPasswordResetEmailSerializer(serializers.Serializer):

    email = serializers.EmailField(min_length=2)

    class Meta:
        model: User
        fields = ['email']

   
class SetNewPasswordSerializer(serializers.Serializer):

    password = serializers.CharField(min_length=6, max_length= 68, write_only=True)
    token = serializers.CharField(min_length=1, write_only=True)
    uidb64 = serializers.CharField(min_length=1, write_only=True)

    class Meta:
        fields = ['password', 'token', 'uidb64']

    def validate(self, attrs):

        try:

            password = attrs.get('password')
            token = attrs.get('token')
            uidb64 = attrs.get('uidb64')

            id = force_str(urlsafe_base64_decode(uidb64))
            user = User.objects.get(id=id)

            if not PasswordResetTokenGenerator().check_token(user, token):
                raise AuthenticationFailed('The reset link is invalid', 401)
            
            user.set_password(password)
            user.save()

        except Exception as e :
            raise AuthenticationFailed('The reset link is invalid', 401)  
        return super().validate(attrs)


class LogouSerializer(serializers.Serializer):

    refresh = serializers.CharField()

    default_error_messages = {
        'bad_token': ('Token is expired or invalid')
    }

    def validate(self, attrs):
        self.token = attrs['refresh']
        return super().validate(attrs)

    def save(self, **kwargs):
        try:
            RefreshToken(self.token).blacklist()
        except TokenError:
            self.fail('bad_token')