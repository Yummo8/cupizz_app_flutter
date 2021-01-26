import 'src/app.dart';
import 'src/base/base.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
