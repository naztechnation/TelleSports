import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../common/enums/message_enum.dart';
import '../../../../common/utils/colors.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/modals.dart';
import '../../provider/auth_provider.dart';
import 'display_text_image_gif.dart';

class SenderMessageCard extends StatefulWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.messageId,
    
    required this.type,
    required this.onRightSwipe,
    required this.repliedText,
    required this.username,
    required this.index,

    required this.repliedMessageType, required this.name,
  }) : super(key: key);
  final int index;

  final String message;
  final String messageId;
  final String date;
  final MessageEnum type;
  final String name;

  final Function(dynamic value) onRightSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;

  @override
  State<SenderMessageCard> createState() => _SenderMessageCardState();
}

class _SenderMessageCardState extends State<SenderMessageCard> {
  int textIndex = -1;

  double adjustedHeight = 0;

  @override
  Widget build(BuildContext context) {
    final isReplying = widget.repliedText.isNotEmpty;

    final groupInfo = Provider.of<AuthProviders>(context, listen: true);

    double screenHeight = MediaQuery.of(context).size.height;
double statusBarHeight = MediaQuery.of(context).padding.top;
double appBarHeight = Scaffold.of(context).appBarMaxHeight ?? kToolbarHeight;

double availableHeight = screenHeight - statusBarHeight - appBarHeight;
 adjustedHeight = availableHeight * 0.57;
    return SwipeTo(
      onRightSwipe: widget.onRightSwipe,
      child: Container(
         margin: EdgeInsets.only(top: (groupInfo.isSelected && widget.index == groupInfo.textIndex) ? 12 : 8),
        padding: EdgeInsets.only(bottom: (groupInfo.isSelected && widget.index == groupInfo.textIndex) ? 3 : 0),
        decoration: BoxDecoration(
          color: (groupInfo.isSelected && widget.index == groupInfo.textIndex) ? Colors.blue.shade100 : Colors.transparent,
        ),
        width: MediaQuery.sizeOf(context).width,
        child: Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,
            ),
            child: GestureDetector(
              onTap: () {
                  setState(() {
                    groupInfo.isSelectedMessage(false);
                    groupInfo.setSelectedMessage('');
                      
                     groupInfo.setTextIndex(-1) ;
                     groupInfo.setMessageId('') ;
                     groupInfo.setMessageType(MessageEnum.none) ;
        
                  });

                   if(widget.type  ==  MessageEnum.image){

                  Modals.showDialogModal(context,page: _showFullImage(context, widget.message))

                  ;
                }
                },
                onLongPress: () {
                  setState(() {
                    groupInfo.isSelectedMessage(true);
        
                    groupInfo.setSelectedMessage(widget.message);
                     groupInfo.setTextIndex(widget.index) ;
                     groupInfo.setMessageId(widget.messageId) ;
                     groupInfo.setMessageType(widget.type) ;

        
                  });
                },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: senderMessageColor,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                margin: EdgeInsets.only(
                    left: 20,
                    top: 3),
                child: Column(
                  children: [
                    Padding(
                      padding: widget.type == MessageEnum.text
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
                              bottom: 10,
                            ),
                      child: Column(
                        children: [
                          if (isReplying) ...[
                            Text(
                              widget.username,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    5,
                                  ),
                                ),
                              ),
                              child: DisplayTextImageGIF(
                                    isMe: false,
                                    username: widget.name,
              
                                message: widget.repliedText,
                                type: widget.repliedMessageType,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          DisplayTextImageGIF(
                                    isMe: false,
                                    username:  widget.name,
              
                            message: widget.message,
                            type: widget.type,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.date,
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
        ),
      ),
    );
  }

  _showFullImage(BuildContext context, String imageUrl) {
 return  GestureDetector(
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
                        width: MediaQuery.sizeOf(context).width,
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
