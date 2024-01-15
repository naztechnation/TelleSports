class AppStrings {
  static const String appName = 'Lucacify';

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

  
  
  
}
