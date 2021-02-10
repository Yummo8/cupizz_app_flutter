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
    apiUrl: 'http://192.168.1.242:2020/graphql',
    wss: 'ws://192.168.1.242:2020/graphql',
    child: App(),
  );

  objectMapping();
  runApp(configuredApp);
}
