import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pro;
import 'package:tellesports/firebase_options.dart';
import 'package:tellesports/theme/theme_helper.dart';
import 'package:tellesports/routes/app_routes.dart';
import 'package:tellesports/utils/navigator/page_navigator.dart';

import 'model/view_models/account_view_model.dart';
import 'model/view_models/firebase_auth_view_model.dart';
import 'model/view_models/match_viewmodel.dart';
import 'model/view_models/user_view_model.dart';
import 'presentation/community_screens/chat/repositories/chat_repository.dart';
import 'presentation/community_screens/provider/auth_provider.dart';
import 'presentation/firebase_fcm.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// function to lisen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  PushNotifications.init();
  PushNotifications.localNotiInit();
  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    Future.delayed(Duration(seconds: 1), () {
      
      
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(ProviderScope(
    child: pro.MultiProvider(
      providers: [
        pro.ChangeNotifierProvider(
            create: (_) => AccountViewModel(), lazy: false),
        pro.ChangeNotifierProvider(
            create: (_) => MatchViewModel(), lazy: false),
        pro.ChangeNotifierProvider(create: (_) => UserViewModel(), lazy: false),
        pro.ChangeNotifierProvider(
            create: (_) => FirebaseAuthProvider(), lazy: false),
        pro.ChangeNotifierProvider(create: (_) => AuthProviders(), lazy: false),
        pro.ChangeNotifierProvider(
            create: (_) =>
                ChatRepository(firestore: FirebaseFirestore.instance),
            lazy: false),
      ],
      child: TellaSports(),
    ),
  ));
}

class TellaSports extends StatefulWidget {
  @override
  State<TellaSports> createState() => _TellaSportsState();
}

class _TellaSportsState extends State<TellaSports> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'Tellasport',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreenOnboardingScreen,
      routes: AppRoutes.routes,
    );
  }
}
