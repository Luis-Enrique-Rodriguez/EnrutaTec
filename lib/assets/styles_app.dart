import 'package:flutter/material.dart';

class StylesApp{
  static ThemeData lightTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 12, 144, 221),
        
      )
    );
  }

static ThemeData darkTheme(BuildContext context){
    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 10, 10, 0),
        
      )
    );
  }
  
}