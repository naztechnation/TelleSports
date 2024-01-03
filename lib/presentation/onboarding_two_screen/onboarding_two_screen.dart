import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';

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
                    Container(
                      width: 294.h,
                      margin: EdgeInsets.only(
                        left: 13.h,
                        right: 60.h,
                      ),
                      child: Text(
                        "Quick and easy bet code conversions...",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.headlineLargeBlue400.copyWith(
                          height: 1.10,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.v),
                    Padding(
                      padding: EdgeInsets.only(left: 13.h),
                      child: Text(
                        "Quick and easy bet code conversions...",
                        style: CustomTextStyles.titleMediumBlue300,
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
                  activeIndex: 0,
                  count: 3,
                  effect: ScrollingDotsEffect(
                    spacing: 8,
                    activeDotColor: appTheme.blue800,
                    dotColor: appTheme.blue50,
                    dotHeight: 8.v,
                    dotWidth: 8.h,
                  ),
                ),
              ),
              SizedBox(height: 12.v),
              CustomElevatedButton(
                text: "Create an account",
                margin: EdgeInsets.symmetric(horizontal: 9.h),
                buttonStyle: CustomButtonStyles.fillBlue,
                onPressed: (() =>  Navigator.pushNamed(context, AppRoutes.onboardingThreeScreen)),

              ),
              SizedBox(height: 16.v),
              CustomOutlinedButton(
                text: "Log in to your account",
                margin: EdgeInsets.symmetric(horizontal: 9.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
