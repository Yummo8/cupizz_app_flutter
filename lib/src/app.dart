library app;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cupizz_app/src/components/location/location.controller.dart';
import 'package:cupizz_app/src/screens/answer_question/answer_question_screen.dart';
import 'package:cupizz_app/src/screens/answer_question/edit_answer_screen.dart';
import 'package:cupizz_app/src/screens/main/pages/friend_v2/friend_page_v2.dart';
import 'package:cupizz_app/src/screens/main/pages/post/components/post_page.controller.dart';
import 'package:cupizz_app/src/screens/select_question/select_question_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/base.dart';
import 'screens/main/components/main_screen.controller.dart';
import 'screens/main/pages/chat/chat_page.dart';
import 'screens/main/pages/friend/friend_page.dart';
import 'screens/messages/messages_screen.dart';
import 'services/index.dart';
import 'widgets/index.dart';

Momentum momentum({bool isTesting = false}) {
  return Momentum(
    key: UniqueKey(),
    maxTimeTravelSteps: 200,
    restartCallback: () {
      runApp(AppConfig.instance.copyWith(child: App()));
    },
    controllers: [
      LocationController()..config(lazy: true),
      AnswerQuestionScreenController()..config(lazy: true),
      AuthController(),
      CurrentUserController(),
      ChatPageController()..config(lazy: true),
      EditAnswerScreenController()..config(lazy: true),
      ForgotController(),
      FriendPageController()..config(lazy: true),
      FriendPageV2Controller()..config(lazy: true),
      HobbyListController()..config(lazy: true),
      MainScreenController(),
      MessagesScreenController(),
      RecommendableUsersController()..config(lazy: true),
      ThemeController(),
      UserScreenController(),
      SelectQuestionScreenController(),
      SystemController(),
      PostPageController()..config(lazy: true),
      CreatePostController()..config(lazy: true),
    ],
    appLoader: AppLoader(),
    child: _MyApp(),
    persistSave: (context, key, value) async {
      final box = await Hive.openBox('cupizz');
      await box.put(key, value);
      return true;
    },
    persistGet: (context, key) async {
      final box = await Hive.openBox('cupizz');
      return box.get(key);
    },
  );
}

class App extends AppBase {
  @override
  Widget build(BuildContext context) {
    initServices();
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
                'Cupizz',
                'Loading...',
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

  _MyApp({Key key, this.isTesting = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [ThemeController, AuthController],
        builder: (context, snapshot) {
          final theme =
              snapshot<ThemeModel>().controller.selectedTheme.copyWith(
                      pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  }));
          return GetMaterialApp(
            debugShowCheckedModeBanner:
                AppConfig.instance.flavorName != AppFlavor.PRODUCTION,
            title: 'Cupizz',
            navigatorKey: isTesting ? null : AppConfig.navigatorKey,
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
            ],
            theme: theme,
            defaultTransition: Transition.cupertino,
            popGesture: true,
            home: SplashScreen(),
            getPages: getPages,
          );
        });
  }
}
