import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tellesports/res/app_strings.dart';
import '../../../../model/chats/user.dart' as  app;
import '../../../../utils/loader.dart';
import '../../../../model/chats/auth_controller.dart';
import '../widgets/messages_list.dart';
import '../widgets/bottom_chat_text_field.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late Map<String, Object> userData;

  @override
  Widget build(BuildContext context) {
    userData =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    return   Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: MessagesList(
              uId: userData[AppStrings.userId] as String,
              isGroupChat: userData[AppStrings.isGroupChat] as bool,
            ),
          ),
          BottomChatTextField(
            userId: userData[AppStrings.userId] as String,
            isGroupChat: userData[AppStrings.isGroupChat] as bool,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leadingWidth: 32.0,
      elevation: 1,
      shadowColor: Colors.white,
      backgroundColor: Colors.green,
      iconTheme: Theme.of(context).iconTheme,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              r'https://images.pexels.com/photos/13728847/pexels-photo-13728847.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            ),
          ),
          SizedBox(height:12.0),
          Expanded(
            child: (userData[AppStrings.isGroupChat] as bool)
                ? Text(
                    userData[AppStrings.username] as String,
                    style:
                        Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                              color: Colors.black38,
                              fontSize: 16.0,
                            ),
                  )
                : StreamBuilder<app.User>(
                    stream:
                        ref.watch(authControllerProvider).getReceiverUserData(
                              userData[AppStrings.userId] as String,
                            ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.name,
                                
                            ),
                            Text(
                              snapshot.data!.isOnline ? 'online' : 'offline',
                              style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Loader();
                      }
                    }),
          ),
        ],
      ),
      actions: [
       
      ],
    );
  }

  void createCall() {
   
  }
}
