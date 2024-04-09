import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tellesports/utils/loader.dart';
import 'package:tellesports/widgets/modals.dart';

import '../../../../common/enums/message_enum.dart';
import '../../../../common/providers/message_reply_provider.dart';
import '../../../../common/utils/utils.dart';

import '../../../../core/app_export.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../controller/chat_controller.dart';
import '../repositories/chat_repository.dart';
import 'message_reply_preview.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  final Function onTap;
  const BottomChatField({
    Key? key,
    required this.onTap,
    required this.recieverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
 
  final TextEditingController _messageController = TextEditingController();
 
  FocusNode focusNode = FocusNode();

  String userId = '';
  getUserId() async {
    userId = await StorageHandler.getUserId() ?? '';
  }

  @override
  void initState() {
    super.initState();
    getUserId();
     
  }

  bool _isUpdating = false;

  

  void sendTextMessage() async {
   
     
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
      widget.onTap();
     
  }

  Future<void> sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) async {
    await ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.recieverUserId,
          userId,
          messageEnum,
          widget.isGroupChat,
        );
  }

  File? image;

  void selectImage() async {
    image = await pickImageFromGallery(context);
    if (image != null) {
      startUpdatingState(Duration(minutes: 2));
     await sendFileMessage(image!, MessageEnum.image);

     widget.onTap();
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  

 

 

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

 

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
   
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.fromLTRB(20.h, 20.v, 20.h, 10.v),
          decoration: AppDecoration.outlineGray400,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (ref.watch(chatRepositoryProvider).isMessageSaved) ...[
                Container(
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                  margin: EdgeInsets.only(
                    top: 5.v,
                    bottom: 20.v,
                  ),
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              ] else ...[
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
                      bottom: 20.v,
                    ),
                  ),
                ),
              ],
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 12.h,
                    bottom: 6.v,
                  ),
                  child: CustomTextFormField(
                    focusNode: focusNode,
                    controller: _messageController,
                    onChanged: (val) {
                      
                    },
                    hintText: "Type a message...",
                    hintStyle: CustomTextStyles.titleSmallGray50001,
                    textInputAction: TextInputAction.done,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8.h,
                      vertical: 7.v,
                    ),
                    borderDecoration:
                        TextFormFieldStyleHelper.outlineBlueGrayTL17,
                    filled: true,
                    fillColor: appTheme.gray100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    
                  });
                  if (_messageController.text.isNotEmpty) {
                    sendTextMessage();
                    
                  }
                  ;
                },
                child: CustomImageView(
                  imagePath: ImageConstant.imgSend,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  margin: EdgeInsets.only(
                    left: 12.h,
                    top: 5.v,
                    bottom: 20.v,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void startUpdatingState(Duration duration) {
    setState(() {
      _isUpdating = true;
    });

     

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});

      if (duration <= Duration.zero) {
        timer.cancel();
        setState(() {
          _isUpdating = false;
        });
      } else {
        duration -= Duration(seconds: 1);
      }
    });
  }
}
