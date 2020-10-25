import 'package:flutter/cupertino.dart';

import 'src/app.dart';
import 'src/base/base.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Cupizz Production',
    flavorName: AppFlavor.PRODUCTION,
    apiUrl: 'https://cupizz.cf',
    child: App(),
  );

  runApp(configuredApp);
}
