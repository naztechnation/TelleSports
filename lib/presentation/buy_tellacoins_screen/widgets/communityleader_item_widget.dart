import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';

// ignore: must_be_immutable
class CommunityleaderItemWidget extends StatelessWidget {
  const CommunityleaderItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 82.v,
            width: 350.h,
            decoration: AppDecoration.fillTeal,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse751x317,
                  height: 51.v,
                  width: 317.h,
                  alignment: Alignment.bottomRight,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse85,
                  height: 40.v,
                  width: 288.h,
                  alignment: Alignment.topLeft,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.h, 12.v, 12.h, 8.v),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2.v),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Community leader".toUpperCase(),
                                style:
                                    CustomTextStyles.bodyMediumDMSansWhiteA700,
                              ),
                              SizedBox(height: 1.v),
                              Text(
                                "N2000".toUpperCase(),
                                style: CustomTextStyles
                                    .headlineLargeInterWhiteA700,
                              ),
                            ],
                          ),
                        ),
                        CustomElevatedButton(
                          height: 23.v,
                          width: 82.h,
                          text: "Best Deal".toUpperCase(),
                          margin: EdgeInsets.only(bottom: 38.v),
                          buttonStyle: CustomButtonStyles.fillTeal,
                          buttonTextStyle: CustomTextStyles.labelLargeInter,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.v),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgIcRoundCheck,
                  height: 17.adaptSize,
                  width: 17.adaptSize,
                  margin: EdgeInsets.only(bottom: 1.v),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "150 Tellacoins",
                    style: CustomTextStyles.titleSmallBluegray900Bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 7.v),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgIcRoundCheck,
                  height: 17.adaptSize,
                  width: 17.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "Create and manage a community.",
                    style: CustomTextStyles.labelLargeBluegray900,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 7.v),
          Padding(
            padding: EdgeInsets.only(
              left: 12.h,
              right: 32.h,
            ),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgIcRoundCheck,
                  height: 17.adaptSize,
                  width: 17.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "Earn rewards and money through your community.",
                    style: CustomTextStyles.labelLargeBluegray900,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.v),
          CustomElevatedButton(
            text: "Buy now",
            margin: EdgeInsets.symmetric(horizontal: 12.h),
            alignment: Alignment.center,
          ),
          SizedBox(height: 24.v),
        ],
      ),
    );
  }
}
