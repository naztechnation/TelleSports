import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter/services.dart';

import '../../../../core/app_export.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../../widgets/app_bar/appbar_subtitle_four.dart';
import '../../../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../../../widgets/app_bar/appbar_title_circleimage.dart';
import '../../../../widgets/app_bar/appbar_trailing_image.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../widgets/modals.dart';

import '../../community_one_page/community_info_page.dart';
import '../../provider/auth_provider.dart' as pro;
import '../widgets/bottom_chat_field.dart';
import '../widgets/chat_list.dart';

class MobileChatScreen extends ConsumerStatefulWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;
  final String groupNumber;
  final String groupDesc;
  const MobileChatScreen(
    this.groupDesc,
    this.groupNumber, {
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MobileChatScreenState();
}

class _MobileChatScreenState extends ConsumerState<MobileChatScreen> {
  final ScrollController messageController = ScrollController();

  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    final groupInfo =
        provider.Provider.of<pro.AuthProviders>(context, listen: true);

    groupInfo.isSelectedMessage(false);
    groupInfo.setSelectedMessage('');
    groupInfo.setTextIndex(-1);
    messageController.dispose();
  }

  void makeCall(WidgetRef ref, BuildContext context) {
    // ref.read(callControllerProvider).makeCall(
    //       context,
    //       widget.name,
    //       widget.uid,
    //       widget.profilePic,
    //       widget.isGroupChat,
    //     );
  }

  String userId = '';
  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
  }

  @override
  void initState() {
    getUserId();

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final groupInfo =
        provider.Provider.of<pro.AuthProviders>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        groupInfo.isSelectedMessage(false);
        groupInfo.setSelectedMessage('');
        groupInfo.setTextIndex(-1);
        Navigator.pop(context);

        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            backgroundColor: appTheme.lime50,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              leadingWidth: 44.h,
              leading: AppbarLeadingImage(
                imagePath: ImageConstant.imgArrowBackBlue800,
                onTap: () {
                  groupInfo.isSelectedMessage(false);
                  groupInfo.setSelectedMessage('');
                  groupInfo.setTextIndex(-1);
                  Navigator.pop(context);
                },
                margin: EdgeInsets.only(
                  left: 20.h,
                  top: 0.v,
                  bottom: 10.v,
                ),
              ),
              title: Padding(
                padding: EdgeInsets.only(
                  left: 12.h,
                  top: 0.v,
                  bottom: 4.v,
                ),
                child: Row(
                  children: [
                    AppbarTitleCircleimage(
                      onTap: () {
                        onTapGroup(context, widget.profilePic, widget.name);
                      },
                      imagePath: widget.profilePic,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.h),
                      child: Column(
                        children: [
                          AppbarSubtitleTwo(
                            text: widget.name,
                            onTap: () {
                              onTapGroup(
                                  context, widget.profilePic, widget.name);
                            },
                          ),
                          AppbarSubtitleFour(
                            text: "${widget.groupNumber}   member(s)",
                            margin: EdgeInsets.only(right: 28.h),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
              if(
                 (groupInfo.isSelected )

              )  PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert),
                  onSelected: (String choice) {
                    if (choice == 'delete') {
                      
                    } else if (choice == 'pin') {
                       groupInfo.updateGroupPinnedMessage(
                                        groupInfo.groupId, groupInfo.selectedMessage);
                     
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Delete Message'),
                      ),
                    ),
                     const PopupMenuItem<String>(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Delete Message'),
                      ),
                    ),
                groupInfo.groupAdminId == userId ?    const PopupMenuItem<String>(
                      value: 'pin',
                      child: ListTile(
                        leading: Icon(Icons.push_pin),
                        title: Text('Pin Message'),
                      ),
                    ):  const PopupMenuItem<String>(
                      value: 'delete',
                      child: ListTile(
                        leading: SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  width: 5,
                )
              ],
              styleType: Style.bgOutline,
            ),
            body: GestureDetector(
              onTap: () {
                groupInfo.isSelectedMessage(false);
                groupInfo.setSelectedMessage('');
                groupInfo.setTextIndex(-1);
              },
              child: Column(
                children: [
                  if (groupInfo.groupPinnedMessage != '')
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.push_pin, color: Colors.blue,),
                            SizedBox(width: 20,),
                            Expanded(
                              child: Text(
                                groupInfo.groupPinnedMessage,
                                textAlign: TextAlign.justify,
                                
                                style: const TextStyle(color: Colors.black, wordSpacing: -1),
                              ),
                            ),
                            SizedBox(width: 10,),
                             
                            if (groupInfo.groupAdminId == userId)
                              GestureDetector(
                                  onTap: () {
                                    groupInfo.updateGroupPinnedMessage(
                                        groupInfo.groupId, '');
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.blue,
                                    size: 28,
                                  ))
                          ],
                        ),
                      ),
                    ),
                  Expanded(
                    child: ChatList(
                      recieverUserId: widget.uid,
                      isGroupChat: widget.isGroupChat,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('groups')
                        .doc(groupInfo.groupId)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      final isGroupLocked =
                          snapshot.data?.get('isGroupLocked') ?? false;

                      return (isGroupLocked)
                          ? (groupInfo.groupAdminId == userId)
                              ? BottomChatField(
                                  recieverUserId: widget.uid,
                                  isGroupChat: widget.isGroupChat,
                                )
                              : Container(
                                  height: 45,
                                  color: Colors.grey.shade300,
                                  child: const Padding(
                                    padding: EdgeInsets.only(bottom: 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.lock,
                                          color: Colors.blue,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'only admins can send messages here',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                          : BottomChatField(
                              recieverUserId: widget.uid,
                              isGroupChat: widget.isGroupChat,
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> copyToClipboard(
      String text, var groupInfo, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text)).then((value) => {
          Modals.showToast('Message copied'),
          groupInfo.isSelectedMessage(false),
          groupInfo.setSelectedMessage(''),
          groupInfo.setTextIndex(-1),
          Navigator.pop(context),
        });
  }

  onTapGroup(BuildContext context, String image, String name) {
    AppNavigator.pushAndStackPage(context,
        page: CommunityInfoScreen(
          profilePic: image,
          name: name,
        ));
  }
}
