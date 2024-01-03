import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';

class OnboardingThreeScreen extends StatelessWidget {
  const OnboardingThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 53.v),
                  child: Column(children: [
                    SizedBox(height: 26.v),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 1.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 294.h,
                                  margin: EdgeInsets.only(left: 2.h, right: 49.h),
                                  child: Text(
                                      "Quick and easy bet code conversions...",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyles.headlineLargeRed400
                                          .copyWith(height: 1.10))),
                              SizedBox(height: 5.v),
                              Padding(
                                  padding: EdgeInsets.only(left: 2.h),
                                  child: Text(
                                      "Quick and easy bet code conversions...",
                                      style: CustomTextStyles.titleMediumRed300)),
                              SizedBox(height: 88.v),
                              CustomImageView(
                                  imagePath: ImageConstant.imgSportBaseball,
                                  height: 376.v,
                                  width: 329.h,
                                  margin: EdgeInsets.only(left: 17.h))
                            ])),
                    SizedBox(height: 24.v),
                    SizedBox(
                        height: 8.v,
                        child: AnimatedSmoothIndicator(
                            activeIndex: 0,
                            count: 3,
                            effect: ScrollingDotsEffect(
                                spacing: 8,
                                activeDotColor: appTheme.red400,
                                dotColor: appTheme.deepOrange50,
                                dotHeight: 8.v,
                                dotWidth: 8.h))),
                    SizedBox(height: 12.v),
                    CustomElevatedButton(
                        text: "Create an account",
                        buttonStyle: CustomButtonStyles.fillRed,
                        onPressed: () {
                          onTapCreateAnAccount(context);
                        }),
                    SizedBox(height: 16.v),
                    CustomOutlinedButton(
                        text: "Log in to your account",
                        onPressed: () {
                          onTapLogInToYourAccount(context);
                        })
                  ])),
            )));
  }

  onTapCreateAnAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }
 
  onTapLogInToYourAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signinOneScreen);
  }
}
