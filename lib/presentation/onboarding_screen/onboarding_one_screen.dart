import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';

import '../../utils/navigator/page_navigator.dart';
import '../auth/signin_screen/sign_in_screen.dart';
import '../auth/sign_up_screen/sign_up_screen.dart';

class OnboardingOneScreen extends StatelessWidget {
  const OnboardingOneScreen({Key? key})
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
            horizontal: 7.h,
            vertical: 53.v,
          ),
          child: Column(
            children: [
              SizedBox(height: 26.v),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Align(
                            child: Text(
                              "Quick and easy bet code conversions...",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style:
                                  CustomTextStyles.headlineLargePrimary.copyWith(
                                height: 1.12,
                                fontSize: 27.0,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        CustomImageView(
                          imagePath: ImageConstant.imgSportOutdoor,
                          height: 292.v,
                          width: 354.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.v),
              SizedBox(
                height: 8.v,
                child: AnimatedSmoothIndicator(
                  activeIndex: 0,
                  count: 3,
                  effect: ScrollingDotsEffect(
                    spacing: 8,
                    activeDotColor: appTheme.teal400,
                    dotColor: appTheme.teal100,
                    dotHeight: 8.v,
                    dotWidth: 16.h,
                  ),
                ),
              ),
              SizedBox(height: 12.v),
              CustomElevatedButton(
                text: "Create an account",
                margin: EdgeInsets.symmetric(horizontal: 12.h),
                                onPressed: (() =>  onTapCreateAnAccount(context)),

              ),
              SizedBox(height: 16.v),
              CustomOutlinedButton(
                text: "Log in to your account",
                margin: EdgeInsets.symmetric(horizontal: 12.h),
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
