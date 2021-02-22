import 'dart:developer';

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

    OneSignal.shared.setNotificationReceivedHandler(_handleNewNotification);

    _handleOpenWhenClick();
    _isInited = true;
    log('Finished setting up.', name: 'OneSignal');
    return this;
  }

  void _handleNewNotification(OSNotification notification) {
    debugPrint('New notification: ${notification.payload.additionalData}');
    SystemController().fetchUnreadNoti();
    final data = notification.payload.additionalData;

    if (data != null && data is Map) {
      final type = NotificationType(rawValue: data['type']);
      final String code = data['code'];

      if (type == NotificationType.other) {
        if (code == 'deleteAnonymousChat') {
          Momentum.controller<AnonymousChatController>(
                  AppConfig.navigatorKey.currentContext)
              .getMyAnonymousChat();
        }
      }
    }
  }

  void _handleOpenWhenClick() {
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      final data = result.notification.payload.additionalData;

      if (data != null && data is Map) {
        final type = NotificationType(rawValue: data['type']);
        final String refUserId = data['refUserId'];
        final String refConversationId = data['refConversationId'];
        final String code = data['code'];

        if (type == NotificationType.like ||
            type == NotificationType.matching) {
          Get.toNamed(
            Routes.user,
            arguments: UserScreenParams(userId: refUserId),
          );
        } else if (type == NotificationType.newMessage) {
          if (code == 'newAnonymousMessage') {
            Get.toNamed(Routes.anonymousChat);
          } else {
            Get.toNamed(Routes.messages,
                arguments: MessagesScreenParams(
                    conversationKey:
                        ConversationKey(conversationId: refConversationId)));
          }
        } else if (type == NotificationType.otherFindingAnonymousChat) {
          Get.toNamed(Routes.anonymousChat,
              arguments: AnonymousChatScreenArgs(findingImmediately: true));
        } else if (type == NotificationType.other) {
          if (code == 'deleteAnonymousChat') {
            Get.toNamed(Routes.anonymousChat,
                arguments: AnonymousChatScreenArgs(findingImmediately: true));
          }
        }

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
    unawaited(OneSignal.shared.setExternalUserId(userId).then((_) =>
        log('Sent tags userId: $userId to OneSignal.', name: 'Onesignal')));
  }

  Future<void> unSubscribe() async {
    if (!_isInited) {
      await init();
    }
    await OneSignal.shared.setExternalUserId('logged out');
  }
}
