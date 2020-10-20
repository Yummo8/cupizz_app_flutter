library app;

import 'package:cubizz_app/src/components/theme/theme.controller.dart';
import 'package:cubizz_app/src/components/theme/theme.model.dart';
import 'package:cubizz_app/src/screens/login/login_screen.dart';
import 'package:cubizz_app/src/widgets/customs/custom_theme.dart';
import 'package:cubizz_app/src/widgets/indicators/loading_indicator.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:momentum/momentum.dart';

import 'base/base.dart';

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
      appLoader: LoadingIndicator(),
      child: _MyApp(),
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
          final theme = snapshot<ThemeModel>().controller.selectedTheme();
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
