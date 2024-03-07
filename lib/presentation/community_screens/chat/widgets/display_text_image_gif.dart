import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
 

import '../../../../common/enums/message_enum.dart';
import '../../../../common/utils/colors.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;
  final bool isMe;
  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type, required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    //final AudioPlayer audioPlayer = AudioPlayer();

    return type == MessageEnum.text
        ? Align(
          alignment: Alignment.bottomLeft,
          child:  Text(
              message,
              textAlign: TextAlign.start,
              style:   TextStyle(
                fontSize: 16,
                color: isMe ? Colors.white : Colors.black
              ),
            ),
        )
        : type == MessageEnum.audio
            ? StatefulBuilder(builder: (context, setState) {
                return SizedBox(
                  // height: 20,
                  child: IconButton(
                    constraints: const BoxConstraints(
                      minWidth: 100,
                    ),
                    onPressed: () async {
                      if (isPlaying) {
                       // await audioPlayer.pause();
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
                      //  await audioPlayer.play(UrlSource(message));
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause_circle : Icons.play_circle,
                    ),
                  ),
                );
              })
            :  type == MessageEnum.gif
                    ? CachedNetworkImage(
                        imageUrl: message,
                      )
                    : CachedNetworkImage(
                        imageUrl: message,
                      );
  }
}
