import '../buy_tellacoins_screen/widgets/communityleader_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';

class BuyTellacoinsScreen extends StatelessWidget {
  const BuyTellacoinsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 21.v),
          child: Column(
            children: [
              _buildTelacoinsBalance(context),
              SizedBox(height: 16.v),
              Divider(
                color: appTheme.gray50001,
              ),
              SizedBox(height: 15.v),
              _buildCommunityLeader(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 86.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 50.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Buy Tellacoins",
        margin: EdgeInsets.only(
          top: 50.v,
          bottom: 8.v,
        ),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildStarterPlan(BuildContext context) {
    return CustomElevatedButton(
      height: 23.v,
      width: 106.h,
      text: "Starter plan".toUpperCase(),
      margin: EdgeInsets.only(right: 12.h),
      buttonStyle: CustomButtonStyles.fillTeal,
      buttonTextStyle: CustomTextStyles.labelLargeInter,
      alignment: Alignment.centerRight,
    );
  }

  /// Section Widget
  Widget _buildTelacoinsBalance(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(0),
      color: appTheme.teal800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Container(
        height: 72.v,
        width: 350.h,
        decoration: AppDecoration.fillTeal.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder8,
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgEllipse74,
              height: 41.v,
              width: 317.h,
              alignment: Alignment.bottomRight,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgEllipse84,
              height: 40.v,
              width: 288.h,
              alignment: Alignment.topLeft,
            ),
            _buildStarterPlan(context),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tellacoin balance:".toUpperCase(),
                      style: CustomTextStyles.bodySmallWhiteA700,
                    ),
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgSettings,
                          height: 26.adaptSize,
                          width: 26.adaptSize,
                          margin: EdgeInsets.only(
                            top: 8.v,
                            bottom: 7.v,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6.h),
                          child: Text(
                            "200",
                            style: CustomTextStyles.headlineLargeWhiteA700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCommunityLeader(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 24.v,
            );
          },
          itemCount: 3,
          itemBuilder: (context, index) {
            return CommunityleaderItemWidget();
          },
        ),
      ),
    );
  }
}
