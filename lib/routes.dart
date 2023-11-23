import 'package:enrutatec/screens/dashboard_screen.dart';
import 'package:enrutatec/screens/editprofile.dart';
import 'package:enrutatec/screens/information.dart';
import 'package:enrutatec/screens/login_screen.dart';
import 'package:enrutatec/screens/map_screen.dart';
import 'package:enrutatec/screens/map_screen_pinos.dart';
import 'package:enrutatec/screens/map_screen_snjose.dart';
import 'package:enrutatec/screens/profile_screen.dart';
import 'package:enrutatec/screens/register_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => RegisterScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/logout': (BuildContext context) => LoginScreen(),
    '/profile': (BuildContext context) => ProfileScreen(),
    '/information': (BuildContext context) => InformationScreen(),
    '/43': (BuildContext context) => MapsScreen(),
    '/60': (BuildContext context) => MapScreenPinos(),
    '/23': (BuildContext context) => MapScreenSanJose(),
    '/login': (BuildContext context) => LoginScreen(),
    //'/settings': (BuildContext context) => EditProfile(),
  };
}
