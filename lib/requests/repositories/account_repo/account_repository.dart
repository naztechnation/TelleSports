import 'package:tellesports/model/auth_model/register.dart';

import '../../../model/auth_model/login.dart';

abstract class AccountRepository {
  Future<RegisterUser> registerUser({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  });

  Future<LoginUser> loginUser({
    required String email,
    required String password,
  });
  Future<RegisterUser> verifyCode({
    required String code,
    required String email,
  });
  Future<RegisterUser> resendVerifyCode({
    required String email,
  });
  Future<RegisterUser> forgetPassword({
    required String email,
  });
  Future<RegisterUser> verifyResetPassword({
    required String email,
    required String code,
  });
  Future<RegisterUser> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  });
  Future<RegisterUser> changePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  });
}
