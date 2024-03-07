

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';
import 'package:tellesports/widgets/custom_outlined_button.dart';

 
import '../../../handlers/secure_handler.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../widgets/modals.dart';
import '../provider/auth_provider.dart' as pro;
import 'all_users_page.dart';


import 'widgets/userprofile_item_widget.dart';

// ignore_for_file: must_be_immutable
class CommunityInfoScreen extends StatefulWidget {
  final String profilePic;
  final String name;
  CommunityInfoScreen({Key? key, required this.profilePic, required this.name}) : super(key: key);

  @override
  State<CommunityInfoScreen> createState() => _CommunityInfoScreenState();
}

class _CommunityInfoScreenState extends State<CommunityInfoScreen> {
  TextEditingController vectorController = TextEditingController();

   String userId = '';
  getUserId()async{

userId = await StorageHandler.getUserId() ?? '';
setState(() {
  
});
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final groupInfo = Provider.of<pro.AuthProviders>(context, listen: true);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SingleChildScrollView(
                padding: EdgeInsets.only(top: 15.v),
                child: Container(
                    margin: EdgeInsets.only(bottom: 5.v),
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomImageView(
                                    imagePath: widget.profilePic,
                                    placeHolder: ImageConstant.imgAvatar,
                                    height: 64.adaptSize,
                                    width: 64.adaptSize,
                                    radius: BorderRadius.circular(32.h)),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.h, bottom: 18.v),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(widget.name,
                                              style: TextStyle(
                                                  color: appTheme.gray900,
                                                  fontSize: 18.fSize,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight:
                                                      FontWeight.w700)),
                                          SizedBox(height: 2.v),
                                          Text("${groupInfo.groupNumber} member(s)",
                                              style: TextStyle(
                                                  color: theme.colorScheme
                                                      .onPrimaryContainer,
                                                  fontSize: 14.fSize,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight:
                                                      FontWeight.w500))
                                        ]))
                              ]),
                              const SizedBox(height: 12,),
                          if(groupInfo.groupMembers[0].uid ==  userId)   Column(children: [
              
            Card(
              elevation: 0.3,
              child: ListTile(
                leading: const Icon(Icons.notifications, color: Colors.blue,),
                title: const Text('Mute Group'),
                trailing: CupertinoSwitch(
                    value: groupInfo.isGroupLocked,
                    onChanged: (newValue) => setState(() {
                      groupInfo.updateGroupLockStatus(groupInfo.groupId, newValue);
                    } )),
              ),
            ),
             ]),
                          SizedBox(height: 24.v),
                          _buildCommunityDescription(context, groupInfo.groupDescription),
                          SizedBox(height: 24.v),
                          _buildShareCommunity(context, groupInfo.groupLink),
                          SizedBox(height: 24.v),
                          _buildMedia(context),
                          SizedBox(height: 24.v),
                          Card(
                            elevation: 0.4,
                            child: 
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 Text("Chat Notifications",
                                              style: TextStyle(
                                                  
                                                  fontSize: 14.fSize,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight:
                                                      FontWeight.w500)),

                                                      Switch.adaptive(
                                                        activeColor: Colors.blue,
                                                        inactiveThumbColor: Colors.black12,
                                                        inactiveTrackColor: Colors.grey,
                                                        value: true, onChanged: ((value) {
                                                        
                                                      }))
                              ],),
                            )
                          ,),
                          
                          SizedBox(height: 24.v),
                          _buildUserProfile(context, groupInfo.groupNumber, groupInfo.groupMembers.length,groupInfo),
                          SizedBox(height: 24.v),
                          CustomElevatedButton(
                              text: "Leave community",
                              buttonStyle: CustomButtonStyles.fillRed,
                              onPressed: () {
                                 if(groupInfo.groupMembers[0].uid ==  userId) {
              Modals.showToast('You are an admin and can\'t leave the community');
              }else{
              groupInfo.removeCurrentUserFromMembers(groupInfo.groupId, userId, context);

              }
                              }),
                          SizedBox(height: 16.v),
                          CustomOutlinedButton(text: "Report community")
                        ])))));
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

  Widget _buildCommunityDescription(BuildContext context,  String desc) {
    return Card(
          elevation: 0.4,

      child: Container(
          width: 350.h,
          padding: EdgeInsets.all(8.h),
            // decoration: AppDecoration.outlineBlackF
            //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.v),
                Text("Community Description",
                    style: TextStyle(
                        fontSize: 16.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 6.v),
                Container(
                    width: 312.h,
                    margin: EdgeInsets.only(right: 21.h),
                    child: Text(
                        desc,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: appTheme.gray900,
                            fontSize: 14.fSize,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w500)))
              ])),
    );
  }

  Widget _buildShareCommunity(BuildContext context, String groupLink) {
    return GestureDetector(
        onTap: () {
          onTapShareCommunity(context);
        },
        child: Card(
          elevation: 0.4,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.v),
              
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Share Community",
                        style: TextStyle(
                            fontSize: 16.fSize,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 6.v),
                    Row(children: [
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(top: 3.v, bottom: 1.v),
                            child: Text("tsportcommunity.com/$groupLink",
                                style: TextStyle(
                                    color: appTheme.blue300,
                                    fontSize: 14.fSize,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500))),
                      ),
                      CustomImageView(
                          imagePath: ImageConstant.imgShare,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          margin: EdgeInsets.only(left: 48.h))
                    ])
                  ])),
        ));
  }

  Widget _buildMedia(BuildContext context) {
    return Card(
          elevation: 0.4,

      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 11.v),
          // decoration: AppDecoration.outlineBlackF
          //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Media",
                    style: TextStyle(
                        fontSize: 16.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 8.v),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgRectangle237,
                      height: 60.adaptSize,
                      width: 60.adaptSize),
                  CustomImageView(
                      imagePath: ImageConstant.imgRectangle237,
                      height: 60.adaptSize,
                      width: 60.adaptSize),
                  CustomImageView(
                      imagePath: ImageConstant.imgRectangle237,
                      height: 60.adaptSize,
                      width: 60.adaptSize),
                  CustomImageView(
                      imagePath: ImageConstant.imgRectangle237,
                      height: 60.adaptSize,
                      width: 60.adaptSize),
                  CustomImageView(
                      imagePath: ImageConstant.imgRectangle237,
                      height: 60.v,
                      width: 30.h),
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowRight,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      margin: EdgeInsets.symmetric(vertical: 18.v))
                ])
              ])),
    );
  }

  Widget _buildUserProfile(BuildContext context, String groupNumber, int memberLength, var members) {
    return Card(
      elevation: 0.4,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 11.v),
          // decoration: AppDecoration.outlineBlackF
          //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$groupNumber Member(s)",
                    style: TextStyle(
                        fontSize: 16.fSize,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 8.v),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8.v);
                    },
                                  itemCount: memberLength,

                    itemBuilder: (context, index) {
                      return UserprofileItemWidget(name: members.groupMembers[index].name, bio: 'My Bio', index: index, image: members.groupMembers[index].profilePic,);
                    }),
                SizedBox(height: 12.v),

                    GestureDetector(
                      onTap: () {
                        AppNavigator.pushAndStackPage(context, page: AllUsersPage());
                      },
                      child: Text("see all >",
                      style: TextStyle(
                          fontSize: 16.fSize,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w500)),
                    ),
              ])),
    );
  }

  /// Navigates to the shareScreen when the action is triggered.
  onTapShareCommunity(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.shareScreen);
  }

  /// Navigates to the leaveScreen when the action is triggered.
  onTapLeaveCommunity(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.leaveScreen);
  }
}
