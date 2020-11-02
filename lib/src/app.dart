library app;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cupizz_app/src/screens/main/main_screen.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momentum/momentum.dart';

import 'base/base.dart';
import 'components/auth/index.dart';
import 'components/theme/index.dart';
import 'components/theme/theme.data.dart';
import 'screens/auth/index.dart';
import 'screens/main/home_screen.dart';
import 'services/index.dart';
import 'widgets/index.dart';

class App extends AppBase {
  @override
  Widget build(BuildContext context) {
    return Momentum(
      key: UniqueKey(),
      maxTimeTravelSteps: 200,
      controllers: [
        ThemeController(),
        AuthController(),
      ],
      services: [
        Router([
          LoginScreen(),
          RegisterScreen(),
          MainScreen(),
        ]),
        StorageService(),
        AuthService(),
        GraphqlService(),
      ],
      appLoader: AppLoader(),
      child: _MyApp(),
      persistSave: (context, key, value) async {
        await FlutterSecureStorage().write(key: key, value: value);
        return true;
      },
      persistGet: (context, key) async {
        return await FlutterSecureStorage().read(key: key);
      },
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
            child: LoadingIndicator(
              color: indigoPinkLight.colorScheme.primaryVariant,
            ),
          ),
          SizedBox(
            width: 250.0,
            child: ColorizeAnimatedTextKit(
              text: [
                "Cupizz",
                "Loading...",
              ],
              repeatForever: true,
              textStyle: GoogleFonts.pacifico(
                fontSize: 30.0,
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
        controllers: [ThemeController, AuthController],
        builder: (context, snapshot) {
          final theme = snapshot<ThemeModel>().controller.selectedTheme;
          return CustomTheme(
            theme: theme,
            child: MaterialApp(
              debugShowCheckedModeBanner:
                  AppConfig.instance.flavorName != AppFlavor.PRODUCTION,
              title: 'Cupizz',
              navigatorKey: AppConfig.navigatorKey,
              theme: theme,
              home: Router.getActivePage(context),
            ),
          );
        });
  }
}
