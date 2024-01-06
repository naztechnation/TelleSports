import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_icon_button.dart';

import '../onboarding_screen/onboarding_main.dart';

class SplashScreenOnboardingScreen extends StatelessWidget {
  const SplashScreenOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 70.v),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: 54),
                      CustomImageView(
                          imagePath: ImageConstant.imgTellasportLogo,
                          height: 44.v,
                          width: 280.h),
                      Spacer(flex: 45),
                      CustomIconButton(
                          height: 32.adaptSize,
                          width: 32.adaptSize,
                          padding: EdgeInsets.all(5.h),
                          decoration: IconButtonStyleHelper.fillPrimary,
                          child: CustomImageView(
                              imagePath: ImageConstant.imgLightBulb)),
                      SizedBox(height: 11.v),
                      Container(
                          width: 343.h,
                          margin: EdgeInsets.symmetric(horizontal: 3.h),
                          child: Text(
                              "An all-in-one platform to convert bet codes, view livescores and interact with a vibrant community of sports and betting enthusiasts. ",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: CustomTextStyles.labelMediumBlack900)),
                      SizedBox(height: 9.v),
                      CustomElevatedButton(
                          text: "Continue",
                          onPressed: () {
                            onTapContinue(context);
                          })
                    ]))));
  }

  onTapContinue(BuildContext context) {
    AppNavigator.pushAndReplacePage(context, page: OnboardingMain());
  }
}
