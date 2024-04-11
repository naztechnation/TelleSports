import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pro;
import 'package:tellesports/firebase_options.dart'; 
import 'package:tellesports/theme/theme_helper.dart';
import 'package:tellesports/routes/app_routes.dart';

import 'model/view_models/account_view_model.dart';
import 'model/view_models/firebase_auth_view_model.dart';
import 'model/view_models/match_viewmodel.dart';
import 'model/view_models/user_view_model.dart';
import 'presentation/community_screens/chat/repositories/chat_repository.dart';
import 'presentation/community_screens/provider/auth_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'requests/send_notifications.dart';
import 'widgets/modals.dart';




Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
  showFlutterNotification(message);
}

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

bool isFlutterLocalNotificationsInitialized = false;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }


  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@drawable/tella',
        ),
      ),
    );
  }
}




var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  

  _firebaseMessaging.getToken().then((token) async {
    
   _firebaseMessaging.subscribeToTopic('user');

   if(token != null){
     sendFCMMessage(token, 'Topic', 'Welcome sir' );
   }
     
   
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.data != {}) {
      
      Future.delayed(Duration(seconds: 10), () {});
      showFlutterNotification(message);
    }
  });
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
 

   
  runApp(ProviderScope(
    child: pro.MultiProvider(
      providers: [
        pro.ChangeNotifierProvider(create: (_) => AccountViewModel(), lazy: false),
         pro.ChangeNotifierProvider(create: (_) => MatchViewModel(), lazy: false),
         pro.ChangeNotifierProvider(create: (_) => UserViewModel(), lazy: false),
         pro.ChangeNotifierProvider(create: (_) => FirebaseAuthProvider(), lazy: false),
         pro.ChangeNotifierProvider(create: (_) => AuthProviders(), lazy: false),
         pro.ChangeNotifierProvider(create: (_) => ChatRepository(firestore: FirebaseFirestore.instance), lazy: false),
      ], 
      child:   TellaSports(),
    ),
  ));
}

class TellaSports extends StatefulWidget {
  @override
  State<TellaSports> createState() => _TellaSportsState();
}

class _TellaSportsState extends State<TellaSports> with WidgetsBindingObserver{

   String? initialMessage;
  bool _resolved = false;

   @override
  void initState() {
     FirebaseMessaging.instance.getInitialMessage().then(
          (value) => setState(
            () {
              _resolved = true;
              initialMessage = value?.data.toString();
            },
          ),
        );
     

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
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
