import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/loading_page.dart';

import '../../../handlers/secure_handler.dart';
import '../../../model/chat_model/group.dart';
import '../../../widgets/modals.dart';
import '../chat/screens/mobile_chat_screen.dart';
import '../join_community_screen/join_community_screen.dart';
import '../provider/auth_provider.dart' as pro;
import 'empty_community_page.dart';
import '../widgets/community_item_widget.dart';
import 'package:provider/provider.dart' as provider;

import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';


class CommunityListPage extends ConsumerStatefulWidget {
  const CommunityListPage({Key? key}) : super(key: key);

  @override
  CommunityOnePageState createState() => CommunityOnePageState();
}

// ignore_for_file: must_be_immutable
class CommunityOnePageState extends ConsumerState<CommunityListPage>
    with AutomaticKeepAliveClientMixin<CommunityListPage> {
  TextEditingController _searchController = TextEditingController();
  final ValueNotifier<String> _searchQuery = ValueNotifier<String>('');

  List<String> userItem = [];

  late FocusNode _focusNode;

  String userId = '';
  String plan = '';
  String email = '';

  bool isLoading = true;

  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
    plan = await StorageHandler.getUserPlan() ?? '';
    email = await StorageHandler.getUserEmail() ?? '';
    Future.delayed(Duration(seconds: 1), (() {
      setState(() {});
    }));
  }

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
  void dispose() {
    _searchController.dispose();
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final checkUserExist =
        provider.Provider.of<pro.AuthProviders>(context, listen: false);

    return (isLoading)
        ? LoadingPage()
        : SafeArea(
            child: Scaffold(
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
                                  stream:
                                      checkUserExist.getAllChatGroups(userId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const LoadingPage();
                                    } else if (filterGroupsByMemberId(
                                            snapshot.data!, userId)
                                        .isEmpty) {
                                      return EmptyCommunityPage();
                                    }

                                    if (!_dataAdded) {
                                      checkUserExist.clearGroupInfo();

                                      _dataAdded = true;
                                    }

                                    final List<Group> filteredDocuments =
                                        filterGroupsByMemberId(
                                                snapshot.data!, userId)
                                            .where((doc) {
                                      final String groupName =
                                          doc.name.toString().toLowerCase();
                                      return groupName.contains(query);
                                    }).toList();

                                    if (filteredDocuments.isEmpty) {
                                      return EmptyCommunityPage();
                                    }

                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.h),
                                        child: Column(children: [
                                          SizedBox(height: 10.v),
                                          ListView.separated(
                                              physics:
                                                  BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(height: 1.v);
                                              },
                                              itemCount:
                                                  filteredDocuments.length ??
                                                      0,
                                              itemBuilder: (context, index) {
                                                List<Group> allgroups =
                                                    filteredDocuments;
                                                Group? groupData =
                                                    allgroups[index];
                                    
                                                return CommunityPageComponent(
                                                  onTapCommunityPageComponent:
                                                      () async {
                                                    checkUserExist
                                                        .updateGroupData(
                                                            groupData);
                                    
                                                    checkUserExist
                                                        .requestedUsers(groupData
                                                            .requestsMembers);
                                                    checkUserExist
                                                        .blockedUsers(groupData
                                                            .blockedMembers);
                                    
                                                    List<MemberData>
                                                        userItem =
                                                        removeDuplicateUsers(
                                                            groupData
                                                                .membersUid);
                                    
                                                    MemberData? currentUser;
                                    
                                                    if (userItem.any((user) =>
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
                                                        if (context.mounted) {
                                                          checkUserExist.addGroupInfo(
                                                              groupNumber: userItem
                                                                  .length
                                                                  .toString(),
                                                              groupAdminId:
                                                                  userItem[0]
                                                                      .userId,
                                                              groupId: groupData
                                                                  .groupId,
                                                              groupLink: groupData
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
                                                                        groupData
                                                                            .groupPic,
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
                                                              DateTime.now();
                                    
                                                          DateTime
                                                              oneMonthAgo =
                                                              DateTime(
                                                            currentDate.year,
                                                            currentDate
                                                                    .month -
                                                                1,
                                                            currentDate.day,
                                                            currentDate.hour,
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
                                                            checkUserExist
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
                                                              userId: userId,
                                                              adminFcm:
                                                                  groupData
                                                                      .fcmToken,
                                                              isPaid: groupData
                                                                  .communityType,
                                                              communityPrice:
                                                                  groupData
                                                                      .communityPrice,
                                                              showCount: groupData
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
                                                                  userItem[0]
                                                                      .userId,
                                                            );
                                                          } else {
                                                            if (context
                                                                .mounted) {
                                                              checkUserExist.addGroupInfo(
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
                                                        } else if (groupData
                                                                .paymentType
                                                                .toLowerCase() ==
                                                            'One time payment'
                                                                .toLowerCase()) {
                                                          if (context
                                                              .mounted) {
                                                            checkUserExist.addGroupInfo(
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
                                                        groupImage: groupData
                                                            .groupPic,
                                                        groupName:
                                                            groupData.name,
                                                        groupNumber: userItem
                                                            .length
                                                            .toString(),
                                                        groupDescription:
                                                            groupData
                                                                .groupDescription,
                                                        groupId:
                                                            groupData.groupId,
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
                                                  groupName:
                                                      groupData.name ?? '',
                                                  lastMessage:
                                                      groupData.lastMessage ??
                                                          '',
                                                  groupPic:
                                                      groupData.groupPic ??
                                                          '',
                                                  date: groupData.timeSent
                                                      .toLocal(),
                                                  isPaid: groupData
                                                          .communityType
                                                          .toString() ??
                                                      '',
                                                );
                                              })
                                        ]));
                                  });
                            }),
                      ],
                    )))),
          ));
  }

  List<Group> filterGroupsByMemberId(List<Group> groups, String currentUserId) {
    return groups.where((group) {
      return group.membersUid.any((member) => member.userId == currentUserId);
    }).toList();
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
    required String communityLink,
    required String pinnedMessage,
    required String adminId,
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
}
