 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:tellesports/widgets/loading_page.dart';

import '../../../handlers/secure_handler.dart';
import '../../../model/chat_model/group.dart'; 
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/modals.dart';
import '../chat/screens/mobile_chat_screen.dart';
import '../join_community_screen/join_community_screen.dart';
import '../provider/auth_provider.dart' as pro;
import 'empty_comunity_page.dart';
import 'widgets/community_item_widget.dart';
import 'package:provider/provider.dart' as provider;

import 'package:flutter/material.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/custom_text_form_field.dart';

import 'widgets/create_community.dart';

class SearchGroupPage extends ConsumerStatefulWidget {
  const SearchGroupPage({Key? key}) : super(key: key);

  @override
  SearchGroupPageState createState() => SearchGroupPageState();
}

// ignore_for_file: must_be_immutable
class SearchGroupPageState extends ConsumerState<SearchGroupPage>
    with AutomaticKeepAliveClientMixin<SearchGroupPage> {
  TextEditingController searchController = TextEditingController();

  List<String> userItem = [];

  late FocusNode _focusNode;

  String userId = '';
  String plan = '';
  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
    plan = await StorageHandler.getUserPlan() ?? '';
   Future.delayed(Duration(seconds: 1), (() {
      setState(() {});
   }));
  }

  bool _dataAdded = false;

  @override
  void initState() {
    getUserId();
    _focusNode = FocusNode();
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

    return SafeArea(
        child: Scaffold(
      body: Scaffold(
          resizeToAvoidBottomInset: false,
          
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
                          checkUserExist.clearGroupInfo();
                          checkUserExist.clearSearchList();
                          checkUserExist.updateSearchList(
                            snapshot.data!,
                          );
                          _dataAdded = true;
                        }

                        return Column(children: [
                          SizedBox(height: 10.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: Column(children: [
                                const SizedBox(height: 15),
                                CustomTextFormField(
                                    controller: searchController,

                                    
                                    onChanged: (value) {
                                      checkUserExist.filterSearchResults(value);

                                      if(searchController.text.isEmpty){
                                        setState(() {
                                          
                                        });
                                      }
                                    },
                                    hintText: "Search for communities",
                                    hintStyle:
                                        CustomTextStyles.titleSmallGray400,
                                    textInputAction: TextInputAction.done,
                                    prefix: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0, right: 12),
                                        child: Icon(Icons.arrow_back, size: 25,),
                                      ),
                                    ),
                                    suffix: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          
                                        });
                                      },
                                      child: Container(
                                       
                                         decoration: BoxDecoration(
                                           color: Colors.blue,
                                           borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8))
                                         ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(10),
                                            child: CustomImageView(
                                                imagePath:
                                                    ImageConstant.imgSearchGray400,
                                                
                                                color: Colors.white,
                                                ),
                                          )),
                                    ),
                                    prefixConstraints:
                                        BoxConstraints(maxHeight: 34.v),
                                    contentPadding: EdgeInsets.only(
                                        top: 1.v, right: 30.h, bottom: 7.v),
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
                                        itemCount:
                                            checkUserExist.searchResult.length,
                                        itemBuilder: (context, index) {
                                           
                                            Group groupData = checkUserExist.searchResult[index];
                                    
                                          return CommunityPageComponent(
                                            onTapCommunityPageComponent:
                                                () async {
                                              checkUserExist.requestedUsers(
                                                  groupData.requestsMembers);
                                              checkUserExist.blockedUsers(
                                                  groupData.blockedMembers);
                                    
                                              List<String> userItem =
                                                  removeDuplicates(
                                                      groupData.membersUid);
                                               
                                              if (userItem.contains(userId)) {
                                                if (context.mounted) {
                                                  checkUserExist.addGroupInfo(
                                                      groupNumber: userItem
                                                          .length
                                                          .toString(),
                                                      groupAdminId: userItem[0],
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
                                                            userItem,
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
                                                List<String> userItem =
                                                    removeDuplicates(
                                                        groupData.membersUid);
                                                 
                                    
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
                                                  adminFcm: groupData.fcmToken,
                                                );
                                              }
                                            },
                                            groupName: groupData.name,
                                            lastMessage: groupData.lastMessage,
                                            groupPic: groupData.groupPic,
                                            date: groupData.timeSent.toLocal(),
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
    required String adminFcm,
  }) {
    AppNavigator.pushAndStackPage(context,
        page: CommunityInfoScreen(
          groupImage: groupImage,
          groupName: groupName,
          groupNumber: groupNumber,
          groupDescription: groupDescription,
          groupId: groupId,
          adminFcm: adminFcm,
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
