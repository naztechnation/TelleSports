import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../common/enums/message_enum.dart';
import '../../../../common/utils/colors.dart'; 
import '../../provider/auth_provider.dart';
import 'display_text_image_gif.dart';

class MyMessageCard extends StatefulWidget {
  final int index;
  final String message;
  final String name;
  final String date;
  final MessageEnum type;
  final Function(dynamic value) onLeftSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;
  final bool isSeen;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.index,
    required this.date,
    required this.type,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
    required this.isSeen, required this.name,
  }) : super(key: key);

  @override
  State<MyMessageCard> createState() => _MyMessageCardState();
}

class _MyMessageCardState extends State<MyMessageCard> {

  int textIndex = -1;
  

  @override
  Widget build(BuildContext context) {
    final isReplying = widget.repliedText.isNotEmpty;
    final groupInfo = Provider.of<AuthProviders>(context, listen: true);

    return SwipeTo(
      onLeftSwipe: widget.onLeftSwipe,
      child: Container(
        margin: EdgeInsets.only(top: (groupInfo.isSelected && widget.index == groupInfo.textIndex) ? 12 : 8),
        padding: EdgeInsets.only(bottom: (groupInfo.isSelected && widget.index == groupInfo.textIndex) ? 3 : 0),
        decoration: BoxDecoration(
          color: (groupInfo.isSelected && widget.index == groupInfo.textIndex) ? Colors.blue.shade100 : Colors.transparent,
        ),
        width: MediaQuery.sizeOf(context).width,
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 40,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  groupInfo.isSelectedMessage(false);
                  groupInfo.setSelectedMessage('');
                    
                   groupInfo.setTextIndex(-1) ;

                });
              },
              onLongPress: () {
                setState(() {
                  groupInfo.isSelectedMessage(true);

                  groupInfo.setSelectedMessage(widget.message);
                   groupInfo.setTextIndex(widget.index) ;

                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: messageColor,
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.only(
                    right: 20,
                    left: MediaQuery.of(context).size.width * 0.2,
                    top: 3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: widget.type == MessageEnum.text
                          ? const EdgeInsets.only(
                              left: 10,
                              right: 30,
                              top: 5,
                              bottom: 0,
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
                              widget.username,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: backgroundColor.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    4,
                                  ),
                                ),
                              ),
                              child: DisplayTextImageGIF(
                                isMe: true,
                                message: widget.repliedText,
                                username: widget.name,
                                type: widget.repliedMessageType,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          DisplayTextImageGIF(
                                isMe: true,
                                username: widget.name,

                            message: widget.message,
                            
                            type: widget.type,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.date,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white60,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          widget.isSeen ? Icons.done_all : Icons.done,
                          size: 20,
                          color: widget.isSeen ? Colors.green : Colors.white60,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
