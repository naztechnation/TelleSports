import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter/services.dart';
import 'package:tellesports/widgets/loading_page.dart';

import '../../../../blocs/prediction/prediction.dart';
import '../../../../common/enums/message_enum.dart';
import '../../../../common/providers/message_reply_provider.dart';
import '../../../../core/app_export.dart';
import '../../../../core/constants/enums.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../model/chat_model/group.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../requests/repositories/prediction_repo/predict_repository_impl.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../../utils/validator.dart';
import '../../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../../widgets/app_bar/appbar_subtitle_four.dart';
import '../../../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../../../widgets/app_bar/appbar_title_circleimage.dart';

import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/modal_content.dart';
import '../../../../widgets/modals.dart';

import '../../community_one_page/community_info_page.dart';
import '../../provider/auth_provider.dart' as pro;
import '../../provider/auth_provider.dart';
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
  final List<String> membersUid;
  const MobileChatScreen(
    this.groupDesc,
    this.groupNumber,
    this.membersUid, {
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
  final compaintController = TextEditingController();

  List<Group> usersGroup = [];

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

  String userId = '';

  bool containsId = true;

  final _firebaseMessaging = FirebaseMessaging.instance;

  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 1), () {
        _scrollDown();
      });
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

    if (groupInfo.groupAdminId == userId) {
      updateUserGroupNumber();
    }

    _firebaseMessaging.subscribeToTopic(groupInfo.groupId);

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
        body: BlocProvider<PredictionCubit>(
          lazy: false,
          create: (_) => PredictionCubit(
              predictRepository: PredictRepositoryImpl(),
              viewModel:
                  provider.Provider.of<UserViewModel>(context, listen: false)),
          child: BlocConsumer<PredictionCubit, PredictStates>(
            listener: (context, state) {
              if (state is ReportUserLoaded) {
                if (state.complaint.success ?? false) {
                  Modals.showToast('Complaint submitted successfully',
                      messageType: MessageType.success);
                  compaintController.clear();
                  groupInfo.isSelectedMessage(false);
                  groupInfo.setSelectedMessage('');
                  groupInfo.setTextIndex(-1);
                  groupInfo.setMessageId('');
                  groupInfo.setMessageType(MessageEnum.none);
                } else {
                  Modals.showToast('Failed to submit complaint',
                      messageType: MessageType.error);
                }
              } else if (state is PredictApiErr) {
                if (state.message != null) {
                  Modals.showToast(state.message ?? '',
                      messageType: MessageType.error);
                }
              } else if (state is PredictNetworkErr) {
                if (state.message != null) {
                  Modals.showToast(state.message ?? '',
                      messageType: MessageType.error);
                }
              }
            },
            builder: (context, state) => (state is ReportUserLoading)
                ? LoadingPage()
                : SafeArea(
                    child: Scaffold(
                      backgroundColor: appTheme.lime50,
                      resizeToAvoidBottomInset: false,
                      floatingActionButton: Container(
                        margin: const EdgeInsets.only(bottom: 80),
                        child: FloatingActionButton(
                          backgroundColor: Colors.blue.withOpacity(0.5),
                          mini: false,
                          elevation: 0.0,
                          onPressed: () {
                            _scrollDown();
                          },
                          child: const Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                                  onTapGroup(context, widget.profilePic,
                                      widget.name, widget.membersUid);
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
                                        onTapGroup(context, widget.profilePic,
                                            widget.name, widget.membersUid);
                                      },
                                    ),
                                    AppbarSubtitleFour(
                                      onTap: () {
                                        onTapGroup(context, widget.profilePic,
                                            widget.name, widget.membersUid);
                                      },
                                      text: (widget.groupNumber == '1')
                                          ? "${widget.groupNumber}   Member"
                                          : "${widget.groupNumber}   Members",
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
                                      messageId:
                                          groupInfo.messageId.toString());
                                } else if (choice == 'pin') {
                                  groupInfo.updateGroupPinnedMessage(
                                      groupInfo.groupId,
                                      groupInfo.selectedMessage);
                                } else if (choice == 'copy') {
                                  copyToClipboard(groupInfo.selectedMessage,
                                      groupInfo, context);
                                } else if (choice == 'report') {
                                  compaintController.text =
                                      groupInfo.selectedMessage;
                                  Modals.showDialogModal(context,
                                      page: ModalContentScreen(
                                          title: 'Report this message',
                                          body: Column(
                                            children: [
                                              _buildComplaintField(context)
                                            ],
                                          ),
                                          btnText: 'Submit',
                                          onPressed: () async {
                                            Navigator.pop(context);

                                            await context
                                                .read<PredictionCubit>()
                                                .sendReport(
                                                    complaintType: 'group',
                                                    complaint:
                                                        compaintController.text,
                                                    reportedUser:
                                                        groupInfo.groupName,
                                                    groupId: groupInfo.groupId,
                                                    groupLeaderName: groupInfo
                                                        .groupMembers[0].name,
                                                    groupName:
                                                        groupInfo.groupName);
                                          },
                                          headerColorOne: Color(0xFFFDF9ED),
                                          headerColorTwo: Color(0xFFFAF3DA)));
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
                                  ),
                                if (groupInfo.groupAdminId == userId)
                                  const PopupMenuItem<String>(
                                    value: 'report',
                                    child: ListTile(
                                      leading: Icon(Icons.report),
                                      title: Text('Report'),
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
                                    snapshot.data?.get('pinnedMessage') ??
                                        false;

                                return (pinnedMessage != '')
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                              if (groupInfo.groupAdminId ==
                                                  userId)
                                                GestureDetector(
                                                    onTap: () {
                                                      groupInfo
                                                          .updateGroupPinnedMessage(
                                                              groupInfo.groupId,
                                                              '');
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
                            StreamBuilder<List<dynamic>>(
                                stream: widget.isGroupChat
                                    ? ref
                                        .read(chatControllerProvider)
                                        .groupChatStream(widget.uid)
                                    : ref
                                        .read(chatControllerProvider)
                                        .chatStream(widget.uid, userId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {}

                                  groupInfo.clearGroupImageList();
                                  return Expanded(
                                    child: ListView.builder(
                                      controller: _scrollController,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final messageData =
                                            snapshot.data?[index];

                                        if (messageData.type ==
                                            MessageEnum.image) {
                                          groupInfo.updateGroupImageList(
                                              messageData.text);
                                        }
                                        var timeSent = DateFormat('hh:mm a')
                                            .format(
                                                messageData.timeSent.toLocal());

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
                                          return MyMessageCard(
                                            message: messageData.text,
                                            name: messageData.username,
                                            index: index,
                                            date: timeSent,
                                            type: messageData.type,
                                            repliedText:
                                                messageData.repliedMessage,
                                            username: messageData.repliedTo,
                                            repliedMessageType:
                                                messageData.repliedMessageType,
                                            onLeftSwipe: (value) =>
                                                onMessageSwipe(
                                              messageData.text,
                                              true,
                                              messageData.type,
                                            ),
                                            isSeen: messageData.isSeen,
                                            messageId: messageData.messageId,
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
                                            onRightSwipe: (value) =>
                                                onMessageSwipe(
                                                  messageData.text,
                                                  false,
                                                  messageData.type,
                                                ),
                                            repliedText:
                                                messageData.repliedMessage,
                                            messageId: messageData.messageId);
                                      },
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('groups')
                                    .doc(groupInfo.groupId)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  final isGroupLocked =
                                      snapshot.data?.get('isGroupLocked') ??
                                          false;

                                  List<dynamic> groupMembersId =
                                      snapshot.data?.get('membersUid') ?? [];

                                  List<dynamic> userItem =
                                      removeDuplicates(groupMembersId);

                                  if (userItem.contains(userId)) {
                                    containsId = true;
                                    ;
                                  } else {
                                    containsId = false;

    _firebaseMessaging.subscribeToTopic(groupInfo.groupId);

                                  }

                                  if (isGroupLocked) {
                                    return (groupInfo.groupAdminId == userId)
                                        ? BottomChatField(
                                            onTap: () {
                                              _scrollDown();
                                            },
                                            recieverUserId: widget.uid,
                                            isGroupChat: widget.isGroupChat,
                                            groupName: widget.name,
                                            groupId: groupInfo.groupId,
                                          )
                                        : Container(
                                            height: 60,
                                            color: Colors.grey.shade300,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 0.0),
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
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                  } else if (!containsId) {
                                    return (groupInfo.groupAdminId == userId)
                                        ? BottomChatField(
                                            onTap: () {
                                              _scrollDown();
                                            },
                                            recieverUserId: widget.uid,
                                            isGroupChat: widget.isGroupChat,
                                            groupName: widget.name,
                                            groupId: groupInfo.groupId)
                                        : Container(
                                            height: 60,
                                            color: Colors.grey.shade300,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 0.0),
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
                                                    'you are no longer a member of this group',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                  }

                                  return BottomChatField(
                                    onTap: () {
                                      _scrollDown();
                                    },
                                    recieverUserId: widget.uid,
                                    isGroupChat: widget.isGroupChat,
                                    groupName: widget.name,
                                    groupId: groupInfo.groupId,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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

  onTapGroup(
    BuildContext context,
    String image,
    String name,
    final List<String> membersUid,
  ) {
    AppNavigator.pushAndStackPage(context,
        page: CommunityInfoScreen(
          profilePic: image,
          name: name,
          membersUid: membersUid,
        ));
  }

  void _scrollDown() {
    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent * 2,
    );
  }

  List<String> removeDuplicates(List<dynamic> items) {
    Map<int, String> uniqueItems = {};

    items.forEach((item) {
      if (items.isNotEmpty || items != []) {
        uniqueItems[int.tryParse(item)!] = item;
      }
    });

    return uniqueItems.values.toList();
  }

  Widget _buildComplaintField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Report *", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: compaintController,
              hintText: "Enter your report here",
              hintStyle: CustomTextStyles.titleSmallGray600,
              maxLines: 5,
              readOnly: true,
              textInputType: TextInputType.name,
              validator: (value) {
                return Validator.validate(value, 'Report');
              },
              contentPadding:
                  EdgeInsets.only(left: 8.h, top: 14.v, bottom: 14.v))
        ]));
  }

  updateUserGroupNumber() async {
    usersGroup =
        await provider.Provider.of<AuthProviders>(context, listen: false)
            .getUserGroups1(userId);
    await provider.Provider.of<AuthProviders>(context, listen: false)
        .UpdateGroupCount(userId: userId, groupNumber: usersGroup.length);
  }
}
