import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/presentation/gift_tellacoins_screen/gift_tellacoins_screen.dart';
import 'package:tellesports/presentation/user_info_page/user_info_page.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';

import '../../utils/navigator/page_navigator.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../community_screens/provider/auth_provider.dart' as pro;
import 'package:provider/provider.dart' as provider;

class IndividualUserInfo extends StatefulWidget {
  final String name;
  final String image;
  final String bio;
  final String username;
  final String memberId;
  final bool isGroupAdmin;

  const IndividualUserInfo({
    Key? key,
    required this.name,
    required this.image,
    required this.bio,
    required this.username,
    required this.isGroupAdmin,
    required this.memberId,
  }) : super(key: key);

  @override
  IndividualUserInfoState createState() => IndividualUserInfoState();
}

// ignore_for_file: must_be_immutable
class IndividualUserInfoState extends State<IndividualUserInfo>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final groupInfo =
        provider.Provider.of<pro.AuthProviders>(context, listen: true);

    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  SizedBox(height: 15.v),
                  _buildFrameRow(context),
                  SizedBox(height: 24.v),
                  CustomElevatedButton(
                      text: "Gift Tellacoins",
                      margin: EdgeInsets.symmetric(horizontal: 20.h),
                      leftIcon: Container(
                          margin: EdgeInsets.only(right: 10.h),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgCardgiftcard,
                              height: 24.adaptSize,
                              width: 24.adaptSize)),
                      onPressed: () {
                        onTapGiftTellacoins(context, widget.username);
                      }),
                  SizedBox(height: 24.v),
                  _buildFrameColumn(
                    context: context,
                    groupName: groupInfo.groupName,
                    groupPics: groupInfo.groupPics,
                    groupNumber: groupInfo.groupNumber,
                  ),
                  SizedBox(height: 24.v),
                  // _buildFrameColumn1(),
                  _buildTabBarView(context)
                ]))));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 86.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 50.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Info",
        margin: EdgeInsets.only(
          top: 49.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
    );
  }

  Widget _buildFrameRow(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 20.h, right: 45.h),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (widget.image == "" || widget.image == "null") ...[
                CustomImageView(
                    imagePath: ImageConstant.imgAvatar,
                    placeHolder: ImageConstant.imgAvatar64x64,
                    height: 64.adaptSize,
                    width: 64.adaptSize,
                    radius: BorderRadius.circular(32.h)),
              ] else ...[
                CustomImageView(
                    imagePath: widget.image,
                    placeHolder: ImageConstant.imgAvatar64x64,
                    height: 64.adaptSize,
                    width: 64.adaptSize,
                    radius: BorderRadius.circular(32.h)),
              ],
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.h, bottom: 11.v),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name,
                                style: CustomTextStyles
                                    .titleMediumOnPrimaryBold18),
                            SizedBox(height: 3.v),
                            SizedBox(
                                width: 251.h,
                                child: Text(widget.bio,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14)))
                          ])))
            ])));
  }

  Widget _buildFrameColumn(
      {required BuildContext context,
      required String groupName,
      required String groupPics,
      required String groupNumber}) {
    return Container(
        width: 350.h,
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 13.v),
        decoration: AppDecoration.outlineBlack9001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  (widget.isGroupAdmin)
                      ? "Community created"
                      : "Community Info",
                  style: CustomTextStyles.titleMediumBluegray900),
              SizedBox(height: 14.v),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomImageView(
                    imagePath: groupPics,
                    placeHolder: ImageConstant.imgAvatar64x64,
                    height: 60.adaptSize,
                    width: 60.adaptSize,
                    radius: BorderRadius.circular(30.h)),
                Padding(
                    padding:
                        EdgeInsets.only(left: 10.h, top: 2.v, bottom: 15.v),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(groupName,
                              style: CustomTextStyles.titleMediumBlack900_1),
                          SizedBox(height: 2.v),
                          Text("$groupNumber members",
                              style: CustomTextStyles.titleSmallBluegray400)
                        ]))
              ]),
              SizedBox(height: 6.v)
            ]));
  }

  Widget _buildFrameColumn1() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 11.v),
        decoration: AppDecoration.outlineBlack9001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Media", style: CustomTextStyles.titleMediumBluegray900),
              SizedBox(height: 8.v),
              Container(
                  height: 60.v,
                  width: 334.h,
                  child: TabBar(
                      controller: tabviewController,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle237,
                                height: 60.adaptSize,
                                width: 60.adaptSize)),
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle237,
                                height: 60.adaptSize,
                                width: 60.adaptSize)),
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle237,
                                height: 60.adaptSize,
                                width: 60.adaptSize)),
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle237,
                                height: 60.adaptSize,
                                width: 60.adaptSize)),
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgRectangle237,
                                height: 60.v,
                                width: 30.h)),
                        Tab(
                            child: CustomImageView(
                                imagePath: ImageConstant.imgArrowRightOnprimary,
                                height: 24.adaptSize,
                                width: 24.adaptSize))
                      ]))
            ]));
  }

  Widget _buildTabBarView(BuildContext context) {
    return Expanded(
        child: SizedBox(
            child: TabBarView(controller: tabviewController, children: [
      UserInfoPage(
        isGroupAdmin: widget.isGroupAdmin,
        memberId: widget.memberId,
      ),
    ])));
  }

  onTapGiftTellacoins(BuildContext context, String username) {
    AppNavigator.pushAndStackPage(context,
        page: GiftTellacoinsScreen(desUserId: username));
  }
}
