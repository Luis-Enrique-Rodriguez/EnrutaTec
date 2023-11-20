import 'package:enrutatec/screens/dashboard_screen.dart';
import 'package:enrutatec/screens/information.dart';
import 'package:enrutatec/screens/login_screen.dart';
import 'package:enrutatec/screens/map_screen.dart';
import 'package:enrutatec/screens/profile_screen.dart';
import 'package:enrutatec/screens/register_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes(){
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => RegisterScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/logout': (BuildContext context) => LoginScreen(),
    '/profile': (BuildContext context) => ProfileScreen(),
    '/information' : (BuildContext context) => InformationScreen(),
    '/mapa': (BuildContext context) => MapsScreen()
  };
}