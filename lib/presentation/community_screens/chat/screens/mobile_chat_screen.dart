import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter/services.dart';

import '../../../../common/utils/colors.dart';
import '../../../../common/widgets/loader.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../widgets/modals.dart'; 
import '../../auth/controller/auth_controller.dart';
 
import '../../provider/auth_provider.dart' as pro;
import '../widgets/bottom_chat_field.dart';
import '../widgets/chat_list.dart';
import 'group_info.dart';

class MobileChatScreen extends ConsumerStatefulWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MobileChatScreenState();
}

class _MobileChatScreenState extends ConsumerState<MobileChatScreen> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    final groupInfo = provider.Provider.of<pro.AuthProviders>(context, listen: true);

    groupInfo.isSelectedMessage(false);
    groupInfo.setSelectedMessage('');
    groupInfo.setTextIndex(-1);
    messageController.dispose();
  }

  void makeCall(WidgetRef ref, BuildContext context) {
    // ref.read(callControllerProvider).makeCall(
    //       context,
    //       widget.name,
    //       widget.uid,
    //       widget.profilePic,
    //       widget.isGroupChat,
    //     );
  }

     String userId = '';
  getUserId()async{

userId = await StorageHandler.getUserId() ?? '';
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final groupInfo = provider.Provider.of<pro.AuthProviders>(context, listen: true);

    return  WillPopScope(
        onWillPop: () async {
          groupInfo.isSelectedMessage(false);
          groupInfo.setSelectedMessage('');
          groupInfo.setTextIndex(-1);
          Navigator.pop(context);

          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: appBarColor,
            title: widget.isGroupChat
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupInfoScreen(
                                    name: widget.name,
                                    profilePic: widget.profilePic,
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              groupInfo.isSelectedMessage(false);
                              groupInfo.setSelectedMessage('');
                              groupInfo.setTextIndex(-1);
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back)),
                        const SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            widget.profilePic,
                          ),
                          radius: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text(
                          widget.name,
                          style: const TextStyle(fontSize: 16),
                        )),
                      ],
                    ),
                  )
                : StreamBuilder<dynamic>(
                    stream: ref
                        .read(authControllerProvider)
                        .userDataById(widget.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Loader();
                      }
                      return Column(
                        children: [
                          Text(widget.name),
                          Text(
                            snapshot.data!.isOnline ? 'online' : 'offline',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      );
                    }),
            centerTitle: false,
            actions: [
              // IconButton(
              //   onPressed: () => makeCall(ref, context),
              //   icon: const Icon(Icons.video_call),
              // ),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.call),
              // ),
              if (groupInfo.selectedMessage != '')
                PopupMenuButton(
                  onSelected: (result) {
                    // Navigator.of(context);
                  },
                  itemBuilder: (context) => [
                 if (groupInfo.groupAdminId ==
                              userId)   PopupMenuItem(
                      value: 1,
                      child: GestureDetector(
                          onTap: () {
                            groupInfo.updateGroupPinnedChat(
                                groupInfo.groupId, groupInfo.selectedMessage);
                          },
                          child: const Text("Pin Message")),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: GestureDetector(
                          onTap: () {
                            copyToClipboard(
                                groupInfo.selectedMessage.toString(),
                                groupInfo,
                                context);
                          },
                          child: const Text("Copy")),
                    ),
                  ],
                ),
            ],
          ),
          body: GestureDetector(
            onTap: () {
              groupInfo.isSelectedMessage(false);
              groupInfo.setSelectedMessage('');
              groupInfo.setTextIndex(-1);
            },
            child: Column(
              children: [
                if (groupInfo.groupPinnedMessage != '')
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            groupInfo.groupPinnedMessage,
                            style: const TextStyle(color: Colors.black),
                          ),
                          const Spacer(),
                          if (groupInfo.groupAdminId ==
                              userId)
                            GestureDetector(
                                onTap: () {
                                  groupInfo.updateGroupPinnedChat(
                                      groupInfo.groupId, '');
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ))
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: ChatList(
                    recieverUserId: widget.uid,
                    isGroupChat: widget.isGroupChat,
                  ),
                ),
                if (groupInfo.isGroupLocked) ...[
                  (groupInfo.groupAdminId ==
                          userId)
                      ? BottomChatField(
                          recieverUserId: widget.uid,
                          isGroupChat: widget.isGroupChat,
                        )
                      : const Padding(
                          padding: EdgeInsets.only(bottom: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'only admins can send messages here',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                ] else ...[
                  BottomChatField(
                    recieverUserId: widget.uid,
                    isGroupChat: widget.isGroupChat,
                  )
                ]
              ],
            ),
          ),
        ),
       
    );
  }

  Future<void> copyToClipboard(
      String text, var groupInfo, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text)).then((value) => {
          Modals.showToast('Message copied'),
          groupInfo.isSelectedMessage(false),
          groupInfo.setSelectedMessage(''),
          groupInfo.setTextIndex(-1),
          Navigator.pop(context),
        });
  }
}
