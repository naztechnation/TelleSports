import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';
import 'package:url_launcher/url_launcher.dart';
 

import '../../../../common/enums/message_enum.dart';
import '../../../../widgets/modals.dart';
import '../../community_one_page/verify_community_existence.dart';

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
 void _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch ${link.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
     

 
       

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
                Linkify(
          onOpen: (i){
            if(containsTelesportCommunity(i.url)){
              AppNavigator.pushAndStackPage(context, page: VerifyCommunityExistence(extractPath(i.url)));
            }else{
              _onOpen(i);
            }
          },
          text:widget.message,
          
          style: TextStyle(fontSize: 16.0),
          linkStyle: TextStyle(color: Colors.blue, decorationColor: Colors.blue),
        ),
                // ReadMoreText(
                //   widget.message,
                //   numLines: 8,
                //   readMoreText: 'Read more',
                //   readLessText: 'Read less',
                //   readMoreAlign: AlignmentDirectional.bottomStart,
                //   style: TextStyle(
                //       wordSpacing: -1,
                //       fontSize: 16,
                //       color: widget.isMe ? Colors.black : Colors.black),
                // ),
              ],
            ),
          )
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

  bool containsTelesportCommunity(String url) {
  final Uri uri = Uri.parse(url);
  return uri.host.contains('tellasportcommunity.com');
}

String extractPath(String url) {
  try {
    final Uri uri = Uri.parse(url);
    String path = uri.path;
    if (path.startsWith('/')) {
      path = path.substring(1);  
    }
     
    return path;
  } catch (e) {
    print('Error parsing URL: $e');
    return '';
  }
}
}
