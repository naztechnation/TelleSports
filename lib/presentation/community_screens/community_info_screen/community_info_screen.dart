import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
 
import '../../../utils/navigator/page_navigator.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
import '../community_chat_screen/community_chat_screen.dart';

class CommunityInfoScreen extends StatelessWidget {
  final String groupImage;
  final String groupName;
  final String groupNumber;
  final String groupDescription;
  const CommunityInfoScreen({Key? key, required this.groupImage, required this.groupName, required this.groupNumber, required this.groupDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
                child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomImageView(
                                imagePath: groupImage,
                                placeHolder: ImageConstant.imgAvatar1,
                                height: 64.adaptSize,
                                width: 64.adaptSize,
                                radius: BorderRadius.circular(32.h)),
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 10.h, bottom: 18.v),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(groupName,
                                          style: CustomTextStyles
                                              .titleMediumOnPrimaryBold18),
                                      SizedBox(height: 2.v),
                                      Text('${groupNumber } Member(s)',
                                          style: CustomTextStyles
                                              .titleSmallBluegray900)
                                    ]))
                          ])),
                  SizedBox(height: 24.v),
                  _buildCommunityDescription(context, groupDescription),
                  SizedBox(height: 24.v),
                  CustomElevatedButton(
                      text: "Join community",
                      onPressed: () {
                        onTapJoinCommunity(context);
                      }),
                  SizedBox(height: 16.v),
                  // CustomOutlinedButton(text: "Report community"),
                  // SizedBox(height: 5.v)
                ]))));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 86.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        onTap: (){
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
        text: "Community Info",
        
        margin: EdgeInsets.only(
          top: 49.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
      
    );
  }

  Widget _buildCommunityDescription(BuildContext context, String desc) {
    return Container(
        width: 350.h,
        padding: EdgeInsets.all(8.h),
        decoration: AppDecoration.outlineBlack9001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 4.v),
              Text("Community Description",
                  style: CustomTextStyles.titleMediumBluegray900),
              SizedBox(height: 6.v),
              Container(
                  width: 312.h,
                  margin: EdgeInsets.only(right: 21.h),
                  child: Text(
                    desc,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 16)))
            ]));
  }

  onTapJoinCommunity(BuildContext context) {
    // AppNavigator.pushAndStackPage(context, page: CommunityChatScreen(name: '',));
  }
}
