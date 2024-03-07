import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter/services.dart';

import '../../../../common/utils/colors.dart';
import '../../../../common/widgets/loader.dart';
import '../../../../core/app_export.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../../widgets/app_bar/appbar_subtitle_four.dart';
import '../../../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../../../widgets/app_bar/appbar_title_circleimage.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';
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
  final String groupNumber;
  final String groupDesc;
  const MobileChatScreen(this.groupDesc, this.groupNumber, {
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
        backgroundColor: appTheme.lime50,
        resizeToAvoidBottomInset: false,
        appBar:  CustomAppBar(
          
            height: 84.v,
            leadingWidth: 44.h,
            leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgArrowBackBlue800,
               onTap: (){
                                      groupInfo.isSelectedMessage(false);
                              groupInfo.setSelectedMessage('');
                              groupInfo.setTextIndex(-1);
                              Navigator.pop(context);

                    },
              margin: EdgeInsets.only(
                left: 20.h,
                top: 50.v,
                bottom: 10.v,
              ),
            ),
            title: GestureDetector(
              onTap: () {
                 Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupInfoScreen(
                                    name: widget.name,
                                    profilePic: widget.profilePic,
                                  )));
              },
              child: Padding(
                padding: EdgeInsets.only(
                  left: 12.h,
                  top: 43.v,
                  bottom: 4.v,
                ),
                child: Row(
                  children: [
                    AppbarTitleCircleimage(
                      
                      imagePath:  widget.profilePic,
                      onTap: (){
                  //onTapGroup(context);
              
                            },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.h),
                      child: Column(
                        children: [
                          AppbarSubtitleTwo(
                            text: widget.name,
                            onTap: (){
                  //onTapGroup(context);
              
                            },
                          ),
                          AppbarSubtitleFour(
                            text: "${widget.groupNumber }members",
                            margin: EdgeInsets.only(right: 28.h),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              // AppbarTrailingImage(
              //   imagePath: ImageConstant.imgMoreVert,
              //   margin: EdgeInsets.fromLTRB(20.h, 50.v, 20.h, 10.v),
              // ),
            ],
            styleType: Style.bgOutline,
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
