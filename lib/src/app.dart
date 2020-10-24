library app;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cubizz_app/src/components/theme/theme.controller.dart';
import 'package:cubizz_app/src/components/theme/theme.model.dart';
import 'package:cubizz_app/src/screens/login/login_screen.dart';
import 'package:cubizz_app/src/widgets/customs/custom_theme.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:momentum/momentum.dart';

import 'base/base.dart';
import 'components/theme/theme.data.dart';

class App extends AppBase {
  @override
  Widget build(BuildContext context) {
    return Momentum(
      controllers: [ThemeController()],
      services: [
        Router([
          LoginScreen(),
        ])
      ],
      minimumBootstrapTime: 3550,
      appLoader: AppLoader(),
      child: _MyApp(),
    );
  }
}

class AppLoader extends StatelessWidget {
  const AppLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AvatarGlow(
            endRadius: 60.0,
            glowColor: indigoPinkLight.primaryColor,
            duration: Duration(milliseconds: 1000),
            repeatPauseDuration: Duration(milliseconds: 100),
            child: SpinKitPumpingHeart(
              color: indigoPinkLight.colorScheme.primaryVariant,
            ),
          ),
          SizedBox(
            width: 250.0,
            child: ColorizeAnimatedTextKit(
              text: [
                "Cubizz",
                "Loading...",
              ],
              textStyle: TextStyle(
                fontSize: 30.0,
                fontFamily: "Horizon",
                color: indigoPinkLight.primaryColor,
              ),
              colors: [
                indigoPinkLight.primaryColor,
                Colors.purple,
                Colors.blue,
                Colors.yellow,
                Colors.red,
              ],
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.topStart,
            ),
          )
        ],
      ),
    );
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [ThemeController],
        builder: (context, snapshot) {
          final theme = snapshot<ThemeModel>().controller.selectedTheme;
          return CustomTheme(
            theme: theme,
            child: MaterialApp(
              debugShowCheckedModeBanner:
                  AppConfig.instance.flavorName != AppFlavor.PRODUCTION,
              title: 'Cubizz',
              navigatorKey: AppConfig.navigatorKey,
              theme: theme,
              home: Router.getActivePage(context),
            ),
          );
        });
  }
}
