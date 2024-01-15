import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';

import '../../widgets/custom_outlined_button.dart';
import '../chats_settings_screen/chats_settings_screen.dart';
import '../manage_account/create_new_password_screen/create_new_password_screen.dart';
import '../notification_settings_screen/notification_settings_screen.dart';
import 'edit_profile_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 24.v),
                child: Column(children: [
                  _buildAvatarFrame(context),
                  SizedBox(height: 24.v),
                  _buildSettingsFrame(context),
                  SizedBox(height: 24.v),
                  _buildShareFrame(context,
                      text: "Contact support",
                      image: ImageConstant.imgHelpCenter,
                      onTap: () {}),
                  SizedBox(height: 24.v),
                  _buildShareFrame(context,
                      text: "Change Password",
                      image: ImageConstant.imgHelpCenter, onTap: () {
                    AppNavigator.pushAndStackPage(context,
                        page: CreateNewPasswordScreen());
                  }),
                  SizedBox(height: 24.v),
                  _buildShareFrame(context,
                      text: "Share Tellasport",
                      image: ImageConstant.imgShareGray700,
                      onTap: () {}),
                  SizedBox(height: 24.v),
                  CustomElevatedButton(
                      text: "Log out",
                      buttonStyle: CustomButtonStyles.fillRedTL8,
                      onPressed: () {
                        onTapLogOut(context);
                      }),
                  SizedBox(height: 24.v),
                  CustomOutlinedButton(
                      text: "Delete your account",
                      buttonTextStyle: TextStyle(color: Colors.red),
                      buttonStyle: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {}),
                ]))));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 93.v,
        centerTitle: true,
        title: AppbarSubtitleOne(
            text: "Settings", margin: EdgeInsets.only(top: 61.v, bottom: 7.v)),
        styleType: Style.bgOutline_4);
  }

  Widget _buildAvatarFrame(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapAvatarFrame(context);
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomImageView(
              imagePath: ImageConstant.imgAvatar64x64,
              height: 64.adaptSize,
              width: 64.adaptSize,
              radius: BorderRadius.circular(32.h)),
          Padding(
              padding: EdgeInsets.only(left: 10.h, top: 11.v, bottom: 11.v),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Joshua11",
                        style: CustomTextStyles.titleMediumOnPrimaryBold18),
                    SizedBox(height: 3.v),
                    Text("joshualll@gmail.com",
                        style: theme.textTheme.labelMedium)
                  ])),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRightGray700,
              height: 24.adaptSize,
              width: 24.adaptSize,
              margin: EdgeInsets.symmetric(vertical: 20.v))
        ]));
  }

  Widget _buildSettingsFrame(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 16.v),
        decoration: AppDecoration.outlineBlack9001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _buildChatSettingsFrame(context, text: "Notifications settings",
              onPressed: () {
            AppNavigator.pushAndStackPage(context,
                page: NotificationSettingsScreen());
          }),
          SizedBox(height: 12.v),
          Divider(color: appTheme.gray50001),
          SizedBox(height: 11.v),
          _buildChatSettingsFrame(context, text: "Chat settings",
              onPressed: () {
            AppNavigator.pushAndStackPage(context, page: ChatsSettingsScreen());
          })
        ]));
  }

  Widget _buildChatSettingsFrame(
    BuildContext context, {
    required String text,
    required Function onPressed,
  }) {
    return GestureDetector(
      onTap: (() {
        onPressed();
      }),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
            padding: EdgeInsets.only(top: 4.v),
            child: Text(text,
                style: theme.textTheme.titleSmall!
                    .copyWith(color: theme.colorScheme.onPrimary))),
        CustomImageView(
            imagePath: ImageConstant.imgArrowRightGray700,
            height: 24.adaptSize,
            width: 24.adaptSize)
      ]),
    );
  }

  Widget _buildShareFrame(
    BuildContext context, {
    required String text,
    required String image,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.v),
          decoration: AppDecoration.outlineBlack9001
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.only(top: 4.v, bottom: 1.v),
                child: Text(text,
                    style: theme.textTheme.titleSmall!
                        .copyWith(color: theme.colorScheme.onPrimary))),
            CustomImageView(
                imagePath: image, height: 24.adaptSize, width: 24.adaptSize)
          ])),
    );
  }

  onTapAvatarFrame(BuildContext context) {
    AppNavigator.pushAndStackPage(context, page: EditProfileScreen());
  }

  onTapLogOut(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.splashScreenOnboardingScreen);
  }
}
