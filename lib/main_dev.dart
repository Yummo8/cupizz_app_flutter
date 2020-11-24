import 'package:cupizz_app/src/models/index.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/base/base.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Cubiz Development',
    flavorName: AppFlavor.DEVELOPMENT,
    apiUrl: 'http://cupizz.cf/graphql',
    wss: 'ws://cupizz.cf/graphql',
    child: App(),
  );

  objectMapping();
  runApp(configuredApp);
}
