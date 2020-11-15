library app;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cupizz_app/src/screens/main/main_screen.dart';
import 'package:cupizz_app/src/screens/messages/messages_screen.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'base/base.dart';
import 'screens/auth/index.dart';
import 'screens/main/components/main_screen.controller.dart';
import 'services/index.dart';
import 'widgets/index.dart';

Momentum momentum({bool isTesting = false}) {
  return Momentum(
    key: UniqueKey(),
    maxTimeTravelSteps: 200,
    controllers: [
      ThemeController(),
      AuthController(),
      CurrentUserController(),
      RecommendableUsersController()..config(lazy: true),
      MainScreenController(),
    ],
    services: [
      RouterService([
        LoginScreen(),
        RegisterScreen(),
        MainScreen(),
        MessagesScreen(),
      ]),
      StorageService(isTesting: isTesting),
      AuthService(),
      GraphqlService(
        !isTesting
            ? AppConfig.instance.apiUrl
            : 'http://cupizz.cf/graphql', //192.168.1.242:2020
      ),
      UserService(),
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

class App extends AppBase {
  @override
  Widget build(BuildContext context) {
    return momentum();
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
  final bool isTesting;

  const _MyApp({Key key, this.isTesting = false}) : super(key: key);
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
              title: 'Cupizz',
              navigatorKey: isTesting ? null : AppConfig.navigatorKey,
              theme: theme,
              home: RouterService.getActivePage(context),
            ),
          );
        });
  }
}
