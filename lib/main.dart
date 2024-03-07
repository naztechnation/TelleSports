import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pro;
import 'package:tellesports/firebase_options.dart'; 
import 'package:tellesports/theme/theme_helper.dart';
import 'package:tellesports/routes/app_routes.dart';

import 'model/view_models/account_view_model.dart';
import 'model/view_models/firebase_auth_view_model.dart';
import 'model/view_models/user_view_model.dart';
import 'presentation/community_screens/provider/auth_provider.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
 

   
  runApp(ProviderScope(
    child: pro.MultiProvider(
      providers: [
        pro.ChangeNotifierProvider(create: (_) => AccountViewModel(), lazy: false),
        // ChangeNotifierProvider(create: (_) => ServiceProviderViewModel(), lazy: false),
         pro.ChangeNotifierProvider(create: (_) => UserViewModel(), lazy: false),
         pro.ChangeNotifierProvider(create: (_) => FirebaseAuthProvider(), lazy: false),
         pro.ChangeNotifierProvider(create: (_) => AuthProviders(), lazy: false),
      ], 
      child:   TellaSports(),
    ),
  ));
}

class TellaSports extends StatelessWidget {
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
