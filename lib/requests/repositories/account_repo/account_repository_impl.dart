import 'package:tellesports/model/auth_model/login.dart';
import 'package:tellesports/model/auth_model/register.dart';

import '../../../model/auth_model/bookies.dart';
import '../../../res/app_strings.dart';
import '../../../widgets/modals.dart';
import '../../setup/requests.dart';
import 'account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  Future<RegisterUser> registerUser({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    final map = await Requests().post(AppStrings.registerUserUrl, body: {
      "username": username,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
      "phone": phone,
    });
    return RegisterUser.fromJson(map);
  }

  @override
  Future<LoginUser> loginUser(
      {required String email, required String password}) async {
    final map = await Requests().post(AppStrings.loginUrl, body: {
      "email": email,
      "password": password,
    });
    return LoginUser.fromJson(map);
  }

  @override
  Future<RegisterUser> verifyCode(
      {required String code, required String email, required String url}) async {

      
    final map = await Requests().post(url, body: {
      "email": email,
      "code": code,
    });
    return RegisterUser.fromJson(map);
  }

  @override
  Future<RegisterUser> resendVerifyCode({required String email}) async {
    final map = await Requests().post(AppStrings.resendVerifyCodeUrl, body: {
      "email": email,
    });
    return RegisterUser.fromJson(map);
  }

  @override
  Future<RegisterUser> forgetPassword({required String email}) async {
    final map = await Requests().post(AppStrings.forgetPasswordUrl, body: {
      "email": email,
    });
    return RegisterUser.fromJson(map);
  }

  

  @override
  Future<RegisterUser> resetPassword(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    final map = await Requests().post(AppStrings.resetPasswordUrl, body: {
      "email": email,
      "password": email,
      "password_confirmation": email,
    });
    return RegisterUser.fromJson(map);
  }

  @override
  Future<RegisterUser> changePassword(
      {required String oldPassword,
      required String password,
      required String confirmPassword}) async {
    final map = await Requests().post(AppStrings.changePasswordPasswordUrl, body: {
      "old_password": oldPassword,
      "password": password,
      "password_confirmation": oldPassword,
    });
    return RegisterUser.fromJson(map);
  }

  @override
  Future<BookiesList> getBookies() async {
    final map = await Requests().post(
      AppStrings.getBookiesUrl,
    );

    return BookiesList.fromJson(map);
  }
}
