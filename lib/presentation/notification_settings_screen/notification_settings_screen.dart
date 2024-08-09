import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/core/constants/enums.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/loading_page.dart';

import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/custom_switch.dart';
import '../../widgets/modals.dart';
import '../community_screens/provider/auth_provider.dart';

class NotificationSettingsScreen extends StatefulWidget {
  NotificationSettingsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool isCommunityChat = true;
  bool isPredictionSubed = true;
  String communityChat = '1';
  String predictionSubed = '1';
  String userId = '1';

  bool isSelectedSwitch1 = false;

  bool isSelectedSwitch2 = false;

  bool isSelectedSwitch3 = false;

  bool isLoading = false;

  final _firebaseMessaging = FirebaseMessaging.instance;

  getCommunityChatSettings() async {
    communityChat = await StorageHandler.getCommunityChatSettings() ?? '1';
    predictionSubed = await StorageHandler.getIspredictionSubbed() ?? '1';
    userId = await StorageHandler.getUserId() ?? '';

    setState(() {
      isCommunityChat = (communityChat == '1') ? true : false;
      isPredictionSubed = (predictionSubed == '1') ? true : false;
    });
  }

  @override
  void initState() {
    getCommunityChatSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final groupInfo = Provider.of<AuthProviders>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 24.v,
          ),
          child: (isLoading)
              ? LoadingPage()
              : Column(
                  children: [
                    _buildCommunityChatFrame(context, ((value) async {
                      setState(() {
                        isLoading = true;
                      });
                      await groupInfo.updateRecieveNotificationForUser(
                          userId, value);
                      if (value) {
                        StorageHandler.saveCommunityChatSettings('1');
                        isCommunityChat = true;
                      } else {
                        StorageHandler.saveCommunityChatSettings('0');
                        isCommunityChat = false;
                      }

                      setState(() {
                        isLoading = false;
                      });

                      Modals.showToast('updated successfully',
                          messageType: MessageType.success);
                    })),
                    SizedBox(height: 12.v),
                    _buildPredictionFrame(context, ((value) async {
                      setState(() {
                        isLoading = true;
                      });

                      if (value) {
                        await _firebaseMessaging.subscribeToTopic('predict');

                        StorageHandler.saveIspredictionSubbed('1');
                        isPredictionSubed = true;
                      } else {
                        await _firebaseMessaging
                            .unsubscribeFromTopic('predict');

                        StorageHandler.saveIspredictionSubbed('0');
                        isPredictionSubed = false;
                      }

                      setState(() {
                        isLoading = false;
                      });

                      Modals.showToast('updated successfully',
                          messageType: MessageType.success);
                    })),
                    SizedBox(height: 12.v),

                    _buildDirectMessageFrame(context),
                    SizedBox(height: 12.v),

                    _buildPromotionsFrame(context),
                    // SizedBox(height: 30.v),
                    // CustomElevatedButton(
                    //   text: "Save changes",
                    // ),
                    // SizedBox(height: 5.v),
                  ],
                ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 75.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          bottom: 10.v,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitleOne(
        text: "Notifications",
        margin: EdgeInsets.only(
          bottom: 8.v,
        ),
      ),
    );
  }

  Widget _buildCommunityChatFrame(
      BuildContext context, Function(bool value) onCheck) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 12.v,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0x66F3F2F3),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(0, 0),
            blurRadius: 1,
          ),
        ],
      ),
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
          Transform.scale(
            scale: 0.8,
            child: CustomSwitch(value: isCommunityChat, onChange: onCheck),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectMessageFrame(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 12.v,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0x66F3F2F3),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(0, 0),
            blurRadius: 1,
          ),
        ],
      ),
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
          Transform.scale(
            scale: 0.8,
            child: CustomSwitch(
              value: isSelectedSwitch1,
              onChange: (value) {
                Modals.showToast('Feature coming soon',
                    messageType: MessageType.success);

                // setState(() {
                //   isSelectedSwitch1 = value;
                // });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionFrame(
      BuildContext context, Function(bool value) onCheck) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 12.v,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0x66F3F2F3),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(0, 0),
            blurRadius: 1,
          ),
        ],
      ),
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
          Transform.scale(
            scale: 0.8,
            child: CustomSwitch(
              value: isPredictionSubed,
              onChange: onCheck,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionsFrame(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 12.v,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0x66F3F2F3),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(0, 0),
            blurRadius: 1,
          ),
        ],
      ),
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
          Transform.scale(
            scale: 0.8,
            child: CustomSwitch(
              value: isSelectedSwitch3,
              onChange: (value) {
                Modals.showToast('Feature coming soon',
                    messageType: MessageType.success);

                // setState(() {
                //   isSelectedSwitch3 = value;
                // });
              },
            ),
          ),
        ],
      ),
    );
  }
}
