import 'dart:async';

import 'package:cupizz_app/src/base/base.dart';
import 'package:vibration/vibration.dart';

import 'anonymous_chat.model.dart';

class AnonymousChatController extends MomentumController<AnonymousChatModel> {
  StreamSubscription<Conversation>? findChatSupscription;

  @override
  AnonymousChatModel init() {
    return AnonymousChatModel(this);
  }

  @override
  Future<void> bootstrapAsync() async {
    await getMyAnonymousChat();
    return super.bootstrapAsync();
  }

  void findAnonymousChat() {
    if (model!.conversation != null) {
      // Fluttertoast.showToast(
      //     msg:
      //         'Không thể bắt đầu một cuộc trò chuyện mới, hãy kết thúc cuộc trò chuyện hiện tại trước.');
      return;
    }
    model!.update(isFinding: true);
    findChatSupscription =
        Get.find<MessageService>().findAnonymousChat().listen((conversation) {
      model!.update(conversation: conversation);
      cancelFinding();
    });
  }

  void cancelFinding() {
    findChatSupscription?.cancel();
    findChatSupscription = null;
    model!.update(isFinding: false);
  }

  Future deleteAnonymousChat() async {
    await _loading(() async {
      await Get.find<MessageService>().deleteAnonymousChat();
      model!.deleteConversation();
    });
  }

  Future getMyAnonymousChat({bool showNotiDeleteChat = false}) async {
    final conversation = await Get.find<MessageService>().getMyAnonymousChat();
    if (conversation != null) {
      model!.update(conversation: conversation);
    } else {
      if (showNotiDeleteChat && model!.conversation != null) {
        Get.snackbar(
            'Đối phương đã ngưng chat với bạn', 'Cùng tìm bạn mới thôi!');
        unawaited(Vibration.vibrate(amplitude: 255, duration: 30));
      }
      model!.deleteConversation();
    }
  }

  Future _loading(Function func,
      {bool throwError = false, bool enableLoading = true}) async {
    if (enableLoading) {
      model!.update(isLoading: true);
    }
    try {
      await func();
    } catch (e) {
      unawaited(Fluttertoast.showToast(msg: e.toString()));
      if (throwError) rethrow;
    } finally {
      if (enableLoading) {
        model!.update(isLoading: false);
      }
    }
  }
}
