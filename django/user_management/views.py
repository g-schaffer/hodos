from django.conf import settings
from rest_framework.generics import GenericAPIView
from user_management.serializes import RegisterSerializer, LoginSerializer, EmailVerificationSerializer,ResetPasswordResetEmailSerializer, SetNewPasswordSerializer, LogouSerializer, UserSerializer
from rest_framework import response, status, permissions, views
from user_management.models import User
from rest_framework.parsers import MultiPartParser, FormParser
from django.utils.encoding import smart_str , DjangoUnicodeDecodeError, smart_bytes
from django.utils.http import urlsafe_base64_decode, urlsafe_base64_encode
from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django.contrib.sites.shortcuts import get_current_site
from django.urls import reverse
import jwt
from .utils import Util
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from .renderers import UserRender


class RegisterAPIView(GenericAPIView):
    
    authentication_classes = []

    renderer_classes = (UserRender, )
    
    serializer_class = RegisterSerializer

    parser_classes = [MultiPartParser, FormParser]

    def post(self, request, format = None):

        user = request.data
        serializer = self.serializer_class(data=user)
        if not serializer.is_valid():
            raise Exception(serializer.errors)

        serializer.save()
        
        user_data = serializer.data

        user = User.objects.get(email=user_data['email'])

        token = RefreshToken.for_user(user).access_token

        current_site = get_current_site(request).domain

        relativeLink = reverse('email-verify')

        absurl = 'http://'+current_site+relativeLink+"?token="+str(token)

        email_body ='Hi' +user.username+' Use link below to verify your email \n'+ absurl
        
        data = {
            'email_body': email_body, 
            'to_email': user.email, 
            'email_subject': 'Verify your email '
        }

        Util.send_email(data)

        return response.Response(user_data, status=status.HTTP_201_CREATED)

class VerifyEmail(views.APIView):

    serializer_class = EmailVerificationSerializer

    token_param_config = openapi.Parameter('token', in_=openapi.IN_QUERY, description='Description', type=openapi.TYPE_STRING)

    @swagger_auto_schema(manual_parameters=[token_param_config])

    def get(self, request):

        # !! this token is not the usual JWT created with auth/login !! 
        # this token is created while registering and send to the user's email
        token = request.GET.get('token')
        
        try:
            payload = jwt.decode(token, settings.SECRET_KEY, algorithms=["HS256"])
            user = User.objects.get(id=payload['user_id'])
            if not user.email_verified:
                user.email_verified = True
                user.save()
            return response.Response({'email':'Successful activated'}, status=status.HTTP_200_OK)

        except jwt.ExpiredSignatureError as identifier:
            return response.Response({'error': 'Activation Expired'}, status=status.HTTP_400_BAD_REQUEST)
        
        except jwt.exceptions.DecodeError as identifier:
            return response.Response({'error': 'Invalid token'}, status=status.HTTP_400_BAD_REQUEST)

class LoginAPIView(GenericAPIView):

    serializer_class = LoginSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        return response.Response(serializer.data, status=status.HTTP_200_OK)


# ################# Reset password APIView #############################
class RequestPasswordResetEmail(GenericAPIView):

    serializer_class = ResetPasswordResetEmailSerializer

    def post(self, request):

        serializer = self.serializer_class(data=request.data)
        email = request.data['email']

        if User.objects.filter(email=email).exists():

            user = User.objects.get(email=email)
            uidb64 = urlsafe_base64_encode(smart_bytes(user.id))
            token = PasswordResetTokenGenerator().make_token(user)
            current_site = get_current_site(request=request).domain

            relativeLink = reverse('password_reset_confirm', kwargs={
                    'uidb64': uidb64,
                    'token': token
                })
            absurl = 'http://'+current_site + relativeLink

            email_body = 'Hello, \n Use the code below to reset your password \n' + token
            data = {
                        'email_body': email_body, 
                        'to_email': user.email,
                        'email_subject': 'Reset your password'
                        }
            Util.send_email(data)

            return response.Response(
            {'succes': 'We have sent you a link to reset your password'},
            status=status.HTTP_200_OK
            )

class PasswordTokenCheckAPI(GenericAPIView):

    def get(self, request, uidb64, token):
        
        try:

            id = smart_str(urlsafe_base64_decode(uidb64))
            user = User.objects.get(id = id)


            if not PasswordResetTokenGenerator().check_token(user, token):
                return response.Response(
                    {'error': 'Token is not valid, please request a new one'},
                    status=status.HTTP_401_UNAUTHORIZED
                )
            return response.Response(
                {'succes': True, 'message': 'Credentials Valid', 'uidb64': uidb64, 'token': token},
                status=status.HTTP_200_OK
            )

        except DjangoUnicodeDecodeError as Identifiier:
            if not PasswordResetTokenGenerator().check_token(user):
                return response.Response(
                    {'error': 'Token is not valid, please request a new one'},
                     status=status.HTTP_401_UNAUTHORIZED
                )

class SetNewPasswordAPI(GenericAPIView):

    serializer_class = SetNewPasswordSerializer

    def patch(self, request):
        serializer = self.serializer_class(data = request.data)
        serializer.is_valid(raise_exception = True)
        return response.Response({
            'succes': True,
            'message': 'Password reset success'},
            status=status.HTTP_200_OK)


        return

class UserAPIView(GenericAPIView):

    serializer_class = UserSerializer
    
    def get(self, request):

        if request.GET.get('id'):
            try:
                user = User.objects.get(id=request.GET.get('id'))
            except:
                return response.Response({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND)
        elif request.GET.get('username'):
            try:
                user = User.objects.get(username=request.GET.get('username'))
            except:
                return response.Response({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND)
        else:
            user = request.user

        serializer = self.serializer_class(user)
        return response.Response(serializer.data, status=status.HTTP_200_OK)