import 'dart:io';

import 'package:flutter/material.dart';

import '../common/widgets/error.dart';
import '../presentation/community_screens/auth/screens/login_screen.dart';
import '../presentation/community_screens/auth/screens/user_information_screen.dart';
import '../presentation/community_screens/chat/screens/group_info.dart';
import '../presentation/community_screens/chat/screens/mobile_chat_screen.dart';
import '../presentation/community_screens/group/screens/create_group_screen.dart';
import '../presentation/community_screens/select_contacts/screens/select_contacts_screen.dart';

 


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
     
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );
     
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactsScreen(),
      );
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final isGroupChat = arguments['isGroupChat'];
      final profilePic = arguments['profilePic'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          '','',[],
          name: name,
          uid: uid,
          isGroupChat: isGroupChat,
          profilePic: profilePic,
        ),
      );
       case GroupInfoScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final profilePic = arguments['profilePic'];
      return MaterialPageRoute(
        builder: (context) => GroupInfoScreen(
          name: name,
          profilePic: profilePic,
        ),
      );
    
    case CreateGroupScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const CreateGroupScreen(),
      );
      // case UpdateUserProfileScreen.routeName:
      // return MaterialPageRoute(
      //   builder: (context) => const UpdateUserProfileScreen(),
      // );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
