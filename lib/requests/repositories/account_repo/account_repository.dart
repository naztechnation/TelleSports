import 'dart:io';

import 'package:tellesports/model/auth_model/register.dart';

import '../../../model/auth_model/bookies.dart';
import '../../../model/auth_model/bookies_details.dart';
import '../../../model/auth_model/confirm_subscriptions.dart';
import '../../../model/auth_model/converter_history.dart';
import '../../../model/auth_model/login.dart';
import '../../../model/auth_model/notifications.dart';
import '../../../model/auth_model/notifications_details.dart';
import '../../../model/auth_model/plans_list.dart';
import '../../../model/auth_model/reconfirm_sub.dart';

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
    required String url,
  });
  Future<RegisterUser> resendVerifyCode({
    required String email,
  });
  Future<RegisterUser> forgetPassword({
    required String email,
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

    Future<BookiesList> getBookies();

    Future<BookiesDetails> convertBetCode({
    required String from,
    required String to,
    required String bookingCode,
    required String apiKey,
  });


  Future<ConverterHistory> getConversionHistory();

  Future<PlansList> getPlansList();

   Future<NotificationsList> getNotificationsList();
   Future<NotificationsDetails> getNotificationsDetails({required String notifyId});

   Future<ConfirmSubscription> confirmSubscription(
      {required String? id, required String? plan, required String url});

 

  Future<ConfirmedSubscription> reconfirmTransaction({
    required String planId,
    required String transactionId,
    required String accessToken,
  });

  Future<RegisterUser> uploadProfileImage({
    required File image,
    
  });

   Future<LoginUser> uploadUserProfile({
    required File image,
    required String phone,
    
  });

    Future<LoginUser> deleteUserData({
    
    required String userId,
    
  });

}
