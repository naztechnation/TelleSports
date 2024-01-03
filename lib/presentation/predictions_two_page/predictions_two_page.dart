import '../predictions_two_page/widgets/userprofile2_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';

class PredictionsTwoPage extends StatelessWidget {
  const PredictionsTwoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(height: 24.v),
                    _buildPredictionsDay(context),
                    SizedBox(height: 24.v),
                    _buildUserProfile(context)
                  ]),
                ))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 93.v,
        centerTitle: true,
        title: AppbarSubtitleOne(
            text: "Predictions",
            margin: EdgeInsets.only(top: 59.v, bottom: 9.v)),
        styleType: Style.bgOutline_3);
  }

  Widget _buildPredictionsDay(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 11.v),
        decoration: AppDecoration.outlineGray100
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder24),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomImageView(
              imagePath: ImageConstant.imgArrowLeft,
              height: 24.adaptSize,
              width: 24.adaptSize,
              onTap: () {
                onTapImgArrowLeft(context);
              }),
          Padding(
              padding: EdgeInsets.only(top: 3.v),
              child: Text("Today",
                  style: CustomTextStyles.titleMediumOnPrimaryBold)),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRightOnprimary,
              height: 24.adaptSize,
              width: 24.adaptSize)
        ]));
  }

  Widget _buildUserProfile(BuildContext context) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0.v),
              child: SizedBox(
                  width: 64.h,
                  child: Divider(
                      height: 1.v, thickness: 1.v, color: appTheme.teal200)));
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return Userprofile2ItemWidget();
        });
  }

  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
