import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';

import '../../../widgets/custom_outlined_button.dart';
import '../../app_navigation_screen/app_navigation_screen.dart';

// ignore: must_be_immutable
class CommunityleaderItemWidget extends StatelessWidget {
  final List<String> body;
  final Map<String, dynamic> data;

  const CommunityleaderItemWidget({
    Key? key,
    required this.body,
    required this.data,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: AppDecoration.fillBlueGray.copyWith(
      //   borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
      //   color: data['bg']
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 105.v,
            width: 350.h,
            decoration: BoxDecoration(
              color: data['color'],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                CustomImageView(
                  color: Color(0xFF144432),
                  imagePath: ImageConstant.imgEllipse751x317,
                  height: 51.v,
                  width: 317.h,
                  alignment: Alignment.bottomRight,
                ),
                CustomImageView(
                  color: Color(0xFF144432),

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
                                "${data['title']}".toUpperCase(),
                                style:
                                    CustomTextStyles.bodyMediumDMSansWhiteA700,
                              ),
                              SizedBox(height: 1.v),
                              Text(
                                "${data['amount']}".toUpperCase(),
                                style: CustomTextStyles
                                    .headlineLargeInterWhiteA700,
                              ),
                            ],
                          ),
                        ),
                        if (data['isCommunity'] == true)
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
          for (String bodyItem in body)
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
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        bodyItem,
                        style: CustomTextStyles.titleSmallBluegray900Bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 15.v),
          if (data['isCommunity'] == true) ...[
            CustomElevatedButton(
              text: "Buy now",
              margin: EdgeInsets.symmetric(horizontal: 12.h),
              alignment: Alignment.center,
            ),
          ] else ...[
            _buildBuyTellacoins(context),
          ],
          SizedBox(height: 24.v),
        ],
      ),
    );
  }

  Widget _buildBuyTellacoins(BuildContext context) {
    return CustomOutlinedButton(
        text: "Buy Now", margin: EdgeInsets.symmetric(horizontal: 20.h),
        onPressed: () {
          AppNavigator.pushAndStackPage(context, page: AppNavigationScreen());
        },
        );
  }
}
