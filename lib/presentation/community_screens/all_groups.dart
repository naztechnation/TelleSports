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
import 'community_one_page/empty_comunity_page.dart';
import 'community_one_page/widgets/community_item_widget.dart';
import 'community_one_page/widgets/create_community.dart';
import 'provider/auth_provider.dart' as pro;

class AllGroupsListPage extends ConsumerStatefulWidget {
  const AllGroupsListPage({Key? key}) : super(key: key);

  @override
  AllGroupsListPageState createState() => AllGroupsListPageState();
}

// ignore_for_file: must_be_immutable
class AllGroupsListPageState extends ConsumerState<AllGroupsListPage>
    with AutomaticKeepAliveClientMixin<AllGroupsListPage> {
  TextEditingController searchController = TextEditingController();


  List<String> userItem = [];
 

  String userId = '';
  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
    setState(() {});
  }

  bool _dataAdded = false;

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
        provider.Provider.of<pro.AuthProviders>(context, listen: false);

    return SafeArea(
        child: Scaffold(
          body: Scaffold(
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: buildBuyTellacoins(context),
              ),
              // appBar: _buildAppBar(context,),
        
              body: SizedBox(
                  width: mediaQueryData.size.width,
                  child: SingleChildScrollView(
                      child: StreamBuilder<List<Group>>(
                          stream: checkUserExist.getAllChatGroups(userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LoadingPage();
                            } else if (snapshot.data!.isEmpty) {
                              return EmptyCommunityPage();
                            }
        
                            if (!_dataAdded) {
                           provider.Provider.of<pro.AuthProviders>(context, listen: true).clearSearchList1();

                                                        provider.Provider.of<pro.AuthProviders>(context, listen: true).updateSearchList1(snapshot.data!,);

                              _dataAdded = true;
                            }
        
                            return Column(children: [
                              SizedBox(height: 12.v),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                                  child: Column(children: [
                                    const SizedBox(height: 15),
                                     CustomTextFormField(
                                         controller: searchController,
                                         
                                        onChanged: (value) {
                                          checkUserExist.filterSearchResults1(value);
                                        },
                                        hintText:
                                            "Search for communities or users",
                                        hintStyle:
                                            CustomTextStyles.titleSmallGray400,
                                        textInputAction: TextInputAction.done,
                                        prefix: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                20.h, 5.v, 9.h, 5.v),
                                            child: CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgSearchGray400,
                                                height: 24.adaptSize,
                                                width: 24.adaptSize)),
                                        prefixConstraints:
                                            BoxConstraints(maxHeight: 34.v),
                                        contentPadding: EdgeInsets.only(
                                            top: 17.v, right: 30.h, bottom: 7.v),
                                        borderDecoration:
                                            TextFormFieldStyleHelper.fillGray,
                                        filled: true,
                                        fillColor: appTheme.gray100),
                                    SizedBox(height: 10.v),
                                    Align(
                                        alignment: Alignment.center,
                                        child: ListView.separated(
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 1.v);
                                            },
                                            itemCount: checkUserExist.searchResult1.length,
                                            itemBuilder: (context, index) {
                                              Group groupData =
                                                  checkUserExist.searchResult1[index];
        
                                              userItem = removeDuplicates(
                                                  groupData.membersUid);
                                              return CommunityPageComponent(
                                                onTapCommunityPageComponent:
                                                    () async {
                                                  checkUserExist.requestedUsers(
                                                      groupData.requestsMembers);
                                                  checkUserExist.blockedUsers(
                                                      groupData.blockedMembers);
        
                                                  if (userItem
                                                      .contains(userId)) {
                                                    if (context.mounted) {
                                                      checkUserExist.addGroupInfo(
                                                          groupNumber: userItem
                                                              .length
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
                                                          groupName:
                                                              groupData.name,
                                                          groupPics:
                                                              groupData.groupPic);
        
                                                      AppNavigator
                                                          .pushAndStackPage(
                                                              context,
                                                              page:
                                                                  MobileChatScreen(
                                                                groupData
                                                                    .groupDescription,
                                                                userItem.length
                                                                    .toString(),
                                                                    userItem,
                                                                name: groupData
                                                                    .name,
                                                                uid: groupData
                                                                    .groupId,
                                                                isGroupChat: true,
                                                                profilePic:
                                                                    groupData
                                                                        .groupPic,
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
                                                      groupNumber: userItem.length
                                                          .toString(),
                                                      groupDescription: groupData
                                                          .groupDescription,
                                                      groupId: groupData.groupId,
                                                      userId: userId,
                                                    );
                                                  }
                                                },
                                                groupName:
                                                    groupData.name,
                                                lastMessage:
                                                    '${userItem.length.toString()} members',
                                                groupPic: groupData.groupPic,
                                                date: null,
                                                groupNumber:
                                                    userItem.length.toString(),
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
      if (items.isNotEmpty || items != []) {
        uniqueItems[int.tryParse(item)!] = item;
      }
    });

    return uniqueItems.values.toList();
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
