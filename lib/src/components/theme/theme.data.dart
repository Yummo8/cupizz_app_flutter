import 'package:flutter/material.dart';

final indigoPinkLight = ThemeData(
  primaryColor: Colors.indigo,
  accentColor: Colors.pink,
  colorScheme: ColorScheme.light(
    primary: Colors.indigo,
    primaryVariant: Colors.indigoAccent,
    secondary: Colors.pink,
    secondaryVariant: Colors.pinkAccent,
  ),
);

final indigoPinkDark = ThemeData(
  primaryColor: Colors.indigo,
  accentColor: Colors.pink,
  colorScheme: ColorScheme.dark(
    primary: Colors.indigo,
    primaryVariant: Colors.indigoAccent,
    secondary: Colors.pink,
    secondaryVariant: Colors.pinkAccent,
  ),
);

final tealPurpleLight = ThemeData(
  primaryColor: Colors.teal,
  accentColor: Colors.purple,
  colorScheme: ColorScheme.light(
    primary: Colors.teal,
    primaryVariant: Colors.tealAccent,
    secondary: Colors.purple,
    secondaryVariant: Colors.purpleAccent,
  ),
);

final tealPurpleDark = ThemeData(
  primaryColor: Colors.teal,
  accentColor: Colors.purple,
  colorScheme: ColorScheme.dark(
    primary: Colors.teal,
    primaryVariant: Colors.tealAccent,
    secondary: Colors.purple,
    secondaryVariant: Colors.purpleAccent,
  ),
);
