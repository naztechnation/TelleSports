import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/loading_page.dart';

import '../../../handlers/secure_handler.dart';
import '../../../model/chat_model/user_model.dart';
import '../../../widgets/modals.dart';
import '../chat/screens/mobile_chat_screen.dart';
import '../community_info_screen/join_community_screen.dart';
import '../provider/auth_provider.dart' as pro;
import 'empty_comunity_page.dart';
import 'widgets/community_item_widget.dart';
import 'package:provider/provider.dart' as provider;

import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import 'widgets/create_community.dart';

class CommunityListPage extends ConsumerStatefulWidget {
  const CommunityListPage({Key? key}) : super(key: key);

  @override
  CommunityOnePageState createState() => CommunityOnePageState();
}

// ignore_for_file: must_be_immutable
class CommunityOnePageState extends ConsumerState<CommunityListPage>
    with AutomaticKeepAliveClientMixin<CommunityListPage> {
  TextEditingController searchController = TextEditingController();

  String userId = '';
  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
    setState(() {});
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final checkUserExist =
        provider.Provider.of<pro.AuthProviders>(context, listen: true);

    return SafeArea(
        child: Scaffold(
      body: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: buildBuyTellacoins(context),
          ),
          body: SizedBox(
              width: mediaQueryData.size.width,
              child: SingleChildScrollView(
                  child: StreamBuilder<List<dynamic>>(
                      stream: checkUserExist.getAllChatGroups(userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingPage();
                        } else if (snapshot.data!.isEmpty) {
                          return EmptyCommunityPage();
                        }

                        return Column(children: [
                          SizedBox(height: 12.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: Column(children: [
                                CustomTextFormField(
                                    controller: searchController,
                                    hintText: "Search for communities or users",
                                    hintStyle:
                                        CustomTextStyles.titleSmallGray400,
                                    textInputAction: TextInputAction.done,
                                    prefix: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            20.h, 5.v, 9.h, 5.v),
                                        child: CustomImageView(
                                            imagePath:
                                                ImageConstant.imgSearchGray400,
                                            height: 24.adaptSize,
                                            width: 24.adaptSize)),
                                    prefixConstraints:
                                        BoxConstraints(maxHeight: 34.v),
                                    contentPadding: EdgeInsets.only(
                                        top: 7.v, right: 30.h, bottom: 7.v),
                                    borderDecoration:
                                        TextFormFieldStyleHelper.fillGray,
                                    filled: true,
                                    fillColor: appTheme.gray100),
                                SizedBox(height: 22.v),
                                Align(
                                    alignment: Alignment.center,
                                    child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(height: 1.v);
                                        },
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          var groupData = snapshot.data![index];
                                          return CommunityPageComponent(
                                            onTapCommunityPageComponent:
                                                () async {
                                                  
                                              checkUserExist.requestedUsers(
                                                  groupData.requestsMembers);
                                              checkUserExist.blockedUsers(
                                                  groupData.blockedMembers);
                                                  List<String> userItem = removeDuplicates(groupData
                                                          .membersUid);
                                              if (groupData.membersUid
                                                  .contains(userId)) {
                                                if (context.mounted) {
                                                  checkUserExist.addGroupInfo(
                                                      groupNumber: 
                                                          userItem.length
                                                          .toString(),
                                                      groupAdminId: groupData
                                                          .membersUid[0],
                                                      groupId:
                                                          groupData.groupId,
                                                      groupLink:
                                                          groupData.groupLink,
                                                      isGroupLocked: groupData
                                                          .isGroupLocked,
                                                      pinnedMessage: groupData
                                                          .pinnedMessage,
                                                      groupDesription: groupData
                                                          .groupDescription,
                                                      groupName: groupData.name,
                                                      groupPics:
                                                          groupData.groupPic);

                                                  AppNavigator.pushAndStackPage(
                                                      context,
                                                      page: MobileChatScreen(
                                                        groupData
                                                            .groupDescription,
                                                        userItem.length
                                                            .toString(),
                                                        name: groupData.name,
                                                        uid: groupData.groupId,
                                                        isGroupChat: true,
                                                        profilePic:
                                                            groupData.groupPic,
                                                      ));
                                                }
                                              } else {
                                                Modals.showToast(
                                                  'You are not a member of this group',
                                                );

                                                onTapCommunityPageComponent(
                                                  context: context,
                                                  groupImage:
                                                      groupData.groupPic,
                                                  groupName: groupData.name,
                                                  groupNumber: groupData
                                                      .membersUid.length
                                                      .toString(),
                                                  groupDescription: groupData
                                                      .groupDescription,
                                                  groupId: groupData.groupId,
                                                  userId: userId,
                                                );
                                              }
                                            },
                                            groupName: groupData.name,
                                            lastMessage: groupData.lastMessage,
                                            groupPic: groupData.groupPic,
                                            date: groupData.timeSent.toLocal(),
                                            groupNumber: groupData
                                                .membersUid.length
                                                .toString(),
                                          );
                                        }))
                              ]))
                        ]);
                      })))),
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
  }) {
    AppNavigator.pushAndStackPage(context,
        page: CommunityInfoScreen(
          groupImage: groupImage,
          groupName: groupName,
          groupNumber: groupNumber,
          groupDescription: groupDescription,
          groupId: groupId,
          userId: userId,
        ));
  }


List<String> removeDuplicates(List<String> items) {
  Map<int, String> uniqueItems = {};

  items.forEach((item) {
    if(items.isNotEmpty || items != []){
    uniqueItems[int.tryParse(item)!] = item;

    }
  });

  return uniqueItems.values.toList();
}
}
