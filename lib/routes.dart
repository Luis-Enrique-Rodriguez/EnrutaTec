import 'package:enrutatec/screens/dashboard_screen.dart';
import 'package:enrutatec/screens/register_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes(){
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => RegisterScreen(),
    '/dash': (BuildContext context) => DashboardScreen() 
  };
}