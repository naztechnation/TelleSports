import 'package:flutter/material.dart';
import 'package:tellesports/presentation/splash_screen_onboarding_screen/splash_screen_onboarding_screen.dart';
import 'package:tellesports/presentation/onboarding_screen/onboarding_one_screen.dart';
import 'package:tellesports/presentation/onboarding_screen/onboarding_two_screen.dart';
import 'package:tellesports/presentation/onboarding_screen/onboarding_three_screen.dart';
import 'package:tellesports/presentation/auth/sign_up_screen/sign_up_screen.dart';
import 'package:tellesports/presentation/auth/signin_screen/signin_screen.dart';
import 'package:tellesports/presentation/manage_account/forgot_password_screen/forgot_password_screen.dart';
import 'package:tellesports/presentation/manage_account/verify_account_screen/verify_account_screen.dart';
import 'package:tellesports/presentation/manage_account/create_new_password_screen/create_new_password_screen.dart';
import 'package:tellesports/presentation/buy_tellacoins_screen/buy_tellacoins_screen.dart';
import 'package:tellesports/presentation/community_chat_screen/community_chat_screen.dart';
import 'package:tellesports/presentation/gift_tellacoins_screen/gift_tellacoins_screen.dart';
import 'package:tellesports/presentation/community_info_screen/community_info_screen.dart';

class AppRoutes {
  static const String splashScreenOnboardingScreen =
      '/splash_screen_onboarding_screen';

  static const String onboardingOneScreen = '/onboarding_one_screen';

  static const String onboardingThreeScreen = '/onboarding_three_screen';

  static const String onboardingTwoScreen = '/onboarding_two_screen';

  static const String signUpScreen = '/sign_up_screen';

 

  static const String signinScreen = '/signin_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String verifyAccountScreen = '/verify_account_screen';

  static const String createNewPasswordScreen = '/create_new_password_screen';

  static const String convertBetcodesoneOnePage =
      '/convert_betcodesone_one_page';

  static const String convertBetcodesthreePage = '/convert_betcodesthree_page';

  static const String convertBetcodestwoPage = '/convert_betcodestwo_page';

  static const String convertBetcodesfourPage = '/convert_betcodesfour_page';

  static const String convertBetcodesonePage = '/convert_betcodesone_page';

  static const String convertBetcodesoneTabContainerPage =
      '/convert_betcodesone_tab_container_page';

  static const String convertBetcodesoneContainerScreen =
      '/convert_betcodesone_container_screen';

  static const String viewLivescoresonePage = '/view_livescoresone_page';

  static const String viewLivescorestwoScreen = '/view_livescorestwo_screen';

  static const String buyTellacoinsScreen = '/buy_tellacoins_screen';

  static const String communityOnePage = '/community_one_page';

  static const String communityTwoPage = '/community_two_page';

  static const String communityChatScreen = '/community_chat_screen';

  static const String communityChatCondensedScreen =
      '/community_chat_condensed_screen';

  static const String communityChatEmptyStateScreen =
      '/community_chat_empty_state_screen';

  static const String communityInfoTwoPage = '/community_info_two_page';

  static const String communityInfoOneScreen = '/community_info_one_screen';

  static const String directMessagesCondensedScreen =
      '/direct_messages_condensed_screen';

  static const String userInfoPage = '/user_info_page';

  static const String userInfoTabContainerScreen =
      '/user_info_tab_container_screen';

  static const String giftTellacoinsScreen = '/gift_tellacoins_screen';

  static const String communityPage = '/community_page';

  static const String communityTabContainerPage =
      '/community_tab_container_page';

  static const String communityInfoScreen = '/community_info_screen';

  static const String predictionsTwoPage = '/predictions_two_page';

  static const String predictionsPage = '/predictions_page';

  static const String predictionsOneScreen = '/predictions_one_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    splashScreenOnboardingScreen: (context) => SplashScreenOnboardingScreen(),
    onboardingOneScreen: (context) => OnboardingOneScreen(),
    onboardingThreeScreen: (context) => OnboardingThreeScreen(),
    onboardingTwoScreen: (context) => OnboardingTwoScreen(),
    signUpScreen: (context) => SignUpScreen(),
     
    signinScreen: (context) => SigninScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    verifyAccountScreen: (context) => VerifyAccountScreen(),
    createNewPasswordScreen: (context) => CreateNewPasswordScreen(),
    
    buyTellacoinsScreen: (context) => BuyTellacoinsScreen(),
    communityChatScreen: (context) => CommunityChatScreen(),
    
    
    giftTellacoinsScreen: (context) => GiftTellacoinsScreen(),
    communityInfoScreen: (context) => CommunityInfoScreen(),
  };
}
