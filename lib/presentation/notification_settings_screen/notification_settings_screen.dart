import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';

import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/custom_switch.dart';

class NotificationSettingsScreen extends StatefulWidget {
  NotificationSettingsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool isSelectedSwitch = false;

  bool isSelectedSwitch1 = false;

  bool isSelectedSwitch2 = false;

  bool isSelectedSwitch3 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 24.v,
          ),
          child: Column(
            children: [
              _buildCommunityChatFrame(context),
              SizedBox(height: 16.v),
              _buildDirectMessageFrame(context),
              SizedBox(height: 16.v),
              _buildPredictionFrame(context),
              SizedBox(height: 16.v),
              _buildPromotionsFrame(context),
              SizedBox(height: 30.v),
              CustomElevatedButton(
                text: "Save changes",
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 93.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 59.v,
          bottom: 10.v,
        ),
        onTap: (){
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitleOne(
        text: "Notifications",
        margin: EdgeInsets.only(
          top: 60.v,
          bottom: 8.v,
        ),
      ),
      styleType: Style.bgOutline_4,
    );
  }

  Widget _buildCommunityChatFrame(BuildContext context) {
    return Card(
      elevation: 0.4,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8.h,
          vertical: 12.v,
        ),
        // decoration: AppDecoration.outlineBlackF.copyWith(
        //   borderRadius: BorderRadiusStyle.roundedBorder8,
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 3.v,
                bottom: 1.v,
              ),
              child: Text(
                "Community chat",
                style: TextStyle(
                  color: appTheme.gray900,
                  fontSize: 14.fSize,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CustomSwitch(
              value: isSelectedSwitch,
              onChange: (value) {
                setState(() {
                  isSelectedSwitch = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectMessageFrame(BuildContext context) {
    return Card(
      elevation: 0.4,

      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8.h,
          vertical: 12.v,
        ),
        // decoration: AppDecoration.outlineBlackF.copyWith(
        //   borderRadius: BorderRadiusStyle.roundedBorder8,
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 4.v),
              child: Text(
                "Direct Message ",
                style: TextStyle(
                  color: appTheme.gray900,
                  fontSize: 14.fSize,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CustomSwitch(
              value: isSelectedSwitch1,
              onChange: (value) {
                setState(() {
                  isSelectedSwitch1 = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionFrame(BuildContext context) {
    return Card(
      elevation: 0.4,

      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8.h,
          vertical: 12.v,
        ),
        // decoration: AppDecoration.outlineBlackF.copyWith(
        //   borderRadius: BorderRadiusStyle.roundedBorder8,
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 3.v,
                bottom: 1.v,
              ),
              child: Text(
                "Prediction of the day",
                style: TextStyle(
                  color: appTheme.gray900,
                  fontSize: 14.fSize,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CustomSwitch(
              value: isSelectedSwitch2,
              onChange: (value) {
                setState(() {
                isSelectedSwitch2 = value;
                  
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionsFrame(BuildContext context) {
    return Card(
      elevation: 0.4,

      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8.h,
          vertical: 12.v,
        ),
        // decoration: AppDecoration.outlineBlackF.copyWith(
        //   borderRadius: BorderRadiusStyle.roundedBorder8,
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.v),
              child: Text(
                "Promotions",
                style: TextStyle(
                  color: appTheme.gray900,
                  fontSize: 14.fSize,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CustomSwitch(
              value: isSelectedSwitch3,
              onChange: (value) {
                setState(() {
                isSelectedSwitch3 = value;
                  
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
