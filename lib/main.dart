import 'dart:async';

// import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// import 'package:sentry/sentry.dart' hide App;

import 'src/app.dart';
import 'src/base/base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  var configuredApp = AppConfig(
    appName: 'Cupizz Production',
    flavorName: AppFlavor.PRODUCTION,
    apiUrl: 'https://cupizz.cf/graphql',
    wss: 'wss://cupizz.cf/graphql',
    child: App(),
    // sentry: kIsWeb
    //     ? null
    //     : SentryClient(SentryOptions(
    //         dsn:
    //             'https://22054fae83f14f0180e198172b3a4e9c@o494162.ingest.sentry.io/5564533')),
  );

  objectMapping();
  await initServices();
  await runZonedGuarded<Future<void>>(() async {
    runApp(configuredApp);
  }, (error, stackTrace) {
    // configuredApp.sentry?.captureException(
    //   error,
    //   stackTrace: stackTrace,
    // );
  });
}
