import 'package:flutter/widgets.dart';
import 'package:page_route_animator/page_route_animator.dart';

import '../core/constants/routes_constants.dart';
import '../presentation/community_screens/chat/screens/chat_screen.dart';
import '../presentation/community_screens/group/screens/create_group_screen.dart';
import '../presentation/community_screens/group/screens/group_chats_screen.dart';


class AppRouters {
  static Route<PageRouteAnimator>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      
      
      case AppRoutes.chatScreen:
        return PageRouteAnimator(
          child: const ChatScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
       
      
      case AppRoutes.createGroupScreen:
        return PageRouteAnimator(
          child: const CreateGroupScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.groupChatsScreen:
        return PageRouteAnimator(
          child: const GroupChatScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );

      default:
        return PageRouteAnimator(
          child: Container(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
    }
  }
}
