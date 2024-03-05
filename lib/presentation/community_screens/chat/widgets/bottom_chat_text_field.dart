import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import '../../../../core/message_type.dart';
import '../../../../core/providers/reply_message_provider.dart';
import '../../../../utils/helper_methods/util_methods.dart';

import '../controllers/chat_controller.dart';
import 'material_icon_button.dart';
import 'pop_up_menu_item.dart';
import 'reply_message_preview.dart';

class BottomChatTextField extends ConsumerStatefulWidget {
  const BottomChatTextField({
    Key? key,
    required this.userId,
    required this.isGroupChat,
  }) : super(key: key);

  final String userId;
  final bool isGroupChat;

  @override
  ConsumerState<BottomChatTextField> createState() =>
      _BottomChatTextFieldState();
}

class _BottomChatTextFieldState extends ConsumerState<BottomChatTextField> {
  late final TextEditingController _messageController;
  late final FocusNode _tfFocusNode;
  bool _isEmojiIconTapped = false;
  double? _keyboardSize;
  bool _isSoundRecorderInitialized = false;
  bool _isAudioRecording = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _tfFocusNode = FocusNode();
    // sound recorder
  }

  @override
  void dispose() {
    _messageController.dispose();
    _isSoundRecorderInitialized = false;
    super.dispose();
  }

   

  @override
  Widget build(BuildContext context) {
    final viewInsets = EdgeInsets.fromWindowPadding(
        WidgetsBinding.instance.window.viewInsets,
        WidgetsBinding.instance.window.devicePixelRatio);
    if (_keyboardSize == null && viewInsets.bottom > 1) {
      _keyboardSize = viewInsets.bottom;
    }

    // check for if the user is replying to message.
    ReplyMessage? replyMessage = ref.watch(replyMessageProvider);
    bool isShowReplyMessage = replyMessage == null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isShowReplyMessage) const ReplyMessagePreview(),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(2, 2),
                      ),
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(-2, -2),
                          blurRadius: 3,
                          spreadRadius: 1),
                    ],
                  ),
                  child: _buildChatTextField(),
                ),
              ),
              SizedBox(height:8.0),
              _buildMicOrSendButton(),
            ],
          ),
          
        ],
      ),
    );
  }

  Widget _buildMicOrSendButton() {
    return FloatingActionButton(
      onPressed:  
           _sendTextMessage,
      child: Icon(
        _messageController.text.isEmpty
            ? _isAudioRecording
                ? Icons.close
                : Icons.mic
            : Icons.send,
        color: Colors.white,
      ),
    );
  }

  Widget _buildChatTextField() {
    return TextField(
      minLines: 1,
      maxLines: 6,
      focusNode: _tfFocusNode,
      onChanged: (value) {
        setState(() {});
      },
      controller: _messageController,
      keyboardType: TextInputType.multiline,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey,
        suffixIconConstraints: const BoxConstraints(),
        prefixIcon: _buildPrefixTFIcon(),
        suffixIcon: _buildSuffixTFIcon(),
        hintText: 'Type a message...',
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: EdgeInsets.only(
          top: 12.0,
          bottom: 12.0,
          left: 16.0,
          right: _messageController.text.isEmpty ? 0 : 16.0,
        ),
      ),
    );
  }

  Widget _buildPrefixTFIcon() {
    return buildMaterialIconButton(
      icon: _isEmojiIconTapped ? Icons.keyboard : Icons.emoji_emotions_outlined,
      onTap: !_isEmojiIconTapped
          ? () {
              _tfFocusNode.unfocus();
              setState(() {
                _isEmojiIconTapped = true;
              });
            }
          : () async {
              setState(() {
                _isEmojiIconTapped = false;
              });

              await Future.delayed(const Duration(milliseconds: 350));
              _tfFocusNode.requestFocus();
            },
    );
  }

  Widget _buildSuffixTFIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Padding(
            padding: _messageController.text.isEmpty
                ? EdgeInsets.zero
                : const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton(
              padding: EdgeInsets.zero,
              itemBuilder: (context) {
                return [
                  buildPopUpMenuItem(
                    Icons.video_collection_rounded,
                    'Send Video',
                    () => _pickAndSendVideo(context),
                  ),
                  buildPopUpMenuItem(
                    Icons.gif,
                    'Send Gif',
                    _pickAndSendGif,
                  ),
                  if (_messageController.text.isNotEmpty)
                    buildPopUpMenuItem(
                      Icons.camera,
                      'Send Image',
                      () => _pickAndSendImage(context),
                    ),
                ];
              },
              child: const Icon(Icons.more_vert),
            ),
          ),
        ),
        if (_messageController.text.isEmpty)
          buildMaterialIconButton(
            icon: Icons.camera,
            onTap: () => _pickAndSendImage(context),
          ),
      ],
    );
  }

  /// invoke to send file as a chat
  void _sendFile(File file, MessageType messageType) {
    ref.watch(chatControllerProvider).sendFileMessage(
          mounted,
          context,
          file: file,
          receiverUserId: widget.userId,
          messageType: messageType,
          groupId: widget.isGroupChat ? widget.userId : null,
          isGroupChat: widget.isGroupChat,
        );
  }

  void _sendTextMessage() {
    ref.watch(chatControllerProvider).sendTextMessage(
          context,
          lastMessage: _messageController.text.trim(),
          receiverUserId: widget.userId,
          groupId: widget.isGroupChat ? widget.userId : null,
          isGroupChat: widget.isGroupChat,
        );
    _messageController.clear();
  }

  void _pickAndSendImage(BuildContext context) async {
    File? imageFile = await pickImageFromGallery(context);
    if (imageFile != null) {
      _sendFile(imageFile, MessageType.image);
    }

    if (_messageController.text.isNotEmpty) {
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  void _pickAndSendVideo(BuildContext context) async {
    File? videoFile = await pickVideoFromGallery(context);
    if (videoFile != null) {
      _sendFile(videoFile, MessageType.video);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  void _pickAndSendGif() async {
    
  }

 
}
