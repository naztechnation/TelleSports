import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';

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
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 294.h,
                          margin: EdgeInsets.only(
                            left: 16.h,
                            right: 51.h,
                          ),
                          child: Text(
                            "Quick and easy bet code conversions...",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                CustomTextStyles.headlineLargePrimary.copyWith(
                              height: 1.10,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.v),
                        Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text(
                            "Quick and easy bet code conversions...",
                            style: CustomTextStyles.titleMediumTeal400,
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
                    dotWidth: 8.h,
                  ),
                ),
              ),
              SizedBox(height: 12.v),
              CustomElevatedButton(
                text: "Create an account",
                margin: EdgeInsets.symmetric(horizontal: 12.h),
                onPressed: (() =>  Navigator.pushNamed(context, AppRoutes.onboardingTwoScreen)),
              ),
              SizedBox(height: 16.v),
              CustomOutlinedButton(
                text: "Log in to your account",
                margin: EdgeInsets.symmetric(horizontal: 12.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
