import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../handlers/secure_handler.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../widgets/custom_icon_button.dart';
import '../auth/sign_in_screen/sign_in_screen.dart';
import '../landing_page/landing_page.dart';
import '../onboarding_screen/widget/fading_sliding_in.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  startTimeout() {
    return Timer(const Duration(seconds: 5), handleTimeout);
  }

  late AnimationController _animationController;
  late Animation<double> _animation;

  void handleTimeout() {
    changeScreen();
  }

  String userLoggedIn = '';
  String isonBoarding = '';

  getUserDetails() async {
    userLoggedIn = await StorageHandler.getLoggedInState() ?? '';
    isonBoarding = await StorageHandler.getOnBoardState() ?? '';
  }

  Future<void> changeScreen() async {
    if (isonBoarding == '') {
      AppNavigator.pushAndReplacePage(context,
          page: SplashScreenOnboardingScreen());
    } else if (userLoggedIn == '') {
       AppNavigator.pushAndReplacePage(context,
          page: SplashScreenOnboardingScreen());
    } else {
      AppNavigator.pushAndStackPage(context, page: LandingPage());
    }
  }

  @override
  void initState() {
    getUserDetails();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    );

    final Animation<double> curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(curve);

    _animationController.forward();
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
    return   Scaffold(
      body: Stack(
        children: [
           
          Container(height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            color: Colors.green.shade100,
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadingSlidingWidget(
                      animationController: _animationController,
                      interval: const Interval(0.5, 0.9),
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, 100 * (1 - _animation.value)),
                            child: child,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: CustomIconButton(
                              height: 120.adaptSize,
                              width: 120.adaptSize,
                              padding: EdgeInsets.all(5.h),
                              decoration: IconButtonStyleHelper.fillPrimary,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: CustomImageView(
                                    imagePath: ImageConstant.imgLightBulb),
                              )),
                        ),
                      ),
                      // const SizedBox(
                      //   width: 6,
                      // ),
                      // CustomImageView(
                      //             imagePath: ImageConstant.imgTellasportLogo,
                      //             height: 44.v,
                      //             width: 180.h),
                    )
                  ],
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}