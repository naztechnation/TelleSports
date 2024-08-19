import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/loading_page.dart';

import '../../../handlers/secure_handler.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/modals.dart';

import 'package:provider/provider.dart' as provider;

import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import '../../model/chat_model/group.dart';
import 'chat/screens/mobile_chat_screen.dart';
import 'join_community_screen/join_community_screen.dart';
import 'community_one_page/empty_community_page.dart';
import 'widgets/community_item_widget.dart';
import 'widgets/create_community.dart';
import 'provider/auth_provider.dart' as pro;

class AllGroupsListPage extends ConsumerStatefulWidget {
  const AllGroupsListPage({Key? key}) : super(key: key);

  @override
  AllGroupsListPageState createState() => AllGroupsListPageState();
}

// ignore_for_file: must_be_immutable
class AllGroupsListPageState extends ConsumerState<AllGroupsListPage>
    with AutomaticKeepAliveClientMixin<AllGroupsListPage> {
  TextEditingController _searchController = TextEditingController();
  final ValueNotifier<String> _searchQuery = ValueNotifier<String>('');

  List<MemberData> userItem = [];

  String userId = '';

  String plan = '';
  String email = '';
  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
    plan = await StorageHandler.getUserPlan() ?? '';
    email = await StorageHandler.getUserEmail() ?? '';
    Future.delayed(Duration(seconds: 1), (() {
      setState(() {});
    }));
  }

  bool isLoading = true;

  bool _dataAdded = false;

  @override
  void initState() {
    getUserId();
    _searchController.addListener(() {
      _searchQuery.value = _searchController.text.trim().toLowerCase();
    });
    Future.delayed(Duration(seconds: 2), (() {
      setState(() {
        isLoading = false;
      });
    }));
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _searchController.dispose();
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
     

    return SafeArea(
        child: (isLoading)
            ? LoadingPage()
            : Scaffold(
                body: Scaffold(
                    resizeToAvoidBottomInset: false,
                    
                    body: SizedBox(
                        width: mediaQueryData.size.width,
                        child: SingleChildScrollView(
                            child: Column(
                              children: [
                                 SizedBox(height: 10.v),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 12),
                          child: CustomTextFormField(
                              controller: _searchController,
                              hintText: "Search for communities",
                              hintStyle: CustomTextStyles.titleSmallGray400,
                              textInputAction: TextInputAction.done,
                              prefix: Padding(
                                padding: const EdgeInsets.all(10),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgSearchGray400,
                                  color: Colors.grey,
                                ),
                              ),
                              prefixConstraints:
                                  BoxConstraints(maxHeight: 45.v),
                              contentPadding: EdgeInsets.only(
                                  top: 1.v, right: 30.h, bottom: 7.v),
                              borderDecoration:
                                  TextFormFieldStyleHelper.fillGray,
                              filled: true,
                              fillColor: appTheme.gray100),
                        ),
                                ValueListenableBuilder<String>(
                            valueListenable: _searchQuery,
                            builder: (context, query, child) {
                                    return StreamBuilder<List<Group>>(
                                        stream: provider.Provider.of<pro.AuthProviders>(context, listen: false).getAllChatGroups(userId),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const LoadingPage();
                                          } else if (snapshot.data?.isEmpty ?? false) {
                                            return EmptyCommunityPage();
                                          }
                                    
                                          if (!_dataAdded && snapshot.hasData) {
                                            provider.Provider.of<pro.AuthProviders>(context, listen: false).clearSearchList1();
                                    
                                            provider.Provider.of<pro.AuthProviders>(context, listen: false).updateSearchList1(
                                              snapshot.data!,
                                            );
                                    
                                            _dataAdded = true;
                                          }
                                          final List<Group> filteredDocuments =
                                        snapshot.data!
                                            .where((doc) {
                                      final String groupName =
                                          doc.name.toString().toLowerCase();
                                      return groupName.contains(query);
                                    }).toList();

                                    if (filteredDocuments.isEmpty) {
                                      return EmptyCommunityPage();
                                    }
                                    
                                          return Column(children: [
                                             
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.h),
                                                child: Column(children: [
                                                  
                                                  Align(
                                                      alignment: Alignment.center,
                                                      child: ListView.separated(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          shrinkWrap: true,
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return SizedBox(
                                                                height: 1.v);
                                                          },
                                                          itemCount: filteredDocuments.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            Group? groupData =
                                                                filteredDocuments[index];
                                    
                                                            return CommunityPageComponent(
                                                              onTapCommunityPageComponent:
                                                                  () async {
                                                                provider.Provider.of<pro.AuthProviders>(context, listen: false)
                                                                    .requestedUsers(
                                                                        groupData
                                                                            .requestsMembers);
                                                                provider.Provider.of<pro.AuthProviders>(context, listen: false)
                                                                    .blockedUsers(groupData
                                                                        .blockedMembers);
                                    
                                                                List<MemberData>
                                                                    userItem =
                                                                    removeDuplicateUsers(
                                                                        groupData
                                                                            .membersUid);
                                    
                                                                MemberData? currentUser;
                                    
                                                                if (userItem.any(
                                                                    (user) =>
                                                                        user.userId ==
                                                                        userId)) {
                                                                  currentUser = userItem
                                                                      .firstWhere((user) =>
                                                                          user.userId ==
                                                                          userId);
                                    
                                                                  if (userItem.first
                                                                              .userId ==
                                                                          userId ||
                                                                      groupData
                                                                              .communityType
                                                                              .toLowerCase() ==
                                                                          'Free to join'
                                                                              .toLowerCase() ||
                                                                      groupData
                                                                              .communityType
                                                                              .toLowerCase() ==
                                                                          'Require permission'
                                                                              .toLowerCase()) {
                                                                    if (context
                                                                        .mounted) {
                                                                      provider.Provider.of<pro.AuthProviders>(context, listen: false).addGroupInfo(
                                                                          groupNumber: userItem
                                                                              .length
                                                                              .toString(),
                                                                          groupAdminId:
                                                                              userItem[
                                                                                      0]
                                                                                  .userId,
                                                                          groupId: groupData
                                                                              .groupId,
                                                                          groupLink:
                                                                              groupData
                                                                                  .groupLink,
                                                                          isGroupLocked:
                                                                              groupData
                                                                                  .isGroupLocked,
                                                                          pinnedMessage:
                                                                              groupData
                                                                                  .pinnedMessage,
                                                                          groupDesription:
                                                                              groupData
                                                                                  .groupDescription,
                                                                          groupName:
                                                                              groupData
                                                                                  .name,
                                                                          groupPics:
                                                                              groupData
                                                                                  .groupPic);
                                    
                                                                      AppNavigator
                                                                          .pushAndStackPage(
                                                                              context,
                                                                              page:
                                                                                  MobileChatScreen(
                                                                                groupData
                                                                                    .groupDescription,
                                                                                userItem
                                                                                    .length
                                                                                    .toString(),
                                                                                userItem,
                                                                                name: groupData
                                                                                    .name,
                                                                                uid: groupData
                                                                                    .groupId,
                                                                                isGroupChat:
                                                                                    true,
                                                                                profilePic:
                                                                                    groupData.groupPic,
                                                                              ));
                                                                    }
                                                                  } else if (groupData
                                                                          .communityType
                                                                          .toLowerCase() ==
                                                                      'Pay to join'
                                                                          .toLowerCase()) {
                                                                    if (groupData
                                                                            .paymentType
                                                                            .toLowerCase() ==
                                                                        'Monthly'
                                                                            .toLowerCase()) {
                                                                      DateTime
                                                                          currentDate =
                                                                          DateTime
                                                                              .now();
                                    
                                                                      DateTime
                                                                          oneMonthAgo =
                                                                          DateTime(
                                                                        currentDate
                                                                            .year,
                                                                        currentDate
                                                                                .month -
                                                                            1,
                                                                        currentDate.day,
                                                                        currentDate
                                                                            .hour,
                                                                        currentDate
                                                                            .minute,
                                                                        currentDate
                                                                            .second,
                                                                        currentDate
                                                                            .millisecond,
                                                                        currentDate
                                                                            .microsecond,
                                                                      );
                                    
                                                                      if (currentUser
                                                                          .dateJoined
                                                                          .isBefore(
                                                                              oneMonthAgo)) {
                                                                        Modals.showToast(
                                                                            'Subscription expired');
                                                                        provider.Provider.of<pro.AuthProviders>(context, listen: false)
                                                                            .removeCurrentUserFromMembers(
                                                                                groupData
                                                                                    .groupId,
                                                                                userId,
                                                                                context);
                                                                        List<MemberData>
                                                                            userItem =
                                                                            removeDuplicateUsers(
                                                                                groupData
                                                                                    .membersUid);
                                    
                                                                        onTapCommunityPageComponent(
                                                                          context:
                                                                              context,
                                                                          groupImage:
                                                                              groupData
                                                                                  .groupPic,
                                                                          groupName:
                                                                              groupData
                                                                                  .name,
                                                                          groupNumber:
                                                                              userItem
                                                                                  .length
                                                                                  .toString(),
                                                                          groupDescription:
                                                                              groupData
                                                                                  .groupDescription,
                                                                          groupId:
                                                                              groupData
                                                                                  .groupId,
                                                                          userId:
                                                                              userId,
                                                                          adminFcm:
                                                                              groupData
                                                                                  .fcmToken,
                                                                          isPaid: groupData
                                                                              .communityType,
                                                                          communityPrice:
                                                                              groupData
                                                                                  .communityPrice,
                                                                          showCount:
                                                                              groupData
                                                                                  .showMemberCount,
                                                                          userItem:
                                                                              userItem,
                                                                          isGroupLocked:
                                                                              groupData
                                                                                  .isGroupLocked,
                                                                          communityLink:
                                                                              groupData
                                                                                  .groupLink,
                                                                          pinnedMessage:
                                                                              groupData
                                                                                  .groupLink,
                                                                          adminId:
                                                                              userItem[
                                                                                      0]
                                                                                  .userId,
                                                                        );
                                                                      } else {
                                                                        if (context
                                                                            .mounted) {
                                                                          provider.Provider.of<pro.AuthProviders>(context, listen: false).addGroupInfo(
                                                                              groupNumber: userItem
                                                                                  .length
                                                                                  .toString(),
                                                                              groupAdminId:
                                                                                  userItem[0]
                                                                                      .userId,
                                                                              groupId:
                                                                                  groupData
                                                                                      .groupId,
                                                                              groupLink:
                                                                                  groupData
                                                                                      .groupLink,
                                                                              isGroupLocked:
                                                                                  groupData
                                                                                      .isGroupLocked,
                                                                              pinnedMessage:
                                                                                  groupData
                                                                                      .pinnedMessage,
                                                                              groupDesription:
                                                                                  groupData
                                                                                      .groupDescription,
                                                                              groupName:
                                                                                  groupData
                                                                                      .name,
                                                                              groupPics:
                                                                                  groupData
                                                                                      .groupPic);
                                    
                                                                          AppNavigator
                                                                              .pushAndStackPage(
                                                                                  context,
                                                                                  page:
                                                                                      MobileChatScreen(
                                                                                    groupData.groupDescription,
                                                                                    userItem.length.toString(),
                                                                                    userItem,
                                                                                    name:
                                                                                        groupData.name,
                                                                                    uid:
                                                                                        groupData.groupId,
                                                                                    isGroupChat:
                                                                                        true,
                                                                                    profilePic:
                                                                                        groupData.groupPic,
                                                                                  ));
                                                                        }
                                                                      }
                                                                    } else if (groupData
                                                                            .paymentType
                                                                            .toLowerCase() ==
                                                                        'One time payment'
                                                                            .toLowerCase()) {
                                                                      if (context
                                                                          .mounted) {
                                                                        provider.Provider.of<pro.AuthProviders>(context, listen: false).addGroupInfo(
                                                                            groupNumber:
                                                                                userItem
                                                                                    .length
                                                                                    .toString(),
                                                                            groupAdminId:
                                                                                userItem[0]
                                                                                    .userId,
                                                                            groupId: groupData
                                                                                .groupId,
                                                                            groupLink:
                                                                                groupData
                                                                                    .groupLink,
                                                                            isGroupLocked:
                                                                                groupData
                                                                                    .isGroupLocked,
                                                                            pinnedMessage:
                                                                                groupData
                                                                                    .pinnedMessage,
                                                                            groupDesription:
                                                                                groupData
                                                                                    .groupDescription,
                                                                            groupName:
                                                                                groupData
                                                                                    .name,
                                                                            groupPics:
                                                                                groupData
                                                                                    .groupPic);
                                    
                                                                        AppNavigator
                                                                            .pushAndStackPage(
                                                                                context,
                                                                                page:
                                                                                    MobileChatScreen(
                                                                                  groupData
                                                                                      .groupDescription,
                                                                                  userItem
                                                                                      .length
                                                                                      .toString(),
                                                                                  userItem,
                                                                                  name:
                                                                                      groupData.name,
                                                                                  uid: groupData
                                                                                      .groupId,
                                                                                  isGroupChat:
                                                                                      true,
                                                                                  profilePic:
                                                                                      groupData.groupPic,
                                                                                ));
                                                                      }
                                                                    }
                                                                  }
                                                                } else {
                                                                  List<MemberData>
                                                                      userItem =
                                                                      removeDuplicateUsers(
                                                                          groupData
                                                                              .membersUid);
                                    
                                                                  onTapCommunityPageComponent(
                                                                    context: context,
                                                                    groupImage:
                                                                        groupData
                                                                            .groupPic,
                                                                    groupName:
                                                                        groupData.name,
                                                                    groupNumber:
                                                                        userItem.length
                                                                            .toString(),
                                                                    groupDescription:
                                                                        groupData
                                                                            .groupDescription,
                                                                    groupId: groupData
                                                                        .groupId,
                                                                    userId: userId,
                                                                    adminFcm: groupData
                                                                        .fcmToken,
                                                                    isPaid: groupData
                                                                        .communityType,
                                                                    communityPrice:
                                                                        groupData
                                                                            .communityPrice,
                                                                    showCount: groupData
                                                                        .showMemberCount,
                                                                    userItem: userItem,
                                                                    isGroupLocked:
                                                                        groupData
                                                                            .isGroupLocked,
                                                                    communityLink:
                                                                        groupData
                                                                            .groupLink,
                                                                    pinnedMessage:
                                                                        groupData
                                                                            .groupLink,
                                                                    adminId: userItem[0]
                                                                        .userId,
                                                                  );
                                                                }
                                                              },
                                                              groupName: groupData.name,
                                                              lastMessage:
                                                                  groupData.lastMessage,
                                                              groupPic:
                                                                  groupData.groupPic,
                                                              isPaid: groupData
                                                                  .communityType
                                                                  .toString(),
                                                            );
                                                          }))
                                                ]))
                                          ]);
                                        });
                                  }
                                ),
                              ],
                            )))),
              ));
  }

  onTapCommunityPageComponent({
    required BuildContext context,
    required String groupImage,
    required String groupName,
    required String groupNumber,
    required String groupDescription,
    required String groupId,
    required String userId,
    required String adminFcm,
    required String isPaid,
    required String communityPrice,
    required bool showCount,
    required List<MemberData> userItem,
    required bool isGroupLocked,
    required String adminId,
    required String communityLink,
    required String pinnedMessage,
  }) {
    AppNavigator.pushAndStackPage(context,
        page: JoinCommunityInfoScreen(
          groupImage: groupImage,
          groupName: groupName,
          groupNumber: groupNumber,
          groupDescription: groupDescription,
          groupId: groupId,
          userId: userId,
          adminFcm: adminFcm,
          isPaid: isPaid,
          communityPrice: communityPrice,
          showCount: showCount,
          userItem: userItem,
          communityLink: communityLink,
          isGroupLocked: isGroupLocked,
          pinnedMessage: pinnedMessage,
          adminId: adminId,
        ));
  }

  List<MemberData> removeDuplicateUsers(List<MemberData> users) {
    final Map<String, MemberData> uniqueUsers = {};

    for (var user in users) {
      uniqueUsers[user.userId] = user;
    }

    return uniqueUsers.values.toList();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.pop(context);
        },
        imagePath: ImageConstant.imgArrowBack,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 15.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitleTwo(
        text: "Tellasport Community",
      ),
      styleType: Style.bgOutline_3,
    );
  }
}
