import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/presentation/gift_tellacoins_screen/gift_tellacoins_screen.dart';
import 'package:tellesports/presentation/user_info_page/user_info_page.dart';
import 'package:tellesports/widgets/app_bar/appbar_leading_image.dart';
import 'package:tellesports/widgets/app_bar/custom_app_bar.dart';
import 'package:tellesports/widgets/custom_elevated_button.dart';

import '../../model/chat_model/group.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../community_screens/community_one_page/empty_community_page.dart';
import '../community_screens/provider/auth_provider.dart' as pro;
import 'package:provider/provider.dart' as provider;

import '../community_screens/widgets/community_item_widget.dart';

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

  bool _dataAdded = false;

  String currentUserId = "";

  getUserId() async {
    currentUserId = await StorageHandler.getUserId() ?? '';
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final groupInfo =
        provider.Provider.of<pro.AuthProviders>(context, listen: true);

    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: StreamBuilder<List<Group>>(
                stream: groupInfo.getAllChatGroups(widget.memberId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No groups found');
                  }

                  final filteredGroups = filterGroups(
                      snapshot.data!, currentUserId, widget.memberId);
                  final filteredCreatedGroups = filterGroupsByFirstMember(
                      snapshot.data!, widget.memberId);

                  return SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(height: 15.v),
                      _buildFrameRow(context),
                      SizedBox(height: 24.v),
                      CustomElevatedButton(
                          text: "Gift Tellacoins",
                          buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3C91E5)),
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
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0x66F3F2F3),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0F000000),
                              offset: Offset(0, 0),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(8, 12, 8.8, 19.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 15.5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Communities created',
                                    style: GoogleFonts.getFont(
                                      'DM Sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Color(0xFF342E37),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Expanded(
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: filteredCreatedGroups.length,
                                        itemBuilder: (context, index) {
                                          final groupData =
                                              filteredCreatedGroups[index];

                                          return CommunityPageComponent(
                                            onTapCommunityPageComponent:
                                                () async {},
                                            groupName: groupData.name,
                                            lastMessage: (groupData
                                                        .membersUid.length >
                                                    1)
                                                ? '${groupData.membersUid.length} Members'
                                                : '${groupData.membersUid.length} Member',
                                            groupPic: groupData.groupPic,
                                            isPaid: groupData.communityType
                                                .toString(),
                                          );
                                        }),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24.v),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0x66F3F2F3),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0F000000),
                              offset: Offset(0, 0),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(8, 12, 8.8, 19.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 15.5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Communities in common',
                                    style: GoogleFonts.getFont(
                                      'DM Sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Color(0xFF342E37),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Expanded(
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: filteredGroups.length,
                                        itemBuilder: (context, index) {
                                          final groupData =
                                              filteredGroups[index];

                                          return CommunityPageComponent(
                                            onTapCommunityPageComponent:
                                                () async {},
                                            groupName: groupData.name,
                                            lastMessage: (groupData
                                                        .membersUid.length >
                                                    1)
                                                ? '${groupData.membersUid.length} Members'
                                                : '${groupData.membersUid.length} Member',
                                            groupPic: groupData.groupPic,
                                            isPaid: groupData.communityType
                                                .toString(),
                                          );
                                        }),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      UserInfoPage(
                        isGroupAdmin: widget.isGroupAdmin,
                        memberId: widget.memberId,
                        memberName: widget.name,
                      )
                    ]),
                  );
                })));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 70.v,
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 0.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Info",
        margin: EdgeInsets.only(
          top: 0.v,
          bottom: 9.v,
        ),
      ),
      styleType: Style.bgOutline,
    );
  }

  _buildFrameRow(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 20.h, right: 0.h),
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
                                child: Text(widget.bio,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14)))
                          ])))
            ])));
  }

  List<Group> filterGroups(
      List<Group> groups, String currentUserId, String selectedUserId) {
    return groups.where((group) {
      final memberIds =
          group.membersUid.map((member) => member.userId).toList();
      return memberIds.contains(currentUserId) &&
          memberIds.contains(selectedUserId);
    }).toList();
  }

  List<Group> filterGroupsByFirstMember(
      List<Group> groups, String currentUserId) {
    return groups.where((group) {
      if (group.membersUid.isNotEmpty) {
        return group.membersUid.first.userId == currentUserId;
      }
      return false;
    }).toList();
  }

  onTapGiftTellacoins(BuildContext context, String username) {
    AppNavigator.pushAndStackPage(context,
        page: GiftTellacoinsScreen(desUserId: username));
  }
}
