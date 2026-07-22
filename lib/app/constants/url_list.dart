class UrlList {
  // static const String baseUrl = 'http://10.10.29.50:8086';
  static const String baseUrl = 'https://healthy-polished-dory.ngrok-free.app';

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
  static const String nurseProfileMe = '/api/v1/nurses/me/profile/';

  static const String homeData = '/api/v1/nurses/me/dashboard/';

  static const String shifts = '/api/v1/shifts/search/';
  static String shiftDetail(int id) => '/api/v1/shifts/$id/';
  static String bookShift(int id) => '/api/v1/shifts/$id/book/';

  static const String sceduleUpcoming = '/api/v1/shifts/schedule/upcoming/';
  static const String sceduleCompleted = '/api/v1/shifts/schedule/past/';
  static const String sceduleCancelled = '/api/v1/shifts/schedule/cancelled/';
  static String scheduleClockIn(int id) =>
      '/api/v1/shifts/assignments/$id/clock-in/';
  static String scheduleClockOut(int id) =>
      '/api/v1/shifts/assignments/$id/clock-out/';
  static String scheduleCancel(int id) =>
      '/api/v1/shifts/assignments/$id/cancel/';

  static const String settings = '/api/v1/settings/';
  static const String leaderBoard = '/api/v1/rewards/leaderboard/';
  static const String profileUpdate = '/api/v1/nurses/me/profile/update/';

  static const String fcmToken = '/api/v1/notifications/fcm-device/';
  static const String notifications = '/api/v1/notifications/';

  static String readNotification(int id) => '/api/v1/notifications/$id/read/';
}
