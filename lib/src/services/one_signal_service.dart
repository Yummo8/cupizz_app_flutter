import 'package:cupizz_app/src/base/base.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pedantic/pedantic.dart';

class OneSignalService extends GetxService {
  bool _isInited = false;

  Future<OneSignalService> init() async {
    await OneSignal.shared.init('3adf348e-2781-4d56-8003-f0813dee3bfe',
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: true
        });
    await OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      debugPrint('New notification: ${notification.payload.additionalData}');
      SystemController().fetchUnreadNoti();
    });

    _handleOpenWhenClick();
    _isInited = true;
    debugPrint('OneSignal: Finished setting up.');
    return this;
  }

  void _handleOpenWhenClick() {
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      final data = result.notification.payload.additionalData;

      if (data != null && data is Map) {
        final type = NotificationType(rawValue: data['type']);
        final String refUserId = data['refUserId'];
        final String refConversationId = data['refConversationId'];

        if (type == NotificationType.like ||
            type == NotificationType.matching) {
          Get.toNamed(
            Routes.user,
            arguments: UserScreenParams(userId: refUserId),
          );
        } else if (type == NotificationType.newMessage) {
          Get.toNamed(Routes.messages,
              arguments: MessagesScreenParams(
                  ConversationKey(conversationId: refConversationId)));
        } else {}

        debugPrint(
            'Clicked on notification type: ${type.rawValue}, reference user id: $refUserId, reference conversation id: $refConversationId');
      }
    });
  }

  Future<void> subscribe(String userId) async {
    if (!_isInited) {
      await init();
    }
    await OneSignal.shared.setSubscription(true);
    unawaited(OneSignal.shared
        .setExternalUserId(userId)
        .then((_) => debugPrint('Sent tags userId: $userId to OneSignal.')));
  }

  Future<void> unSubscribe() async {
    if (!_isInited) {
      await init();
    }
    await OneSignal.shared.setExternalUserId('logged out');
  }
}
