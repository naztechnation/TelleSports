import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';

import '../../handlers/secure_handler.dart';
import '../../utils/navigator/page_navigator.dart';
import '../auth/sign_in_screen/sign_in_screen.dart';
import '../auth/sign_up_screen/sign_up_screen.dart';

class OnboardingTwoScreen extends StatelessWidget {
  const OnboardingTwoScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 10.h,
            vertical: 53.v,
          ),
          child: Column(
            children: [
              SizedBox(height: 26.v),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                     Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Align(
                            child: Text(
                              "Connect with a Vibrant Community of Sports Enthusiasts...",
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style:
                                  CustomTextStyles.headlineLargeBlue400.copyWith(
                                height: 1.10,
                                fontSize: 28.0,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                    
                    
                    Spacer(),
                    CustomImageView(
                      imagePath: ImageConstant.imgSportBasketball,
                      height: 358.v,
                      width: 368.h,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.v),
              SizedBox(
                height: 8.v,
                child: AnimatedSmoothIndicator(
                  activeIndex: 1,
                  count: 3,
                  effect: ScrollingDotsEffect(
                    spacing: 8,
                    activeDotColor: appTheme.blue800,
                    dotColor: appTheme.blue50,
                    dotHeight: 8.v,
                    dotWidth: 16.h,
                  ),
                ),
              ),
              SizedBox(height: 12.v),
              CustomElevatedButton(
                text: "Create an account",
                margin: EdgeInsets.symmetric(horizontal: 9.h),
                buttonStyle: CustomButtonStyles.fillBlue,
                onPressed: (() =>  onTapCreateAnAccount(context)),

              ),
              SizedBox(height: 16.v),
              CustomOutlinedButton(
                text: "Log in to your account",
                margin: EdgeInsets.symmetric(horizontal: 9.h),
                onPressed: (() =>  onTapLogInToYourAccount(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

   onTapCreateAnAccount(BuildContext context) {
    AppNavigator.pushAndReplacePage(context, page: SignUpScreen());
    StorageHandler.saveOnboardState('true');

  }
 
  onTapLogInToYourAccount(BuildContext context) {
    AppNavigator.pushAndReplacePage(context, page: SigninScreen());

    StorageHandler.saveOnboardState('true');


  }
}
