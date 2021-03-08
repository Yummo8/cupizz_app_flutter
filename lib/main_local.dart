import 'package:graphql_flutter/graphql_flutter.dart';

import 'src/app.dart';
import 'src/base/base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  var configuredApp = AppConfig(
    appName: 'Cubiz Development',
    flavorName: AppFlavor.DEVELOPMENT,
    apiUrl: 'http://192.168.1.4:1998/graphql',
    wss: 'ws://192.168.1.4:1998/graphql',
    child: App(),
  );

  objectMapping();
  await initServices();
  runApp(configuredApp);
}
