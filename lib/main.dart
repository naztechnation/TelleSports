import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:tellesports/theme/theme_helper.dart';
import 'package:tellesports/routes/app_routes.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'tellesports',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreenOnboardingScreen,
      routes: AppRoutes.routes,
    );
  }
}
