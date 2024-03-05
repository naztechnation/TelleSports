import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/message_type.dart';
 

class DisplayMessage extends StatelessWidget {
  const DisplayMessage({
    super.key,
    required this.message,
    required this.messageType,
    required this.isSender,
  });
  final String message;
  final MessageType messageType;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return getMessage(context);
  }

  Widget getMessage(BuildContext context) {
    switch (messageType) {
      case MessageType.text:
        return Text(
          textAlign: TextAlign.left,
          message,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isSender ?  Colors.white :   Colors.black,
              ),
        );
      case MessageType.image:
        return CachedNetworkImage(imageUrl: message);
      
       
      default:
        return Text(
          textAlign: TextAlign.left,
          message,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isSender ?  Colors.white :  Colors.black,
              ),
        );
    }
  }
}
