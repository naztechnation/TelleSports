class AppStrings {
  static const String appName = 'Lucacify';

  static const String networkErrorMessage = "Network error, try again later";


  ///flutterwave api
  static const String flutterwaveApiKey =
      "FLWPUBK_TEST-19d0771972c3f0b4a8a4034d5d8b62b0-X";

  ///base url

  static const String _baseUrl = 'https://tellasport.com/api/v1/';

  ///auth urls

  static String registerUserUrl = '${_baseUrl}register';

  static String loginUrl = '${_baseUrl}login';

  static String verifyCodeUrl = '${_baseUrl}email_verification';

  static String resendVerifyCodeUrl = '${_baseUrl}resend_code';
  static String forgetPasswordUrl = '${_baseUrl}forget_password';
  static String verifyForgetPasswordUrl = '${_baseUrl}verify_code';
  static String resetPasswordUrl = '${_baseUrl}reset_password';
  static String changePasswordPasswordUrl = '${_baseUrl}change_password';

  static String planUrl = '${_baseUrl}plans';
  static String confirmPaymentUrl = '${_baseUrl}confirm_flutterwave_subscription';
  static String reconfirmPaymentUrl = '${_baseUrl}reconfirm';
  static String conversionHistoryUrl = '${_baseUrl}conversation_history';
  static String getBookiesUrl = '${_baseUrl}bookies';
  static String getNotificationsUrl = '${_baseUrl}notification';
  static String getNotificationsDetailsUrl(String notifyId) => '${_baseUrl}notification/$notifyId';
  static String userWalletUrl = '${_baseUrl}user_wallet';
  static String converterUrl = '${_baseUrl}convert';
  static String updateUserProfileUrl = '${_baseUrl}profile';
  static String uploadUserImageUrl = '${_baseUrl}upload_profile_image';
  static String deleteUserUrl(String userId) => '${_baseUrl}delete-account/$userId';
  static String transferTellacoinUrl = '${_baseUrl}transfer-coin';
  static String updateAccountUrl = '${_baseUrl}update_account_details';

  
  
  
  
}
