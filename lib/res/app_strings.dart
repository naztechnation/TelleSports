class AppStrings {
  static const String appName = 'Lucacify';

  static const String networkErrorMessage = "Network error, try again later";


  ///flutterwave api
  static const String flutterwaveApiKey =
      "FLWPUBK_TEST-e244b020ccc49bcf667b0e3f26dc056b-X";

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
  static String userWalletUrl = '${_baseUrl}user_wallet';
  static String converterUrl = '${_baseUrl}convert';


  
  
  
}
