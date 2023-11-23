import 'package:enrutatec/routes.dart';
import 'package:enrutatec/screens/dashboard_screen.dart';
import 'package:enrutatec/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../assets/global_values.dart';
import '../assets/styles_app.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges();
  
  runApp(MainApp());
}

class MainApp extends StatefulWidget{
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp>{
  @override
  void initState(){
    super.initState();
    globalValues().readValue();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: globalValues.flagTheme, 
      builder: (context, value, _){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DashboardScreen(), //LoginScreen(),
          routes: getRoutes(),
          theme: value ? StylesApp.darkTheme(context) : StylesApp.lightTheme(context)
        );
      }
    );
  }
}