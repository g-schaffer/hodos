class ApiConstants {
  static String baseUrl = 'http://guillaumeschaffer.fr:8000';
  static String register = '/api/auth/register';
  static String login = '/api/auth/login';
  static String recover = '/api/auth/request_reset_email';
  static String recoverCompleted = '/api/auth/password_reset_complete';
  static String logout = '/api/auth/logout';
}