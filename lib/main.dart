import 'package:cupizz_app/src/models/index.dart';
import 'package:flutter/cupertino.dart';

import 'src/app.dart';
import 'src/base/base.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Cupizz Production',
    flavorName: AppFlavor.PRODUCTION,
    apiUrl: 'http://cupizz.cf/graphql',
    child: App(),
  );

  objectMapping();
  runApp(configuredApp);
}
