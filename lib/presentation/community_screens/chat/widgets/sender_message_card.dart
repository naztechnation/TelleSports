import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../common/enums/message_enum.dart';
import '../../../../common/utils/colors.dart';
import 'display_text_image_gif.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    
    required this.type,
    required this.onRightSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType, required this.name,
  }) : super(key: key);
  final String message;
  final String date;
  final MessageEnum type;
  final String name;

  final Function(dynamic value) onRightSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;

  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;

    return SwipeTo(
      onRightSwipe: onRightSwipe,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: senderMessageColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            margin: EdgeInsets.only(
                left: 20,
                right: MediaQuery.of(context).size.width * 0.2,
                top: 12),
            child: Column(
              children: [
                Padding(
                  padding: type == MessageEnum.text
                      ? const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 10,
                        )
                      : const EdgeInsets.only(
                          left: 5,
                          top: 5,
                          right: 5,
                          bottom: 25,
                        ),
                  child: Column(
                    children: [
                      if (isReplying) ...[
                        Text(
                          username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(0.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                5,
                              ),
                            ),
                          ),
                          child: DisplayTextImageGIF(
                                isMe: false,
                                username: name,

                            message: repliedText,
                            type: repliedMessageType,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      DisplayTextImageGIF(
                                isMe: false,
                                username:  name,

                        message: message,
                        type: type,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
