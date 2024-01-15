import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

import '../../handlers/secure_handler.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../widgets/custom_icon_button.dart';
import '../auth/signin_screen/sign_in_screen.dart';
import '../landing_page/landing_page.dart';
import '../onboarding_screen/onboarding_main.dart';
import '../onboarding_screen/widget/fading_sliding_in.dart';
import 'welcome_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  startTimeout() {
    return Timer(const Duration(hours: 5), handleTimeout);
  }

  late AnimationController _animationController;

  void handleTimeout() {
    changeScreen();
  }
 
  String userLoggedIn = '';
  String isonBoarding = '';

  getUserDetails() async {
    userLoggedIn = await StorageHandler.getLoggedInState();
    isonBoarding = await StorageHandler.getOnBoardState();
  }

  Future<void> changeScreen() async {
    if (isonBoarding == '') {
      AppNavigator.pushAndReplacePage(context, page: SplashScreenOnboardingScreen());
    } else if (userLoggedIn == '') {
          AppNavigator.pushAndReplacePage(context, page: SigninScreen());

    } else  {
          AppNavigator.pushAndStackPage(context, page: LandingPage());

    }

     
  }

  @override
  void initState() {
    getUserDetails();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();
    super.initState();
    startTimeout();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadingSlidingWidget(
                animationController: _animationController,
                interval: const Interval(0.5, 0.9),
                child: CustomIconButton(
                          height: 32.adaptSize,
                          width: 32.adaptSize,
                          padding: EdgeInsets.all(5.h),
                          decoration: IconButtonStyleHelper.fillPrimary,
                          child: CustomImageView(
                              imagePath: ImageConstant.imgLightBulb)),
              ),
              const SizedBox(
                width: 6,
              ),
              CustomImageView(
                          imagePath: ImageConstant.imgTellasportLogo,
                          height: 44.v,
                          width: 280.h),
            ],
          ),
           
        ],
      ),
    );
  }
}
