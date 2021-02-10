import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'src/base/base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var configuredApp = AppConfig(
    appName: 'Cubiz Development',
    flavorName: AppFlavor.DEVELOPMENT,
    apiUrl: 'https://dev.cupizz.cf/graphql',
    wss: 'ws://dev.cupizz.cf/graphql',
    child: App(),
  );

  objectMapping();
  runApp(configuredApp);
}
