from user_management import views
from django.urls import path
from rest_framework_simplejwt.views import (TokenRefreshView)


urlpatterns = [

    path('user', views.UserAPIView.as_view(), name="user"),
    path('register', views.RegisterAPIView.as_view(), name="register"),
    path('email-verify', views.VerifyEmail.as_view(), name="email-verify"),
    path('login', views.LoginAPIView.as_view(), name="login"),


    # NOTE : no need to call back to logout user : see https://stackoverflow.com/questions/40604877/how-to-delete-a-django-jwt-token
    # path('logout', views.LogoutAPIView.as_view(), name="logout"),

    path('token/refresh', TokenRefreshView.as_view(), name="token"),
    path('password_reset/<uidb64>/<token>/', views.PasswordTokenCheckAPI.as_view(), name='password_reset_confirm'),
    path('request_reset_email', views.RequestPasswordResetEmail.as_view(), name='request_reset_email'),
    path('password_reset_complete', views.SetNewPasswordAPI.as_view(), name='password_reset_complete'),

    # path('change_password', views.ChangePasswordView.as_view(), name='auth_change_password'),
    # path('update_profile/<int:pk>/', views.UpdateProfileView.as_view(), name='auth_update_profile'),

]


