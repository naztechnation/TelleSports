import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter/services.dart';

import '../../../../common/enums/message_enum.dart';
import '../../../../common/providers/message_reply_provider.dart';
import '../../../../core/app_export.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../../widgets/app_bar/appbar_subtitle_four.dart';
import '../../../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../../../widgets/app_bar/appbar_title_circleimage.dart';

import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../widgets/modals.dart';

import '../../community_one_page/community_info_page.dart';
import '../../provider/auth_provider.dart' as pro;
import '../controller/chat_controller.dart';
import '../widgets/bottom_chat_field.dart';

import '../widgets/my_message_card.dart';
import '../widgets/sender_message_card.dart';

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

  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    final groupInfo =
        provider.Provider.of<pro.AuthProviders>(context, listen: true);

    groupInfo.isSelectedMessage(false);
    groupInfo.setSelectedMessage('');
    groupInfo.setTextIndex(-1);
    _scrollController.dispose();

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
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _scrollDown();
  });
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
        groupInfo.setMessageId('');
        groupInfo.setMessageType(MessageEnum.none);

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
                  groupInfo.setMessageId('');
                  groupInfo.setMessageType(MessageEnum.none);

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppbarSubtitleTwo(
                            text: widget.name,
                            onTap: () {
                              onTapGroup(
                                  context, widget.profilePic, widget.name);
                            },
                          ),
                          AppbarSubtitleFour(
                            onTap: () {
                              onTapGroup(
                                  context, widget.profilePic, widget.name);
                            },
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
                if (groupInfo.isSelected)
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert),
                    onSelected: (String choice) {
                      if (choice == 'delete') {
                        groupInfo.deleteChatMessage(
                            recieverUserId: widget.uid,
                            userId: userId,
                            messageId: groupInfo.messageId.toString());
                      } else if (choice == 'pin') {
                        groupInfo.updateGroupPinnedMessage(
                            groupInfo.groupId, groupInfo.selectedMessage);
                      } else if (choice == 'copy') {
                        copyToClipboard(
                            groupInfo.selectedMessage, groupInfo, context);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      if (groupInfo.groupAdminId == userId)
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Delete Message'),
                          ),
                        ),
                      if (groupInfo.messageType == MessageEnum.text)
                        const PopupMenuItem<String>(
                          value: 'copy',
                          child: ListTile(
                            leading: Icon(Icons.copy),
                            title: Text('Copy'),
                          ),
                        ),
                      if (groupInfo.groupAdminId == userId)
                        const PopupMenuItem<String>(
                          value: 'pin',
                          child: ListTile(
                            leading: Icon(Icons.push_pin),
                            title: Text('Pin Message'),
                          ),
                        )
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
                groupInfo.setMessageId('');
                groupInfo.setMessageType(MessageEnum.none);
              },
              child: Column(
                children: [
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('groups')
                        .doc(groupInfo.groupId)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      final pinnedMessage =
                          snapshot.data?.get('pinnedMessage') ?? false;

                      return (pinnedMessage != '')
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.push_pin,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        pinnedMessage,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            wordSpacing: -1),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
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
                            )
                          : SizedBox.shrink();
                    },
                  ),
                  Expanded(
                    child: StreamBuilder<List<dynamic>>(
                        stream: widget.isGroupChat
                            ? ref
                                .read(chatControllerProvider)
                                .groupChatStream(widget.uid)
                            : ref
                                .read(chatControllerProvider)
                                .chatStream(widget.uid, userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            //  return   SizedBox.shrink();
                          }

                          groupInfo.clearGroupImageList();
                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final messageData = snapshot.data?[index];

                              if (messageData.type == MessageEnum.image) {
                                groupInfo
                                    .updateGroupImageList(messageData.text);
                              }
                              var timeSent = DateFormat('hh:mm a')
                                  .format(messageData.timeSent.toLocal());

                              if (!messageData.isSeen &&
                                  messageData.recieverid == userId) {
                                ref
                                    .read(chatControllerProvider)
                                    .setChatMessageSeen(
                                      context,
                                      widget.uid,
                                      userId,
                                      messageData.messageId,
                                    );
                              }
                              if (messageData.senderId == userId) {
                                return Stack(
                                  children: [
                                    MyMessageCard(
                                      message: messageData.text,
                                      name: messageData.username,
                                      index: index,
                                      date: timeSent,
                                      type: messageData.type,
                                      repliedText: messageData.repliedMessage,
                                      username: messageData.repliedTo,
                                      repliedMessageType:
                                          messageData.repliedMessageType,
                                      onLeftSwipe: (value) => onMessageSwipe(
                                        messageData.text,
                                        true,
                                        messageData.type,
                                      ),
                                      isSeen: messageData.isSeen,
                                      messageId: messageData.messageId,
                                    ),
                                  ],
                                );
                              }
                              return SenderMessageCard(
                                  index: index,
                                  message: messageData.text,
                                  name: messageData.username,
                                  date: timeSent,
                                  type: messageData.type,
                                  username: messageData.repliedTo,
                                  repliedMessageType:
                                      messageData.repliedMessageType,
                                  onRightSwipe: (value) => onMessageSwipe(
                                        messageData.text,
                                        false,
                                        messageData.type,
                                      ),
                                  repliedText: messageData.repliedMessage,
                                  messageId: messageData.messageId);
                            },
                          );
                        }),
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
                                  onTap: () {
                                    _scrollDown();
                                  },
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
                              onTap: () {
                                _scrollDown();
                              },
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

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    ref.read(messageReplyProvider.state).update(
          (state) => MessageReply(
            message,
            isMe,
            messageEnum,
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
          groupInfo.setMessageId(''),
          groupInfo.setMessageType(MessageEnum.none)
        });
  }

  onTapGroup(BuildContext context, String image, String name) {
    AppNavigator.pushAndStackPage(context,
        page: CommunityInfoScreen(
          profilePic: image,
          name: name,
        ));
  }

  void _scrollDown() {
    // _scrollController.animateTo(
    //   0 ,
    //   duration: const Duration(microseconds: 300),
    //   curve: Curves.easeOut,
    // );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }
}
