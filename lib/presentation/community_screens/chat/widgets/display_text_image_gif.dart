import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../../common/enums/message_enum.dart';
import '../../../../common/utils/colors.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final String username;
  final MessageEnum type;
  final bool isMe;
  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
    required this.isMe,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    //final AudioPlayer audioPlayer = AudioPlayer();

    return type == MessageEnum.text
        ? Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: isMe ? Colors.black : Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                ReadMoreText(
                  message,
                  numLines: 8,
                  readMoreText: 'Read more',
                  readLessText: 'Read less',
                  readMoreAlign: AlignmentDirectional.bottomStart,
                  style: TextStyle(
                      wordSpacing: -1,
                      fontSize: 16,
                      color: isMe ? Colors.black : Colors.black),
                ),
              ],
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
            : type == MessageEnum.gif
                ? CachedNetworkImage(
                    imageUrl: message,
                  )
                : CachedNetworkImage(
                    imageUrl: message,
                  );
  }
}
