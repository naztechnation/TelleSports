import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tellesports/widgets/modals.dart';

import '../../../../common/enums/message_enum.dart';
import '../../../../common/providers/message_reply_provider.dart';
import '../../../../common/widgets/loader.dart';
import '../../../../handlers/secure_handler.dart';
import '../../provider/auth_provider.dart' as pro;
import '../controller/chat_controller.dart';
import 'my_message_card.dart';
import 'sender_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const ChatList({
    Key? key,
    required this.recieverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
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

  String userId = '';
  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
  }

  List<String> groupImages = [];

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    final groupInfo =
        provider.Provider.of<pro.AuthProviders>(context, listen: true);

    return StreamBuilder<List<dynamic>>(
        stream: widget.isGroupChat
            ? ref
                .read(chatControllerProvider)
                .groupChatStream(widget.recieverUserId)
            : ref
                .read(chatControllerProvider)
                .chatStream(widget.recieverUserId, userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //  return   SizedBox.shrink();
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
         
          });
          groupInfo.clearGroupImageList();
          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final messageData = snapshot.data?[index];

              if (messageData.type == MessageEnum.image) {
                groupInfo.updateGroupImageList(messageData.text);
              }
              var timeSent =
                  DateFormat('hh:mm a').format(messageData.timeSent.toLocal());

              if (!messageData.isSeen && messageData.recieverid == userId) {
                ref.read(chatControllerProvider).setChatMessageSeen(
                      context,
                      widget.recieverUserId,
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
                      repliedMessageType: messageData.repliedMessageType,
                      onLeftSwipe: (value) => onMessageSwipe(
                        messageData.text,
                        true,
                        messageData.type,
                      ),
                      isSeen: messageData.isSeen,
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
                repliedMessageType: messageData.repliedMessageType,
                onRightSwipe: (value) => onMessageSwipe(
                  messageData.text,
                  false,
                  messageData.type,
                ),
                repliedText: messageData.repliedMessage,
              );
            },
          );
        });
  }
}
