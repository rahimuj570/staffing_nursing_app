class UrlList {
  static const String baseUrl = 'http://10.10.29.50:8086';

  static const String registerUser = '/api/v1/auth/register/';
  static const String registerUserOtp = '/api/v1/auth/verify-otp/';
  static const String registerUserResendOtp = '/api/v1/auth/resend-otp/';
  static String registerNurseProfile = '/api/v1/nurses/me/onboarding/';

  static String loginProfile = '/api/v1/auth/login/';
  static String refrteshToken = '/api/v1/auth/token/refresh/';

  static String requestForgotPasswordOTP = '/api/v1/auth/forgot-password/';
  static String verifyForgotPasswordOtp =
      '/api/v1/auth/forgot-password/verify-otp/';
  static const String forgotPasswordReset = '/api/v1/auth/reset-password/';

  static const String authMe = '/api/v1/auth/me/';
}
