import 'package:enrutatec/firebase/notifications.dart';
import 'package:enrutatec/routes.dart';
import 'package:enrutatec/screens/dashboard_screen.dart';
import 'package:enrutatec/screens/login_screen.dart';
import 'package:enrutatec/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../assets/global_values.dart';
import '../assets/styles_app.dart';

int? initScreen;
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges();
  await PushNotificationProvider().initializeApp();
  SharedPreferences guardar = await SharedPreferences.getInstance();
  initScreen = await guardar.getInt('initScreen');
  await guardar.setInt('initScreen', 1);
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    globalValues().readValue();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: globalValues.flagTheme,
      builder: (context, value, _) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: OnBoarding(),
            theme: value
                ? StylesApp.darkTheme(context)
                : StylesApp.lightTheme(context),
            initialRoute:
                initScreen == 0 || initScreen == null ? '/onboard' : '/login',
            routes: getRoutes());
      },
    );
  }
}
