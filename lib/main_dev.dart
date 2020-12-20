import 'package:cupizz_app/src/models/index.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/base/base.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var configuredApp = AppConfig(
    appName: 'Cubiz Development',
    flavorName: AppFlavor.DEVELOPMENT,
    apiUrl: 'https://cupizz.cf/graphql',
    wss: 'ws://cupizz.cf/graphql',
    child: App(),
  );

  objectMapping();
  runApp(configuredApp);
}
