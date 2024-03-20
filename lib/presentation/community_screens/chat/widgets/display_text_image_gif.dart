import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tellesports/utils/loader.dart';
import 'package:tellesports/widgets/modals.dart';

import '../../../../common/enums/message_enum.dart';
import '../repositories/chat_repository.dart';

class DisplayTextImageGIF extends ConsumerStatefulWidget {
  final String message;
  final String username;
  final MessageEnum type;
  final bool isMe;
  DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
    required this.isMe,
    required this.username,
  }) : super(key: key);

  @override
  ConsumerState<DisplayTextImageGIF> createState() => _DisplayTextImageGIFState();
}

class _DisplayTextImageGIFState extends ConsumerState<DisplayTextImageGIF> {
  bool _isMessageSaved = true;

   
   
    

  @override
  void initState() {
 
 
    super.initState();


     
  }

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    

 
       
      // Modals.showToast(user.isMessageSaved.toString());

    return widget.type == MessageEnum.text
        ? Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.username,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: widget.isMe ? Colors.black : Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                ReadMoreText(
                  widget.message,
                  numLines: 8,
                  readMoreText: 'Read more',
                  readLessText: 'Read less',
                  readMoreAlign: AlignmentDirectional.bottomStart,
                  style: TextStyle(
                      wordSpacing: -1,
                      fontSize: 16,
                      color: widget.isMe ? Colors.black : Colors.black),
                ),
              ],
            ),
          )
        : widget.type == MessageEnum.audio
            ? StatefulBuilder(builder: (context, setState) {
                return SizedBox(
                  // height: 20,
                  child: IconButton(
                    constraints: const BoxConstraints(
                      minWidth: 100,
                    ),
                    onPressed: () async {
                      if (isPlaying) {
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
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
            : widget.type == MessageEnum.image
                ?  
                  
                   SizedBox(
                    height: MediaQuery.sizeOf(context).width * 0.6,
                    width: MediaQuery.sizeOf(context).width * 0.77,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.message,
                      ),
                    ),
                  )
                : SizedBox.shrink();
  }
}
