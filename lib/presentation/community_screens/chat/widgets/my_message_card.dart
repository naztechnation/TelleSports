import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:tellesports/widgets/modals.dart';

import '../../../../common/enums/message_enum.dart';
import '../../../../common/utils/colors.dart';
import '../../../../widgets/image_view.dart';
import '../../provider/auth_provider.dart';
import 'display_text_image_gif.dart';

class MyMessageCard extends StatefulWidget {
  final int index;
  final String message;
  final String name;
  final String messageId;
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
    required this.messageId,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
    required this.isSeen,
    required this.name,
  }) : super(key: key);

  @override
  State<MyMessageCard> createState() => _MyMessageCardState();
}

class _MyMessageCardState extends State<MyMessageCard> {
  int textIndex = -1;

  double adjustedHeight = 0;

  @override
  Widget build(BuildContext context) {
    final isReplying = widget.repliedText.isNotEmpty;
    final groupInfo = Provider.of<AuthProviders>(context, listen: true);
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double appBarHeight =
        Scaffold.of(context).appBarMaxHeight ?? kToolbarHeight;

    double availableHeight = screenHeight - statusBarHeight - appBarHeight;
    adjustedHeight = availableHeight * 0.57;
    return SwipeTo(
      onLeftSwipe: widget.onLeftSwipe,
      child: Container(
        margin: EdgeInsets.only(
            top: (groupInfo.isSelected && widget.index == groupInfo.textIndex)
                ? 12
                : 8),
        padding: EdgeInsets.only(
            bottom:
                (groupInfo.isSelected && widget.index == groupInfo.textIndex)
                    ? 3
                    : 0),
        decoration: BoxDecoration(
          color: (groupInfo.isSelected && widget.index == groupInfo.textIndex)
              ? Colors.blue.shade100
              : Colors.transparent,
        ),
        width: MediaQuery.sizeOf(context).width,
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 50,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  groupInfo.isSelectedMessage(false);
                  groupInfo.setSelectedMessage('');

                  groupInfo.setTextIndex(-1);
                  groupInfo.setMessageId('');
                  groupInfo.setMessageType(MessageEnum.none);
                });

                if (widget.type == MessageEnum.image) {
                  Modals.showDialogModal(context,
                      page: _showFullImage(context, widget.message));
                }
              },
              onLongPress: () {
                setState(() {
                  groupInfo.isSelectedMessage(true);

                  groupInfo.setSelectedMessage(widget.message);
                  groupInfo.setTextIndex(widget.index);
                  groupInfo.setMessageId(widget.messageId);
                  groupInfo.setMessageType(widget.type);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: messageColor,
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.only(right: 10, left: 0, top: 3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: widget.type == MessageEnum.text
                          ? const EdgeInsets.only(
                              left: 0,
                              right: 0,
                              top: 5,
                              bottom: 0,
                            )
                          : const EdgeInsets.only(
                              left: 5,
                              top: 5,
                              right: 5,
                              bottom: 10,
                            ),
                      child: Column(
                        children: [
                          if (isReplying) ...[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    12,
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

  _showFullImage(BuildContext context, String imageUrl) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: adjustedHeight,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: ImageView.network(
                  height: adjustedHeight,
                  imageUrl,
                  placeholder: 'assets/images/loading.gif',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
