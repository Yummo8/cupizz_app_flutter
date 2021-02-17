import 'dart:async';

import 'package:cupizz_app/src/base/base.dart';

import 'anonymous_chat.model.dart';

class AnonymousChatController extends MomentumController<AnonymousChatModel> {
  StreamSubscription<Conversation> findChatSupscription;

  @override
  AnonymousChatModel init() {
    return AnonymousChatModel(this);
  }

  void findAnonymousChat() {
    if (model.conversation != null) {
      Fluttertoast.showToast(
          msg:
              'Không thể bắt đầu một cuộc trò chuyện mới, hãy kết thúc cuộc trò chuyện hiện tại trước.');
      return;
    }
    model.update(isFinding: true);
    findChatSupscription =
        Get.find<MessageService>().findAnonymousChat().listen((conversation) {
      model.update(
        conversation: conversation,
        isFinding: false,
      );
    });
  }

  Future loadMessage() async {
    if (model.conversation == null) return;
    await Get.find<MessageService>().getMessages(
        key: ConversationKey(conversationId: model.conversation.id));
  }

  Future _loadMessage(String cursorId) async {
    await trycatch(() async {
      await Get.find<MessageService>().getMessages(
          key: ConversationKey(conversationId: model.conversation.id));
    });
  }
}
