import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/reply_message_provider.dart'; 
import 'display_message.dart';

class ReplyMessagePreview extends ConsumerWidget {
  const ReplyMessagePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ReplyMessage? replyMessage = ref.read(replyMessageProvider);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: replyMessage!.isMe ? Colors.green : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  replyMessage.isMe ? 'Me' : 'Opposite',
                  style: replyMessage.isMe
                      ? Theme.of(context).textTheme.headlineSmall
                      : Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.black),
                ),
              ),
              IconButton(
                onPressed: () => _cancelReply(ref),
                icon: Icon(
                  Icons.close,
                  color: replyMessage.isMe ? Colors.white : Colors.black,
                ),
              )
            ],
          ),
          SizedBox(height:8.0),
          DisplayMessage(
            message: replyMessage.message,
            messageType: replyMessage.messageType,
            isSender: replyMessage.isMe,
          ),
        ],
      ),
    );
  }

  void _cancelReply(WidgetRef ref) {
    ref.read(replyMessageProvider.state).state = null;
  }
}
