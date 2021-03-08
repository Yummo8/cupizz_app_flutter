import 'package:graphql_flutter/graphql_flutter.dart';

import 'src/app.dart';
import 'src/base/base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  var configuredApp = AppConfig(
    appName: 'Cubiz Development',
    flavorName: AppFlavor.DEVELOPMENT,
    apiUrl: 'https://dev.cupizz.cf/graphql',
    wss: 'ws://dev.cupizz.cf/graphql',
    child: App(),
  );

  objectMapping();
  await initServices();
  runApp(configuredApp);
}
