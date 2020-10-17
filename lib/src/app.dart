library app;

import 'package:flutter/material.dart';

import 'base/base.dart';
import 'screens/splash/splash_screen.dart';

class App extends AppBase {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          AppConfig.instance.flavorName != AppFlavor.PRODUCTION,
      title: 'nBiz',
      navigatorKey: AppConfig.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme(
          primary: Color(0xffFF5C05),
          primaryVariant: Color(0xff212862),
          secondary: Color(0xffF2F2F2),
          secondaryVariant: Color(0xffFFF8F3),
          brightness: Brightness.light,
          error: Colors.red,
          onBackground: Color(0xff060606),
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xff7f7f7f),
          surface: Color(0xffE5E5E5),
          background: Colors.white,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
