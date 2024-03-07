import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/enums/message_enum.dart';
import '../../../../common/providers/message_reply_provider.dart';
import '../../../../common/utils/utils.dart';
 
import '../../../../core/app_export.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../controller/chat_controller.dart';
import 'message_reply_preview.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const BottomChatField({
    Key? key,
    required this.recieverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
 // FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();

      String userId = '';
  getUserId()async{

userId = await StorageHandler.getUserId() ?? '';
  }

 

  @override
  void initState() {
    super.initState();
   getUserId();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
   //   throw RecordingPermissionException('Mic permission not allowed!');
    }
   // await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.recieverUserId,
            userId,
            widget.isGroupChat,
          );
      setState(() {
        _messageController.text = '';
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        //await _soundRecorder!.stopRecorder();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
      //  await _soundRecorder!.startRecorder(
         // toFile: path,
        //);
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.recieverUserId,
          userId,
          messageEnum,
          widget.isGroupChat,
        );
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  // void selectGIF() async {
  //   final gif = await pickGIF(context);
  //   if (gif != null) {
  //    if(context.mounted){
  //      ref.read(chatControllerProvider).sendGIFMessage(
  //           context,
  //           gif.url,
  //           widget.recieverUserId,
  //           widget.isGroupChat,
  //         );
  //    }
  //   }
  // }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  //  _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(20.h, 9.v, 20.h, 10.v),
      decoration: AppDecoration.outlineGray400,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              selectImage();
            },
            child: CustomImageView(
              imagePath: ImageConstant.imgAttachFile,
              height: 24.adaptSize,
              width: 24.adaptSize,
              margin: EdgeInsets.only(
                top: 5.v,
                bottom: 31.v,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 12.h,
                bottom: 26.v,
              ),
              child: CustomTextFormField(
                focusNode: focusNode,
                controller: _messageController,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  } else {
                    setState(() {
                      isShowSendButton = false;
                    });
                  }
                },
                hintText: "Type a message...",
                hintStyle: CustomTextStyles.titleSmallGray50001,
                textInputAction: TextInputAction.done,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 7.v,
                ),
                borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL17,
                filled: true,
                fillColor: appTheme.gray100,
              ),
            ),
          ),
          GestureDetector(
            onTap: (_messageController.text.isNotEmpty) ? sendTextMessage : null,
            child: CustomImageView(
              imagePath: ImageConstant.imgSend,
              height: 24.adaptSize,
              width: 24.adaptSize,
              margin: EdgeInsets.only(
                left: 12.h,
                top: 5.v,
                bottom: 31.v,
              ),
            ),
          ),
        ],
      ),
    ),
         
        // isShowEmojiContainer
        //     ? SizedBox(
        //         height: 310,
        //         child: EmojiPicker(
        //           onEmojiSelected: ((category, emoji) {
        //             setState(() {
        //               _messageController.text =
        //                   _messageController.text + emoji.emoji;
        //             });

        //             if (!isShowSendButton) {
        //               setState(() {
        //                 isShowSendButton = true;
        //               });
        //             }
        //           }),
        //         ),
        //       )
        //     : const SizedBox(),
      ],
    );
  }
}
