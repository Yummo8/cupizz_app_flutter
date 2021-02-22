import 'package:cupizz_app/src/base/base.dart';

export 'auth_service.dart';
export 'graphql/index.dart';
export 'graphql_service.dart';
export 'message_service.dart';
export 'one_signal_service.dart';
export 'storage_service.dart';
export 'system_service.dart';
export 'user_service.dart';
export 'post_service.dart';

Future initServices([bool isTesting = false]) async {
  Get.put(StorageService());
  Get.put(GraphqlService(
    //192.168.1.10:2020
    apiUrl: !isTesting ? AppConfig.instance.apiUrl : 'http://cupizz.cf/graphql',
    wss: !isTesting ? AppConfig.instance.wss : 'ws://cupizz.cf/graphql',
  ));
  Get.put(AuthService());
  Get.put(MessageService());
  if (!isTesting) {
    Get.put(OneSignalService());
  }
  Get.put(SystemService());
  Get.put(UserService());
  Get.put(PostService());
}
