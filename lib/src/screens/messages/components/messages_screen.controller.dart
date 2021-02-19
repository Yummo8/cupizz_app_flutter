part of '../messages_screen.dart';

enum ChatPageEventAction {
  error,
}

class ChatPageEvent {
  final ChatPageEventAction action;
  final String message;

  ChatPageEvent({@required this.action, this.message});
}

class MessagesScreenController extends MomentumController<MessagesScreenModel> {
  StreamSubscription<Message> messageSupscription;

  @override
  MessagesScreenModel init() {
    return MessagesScreenModel(this);
  }

  Future loadData(MessagesScreenParams params) async {
    model.update(isLoading: true);
    try {
      if (params.conversation != null) {
        model.update(conversation: params.conversation);
      } else {
        await _reload(key: params.conversationKey);
      }
      subscribe(ConversationKey(conversationId: model.conversation.id));
    } finally {
      model.update(isLoading: false);
    }
  }

  @override
  void reset({bool clearHistory}) {
    messageSupscription?.cancel();
    messageSupscription = null;
    debugPrint('Unsubscribed conversation');
    super.reset(clearHistory: clearHistory);
  }

  Future refresh() => _reload();

  void onNewMessage(Message message) {
    model.conversation.messages.data.insert(0, message);
    model.update(conversation: model.conversation);
  }

  void sendMessage({String message, List<File> attachments}) async {
    try {
      model.update(isSendingMessage: true);
      await Get.find<MessageService>().sendMessage(
        ConversationKey(conversationId: model.conversation.id),
        message: message,
        attachments: attachments,
      );
    } catch (e) {
      unawaited(Fluttertoast.showToast(msg: e.toString()));
    } finally {
      model.update(isSendingMessage: false);
    }
  }

  Future loadmore() async {
    if (model.conversation.messages.isLastPage) return;
    try {
      final data = await Get.find<MessageService>().getMessagesV2(
        key: ConversationKey(conversationId: model.conversation?.id),
        cursor: model.conversation.messages.last?.id,
      );
      model.conversation.messages.add(data);

      model.update(conversation: model.conversation);
    } catch (e) {
      sendEvent(ChatPageEvent(
          action: ChatPageEventAction.error, message: e.toString()));
    }
  }

  Future _reload({ConversationKey key}) async {
    try {
      if (key == null && model.conversation == null) {
        throw 'Missing screen params';
      }
      final messageService = Get.find<MessageService>();

      final conversation = await messageService.getConversation(key: key);

      model.update(conversation: conversation);
    } catch (e) {
      sendEvent(ChatPageEvent(
          action: ChatPageEventAction.error, message: e.toString()));
    }
  }

  void subscribe(ConversationKey key) {
    if (key != null) {
      if (messageSupscription != null) {
        messageSupscription.cancel();
      }
      messageSupscription =
          Get.find<MessageService>().onNewMessage(key).listen(onNewMessage);
      debugPrint('Subscribed conversation: $key');
    }
  }
}
