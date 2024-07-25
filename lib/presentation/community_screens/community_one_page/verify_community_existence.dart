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

import 'package:provider/provider.dart' as provider;

import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';

class VerifyCommunityExistence extends ConsumerStatefulWidget {
  final String link;
  const VerifyCommunityExistence(this.link, {Key? key}) : super(key: key);

  @override
  VerifyCommunityExistenceState createState() =>
      VerifyCommunityExistenceState();
}

class VerifyCommunityExistenceState
    extends ConsumerState<VerifyCommunityExistence>
    with AutomaticKeepAliveClientMixin<VerifyCommunityExistence> {
  TextEditingController searchController = TextEditingController();

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
  bool linkExists = false;

  var groupData;

  @override
  void initState() {
    getUserId();
    _focusNode = FocusNode();
    Future.delayed(Duration(seconds: 2), (() {
      setState(() {
        isLoading = false;
      });
    }));

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

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
                    child: StreamBuilder<List<Group>>(
                        stream: checkUserExist.getAllChatGroups(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LoadingPage();
                          } else if (snapshot.data?.isEmpty ?? false) {
                            return EmptyCommunityPage();
                          }

                          if (!_dataAdded) {
                            checkUserExist.clearGroupInfo();

                            _dataAdded = true;
                          }

                          if (snapshot.hasData) {
                            for (Group group in snapshot.data!) {
                              if (group.groupId.trim() == widget.link.trim()) {
                                linkExists = true;
                                groupData = group;
                                break;
                              }
                            }

                            if (linkExists) {
                              checkUserExist.updateGroupData(groupData);

                              checkUserExist
                                  .requestedUsers(groupData.requestsMembers);
                              checkUserExist
                                  .blockedUsers(groupData.blockedMembers);

                              List<MemberData> userItem =
                                  removeDuplicateUsers(groupData.membersUid);
                              MemberData? currentUser;

                              if (userItem
                                  .any((user) => user.userId == userId)) {
                                currentUser = userItem.firstWhere(
                                    (user) => user.userId == userId);

                                if (userItem.first.userId == userId ||
                                    groupData.communityType.toLowerCase() ==
                                        'Free to join'.toLowerCase() ||
                                    groupData.communityType.toLowerCase() ==
                                        'Require permission'.toLowerCase()) {
                                  if (context.mounted) {
                                    checkUserExist.addGroupInfo(
                                        groupNumber: userItem.length.toString(),
                                        groupAdminId: userItem[0].userId,
                                        groupId: groupData.groupId,
                                        groupLink: groupData.groupLink,
                                        isGroupLocked: groupData.isGroupLocked,
                                        pinnedMessage: groupData.pinnedMessage,
                                        groupDesription:
                                            groupData.groupDescription,
                                        groupName: groupData.name,
                                        groupPics: groupData.groupPic);

                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      AppNavigator.pushAndReplacePage(context,
                                          page: MobileChatScreen(
                                            groupData.groupDescription,
                                            userItem.length.toString(),
                                            userItem,
                                            name: groupData.name,
                                            uid: groupData.groupId,
                                            isGroupChat: true,
                                            profilePic: groupData.groupPic,
                                          ));
                                    });
                                  }
                                } else if (groupData.communityType
                                        .toLowerCase() ==
                                    'Pay to join'.toLowerCase()) {
                                  if (groupData.paymentType.toLowerCase() ==
                                      'Monthly'.toLowerCase()) {
                                    DateTime currentDate = DateTime.now();

                                    DateTime oneMonthAgo = DateTime(
                                      currentDate.year,
                                      currentDate.month - 1,
                                      currentDate.day,
                                      currentDate.hour,
                                      currentDate.minute,
                                      currentDate.second,
                                      currentDate.millisecond,
                                      currentDate.microsecond,
                                    );

                                    if (currentUser.dateJoined
                                        .isBefore(oneMonthAgo)) {
                                      Modals.showToast('Subscription expired');
                                      checkUserExist
                                          .removeCurrentUserFromMembers(
                                              groupData.groupId,
                                              userId,
                                              context);
                                      List<MemberData> userItem =
                                          removeDuplicateUsers(
                                              groupData.membersUid);

                                      onTapCommunityPageComponent(
                                        context: context,
                                        groupImage: groupData.groupPic,
                                        groupName: groupData.name,
                                        groupNumber: userItem.length.toString(),
                                        groupDescription:
                                            groupData.groupDescription,
                                        groupId: groupData.groupId,
                                        userId: userId,
                                        adminFcm: groupData.fcmToken,
                                        isPaid: groupData.communityType,
                                        communityPrice:
                                            groupData.communityPrice,
                                        showCount: groupData.showMemberCount,
                                        userItem: userItem,
                                        isGroupLocked: groupData.isGroupLocked,
                                        communityLink: groupData.groupLink,
                                        pinnedMessage: groupData.groupLink,
                                        adminId: userItem[0].userId,
                                      );
                                    } else {
                                      if (context.mounted) {
                                        checkUserExist.addGroupInfo(
                                            groupNumber:
                                                userItem.length.toString(),
                                            groupAdminId: userItem[0].userId,
                                            groupId: groupData.groupId,
                                            groupLink: groupData.groupLink,
                                            isGroupLocked:
                                                groupData.isGroupLocked,
                                            pinnedMessage:
                                                groupData.pinnedMessage,
                                            groupDesription:
                                                groupData.groupDescription,
                                            groupName: groupData.name,
                                            groupPics: groupData.groupPic);

                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          AppNavigator.pushAndReplacePage(
                                              context,
                                              page: MobileChatScreen(
                                                groupData.groupDescription,
                                                userItem.length.toString(),
                                                userItem,
                                                name: groupData.name,
                                                uid: groupData.groupId,
                                                isGroupChat: true,
                                                profilePic: groupData.groupPic,
                                              ));
                                        });
                                      }
                                    }
                                  } else if (groupData.paymentType
                                          .toLowerCase() ==
                                      'One time payment'.toLowerCase()) {
                                    if (context.mounted) {
                                      checkUserExist.addGroupInfo(
                                          groupNumber:
                                              userItem.length.toString(),
                                          groupAdminId: userItem[0].userId,
                                          groupId: groupData.groupId,
                                          groupLink: groupData.groupLink,
                                          isGroupLocked:
                                              groupData.isGroupLocked,
                                          pinnedMessage:
                                              groupData.pinnedMessage,
                                          groupDesription:
                                              groupData.groupDescription,
                                          groupName: groupData.name,
                                          groupPics: groupData.groupPic);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        AppNavigator.pushAndReplacePage(context,
                                            page: MobileChatScreen(
                                              groupData.groupDescription,
                                              userItem.length.toString(),
                                              userItem,
                                              name: groupData.name,
                                              uid: groupData.groupId,
                                              isGroupChat: true,
                                              profilePic: groupData.groupPic,
                                            ));
                                      });
                                    }
                                  }
                                }
                              } else {
                                List<MemberData> userItem =
                                    removeDuplicateUsers(groupData.membersUid);

                                onTapCommunityPageComponent(
                                  context: context,
                                  groupImage: groupData.groupPic,
                                  groupName: groupData.name,
                                  groupNumber: userItem.length.toString(),
                                  groupDescription: groupData.groupDescription,
                                  groupId: groupData.groupId,
                                  userId: userId,
                                  adminFcm: groupData.fcmToken,
                                  isPaid: groupData.communityType,
                                  communityPrice: groupData.communityPrice,
                                  showCount: groupData.showMemberCount,
                                  userItem: userItem,
                                  isGroupLocked: groupData.isGroupLocked,
                                  communityLink: groupData.groupLink,
                                  pinnedMessage: groupData.groupLink,
                                  adminId: userItem[0].userId,
                                );
                              }
                            } else {
                              Modals.showToast('invalid group link');

                              Navigator.pop(context);
                            }
                          }

                          return SizedBox.shrink();
                        }))),
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
    required String communityLink,
    required String pinnedMessage,
    required String adminId,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppNavigator.pushAndReplacePage(context,
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
    });
  }

  List<MemberData> removeDuplicateUsers(List<MemberData> users) {
    final Map<String, MemberData> uniqueUsers = {};

    for (var user in users) {
      uniqueUsers[user.userId] = user;
    }

    return uniqueUsers.values.toList();
  }

  String extractPath(String url) {
    try {
      final Uri uri = Uri.parse(url);
      String path = uri.path;
      if (path.startsWith('/')) {
        path = path.substring(1);
      }
      Modals.showToast(path);
      return path;
    } catch (e) {
      print('Error parsing URL: $e');
      return '';
    }
  }
}
