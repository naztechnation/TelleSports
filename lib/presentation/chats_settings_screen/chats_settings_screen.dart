import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/appbar_title.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_switch.dart';

import '../../widgets/app_bar/appbar_subtitle_one.dart';

class ChatsSettingsScreen extends StatelessWidget {
  ChatsSettingsScreen({Key? key})
      : super(
          key: key,
        );

  bool isSelectedSwitch = false;

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
              _buildFrame(context),
              SizedBox(height: 24.v),
              _buildSecondaryButton(context),
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
        text: "Chats",
        margin: EdgeInsets.only(
          top: 60.v,
          bottom: 8.v,
        ),
      ),
      styleType: Style.bgOutline_4,
    );
  }

  Widget _buildFrame(BuildContext context) {
    return Container(
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
              "Allow direct messaging",
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
              isSelectedSwitch = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 7.v,
      ),
      // decoration: AppDecoration.outlinePrimary.copyWith(
      //   borderRadius: BorderRadiusStyle.roundedBorder8,
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.v),
            child: Text(
              "Clear all chats",
              style: TextStyle(
                color: appTheme.gray900,
                fontSize: 16.fSize,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(Icons.delete_outlined, color: Colors.red,)
        ],
      ),
    );
  }
}
