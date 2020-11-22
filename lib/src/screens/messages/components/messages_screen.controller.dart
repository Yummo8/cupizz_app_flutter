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
  @override
  MessagesScreenModel init() {
    return MessagesScreenModel(this);
  }

  Future loadData(ConversationKey key) async {
    this.model.update(isLoading: true);
    await _reload(key: key);
    this.model.update(isLoading: false);
  }

  Future refresh() => _reload();

  Future loadmore() async {
    if (this.model.isLastPage) return;
    try {
      final data = await getService<MessageService>().getMessages(
        key: ConversationKey(conversationId: this.model.conversation?.id),
        page: this.model.currentPage + 1,
      );
      final messages = data.data;
      this.model.messages.addAll(messages);

      this.model.update(
            messages: messages,
            currentPage: this.model.currentPage + 1,
            isLastPage: data.isLastPage,
          );
    } catch (e) {
      sendEvent(ChatPageEvent(
          action: ChatPageEventAction.error, message: e.toString()));
    }
  }

  Future _reload({ConversationKey key}) async {
    try {
      if (key == null && this.model.conversation == null) {
        throw 'Missing screen params';
      }
      final messageService = getService<MessageService>();

      final futureRes = await Future.wait([
        messageService.getMessages(
          key: key ??
              ConversationKey(conversationId: this.model.conversation?.id),
          page: 1,
        ),
        ...key != null ? [messageService.getConversation(key: key)] : []
      ]);

      final messagesData = futureRes[0];

      this.model.update(
            conversation: futureRes.length > 1 ? futureRes[1] : null,
            messages: messagesData.data,
            currentPage: 1,
            isLastPage: messagesData.isLastPage,
          );
    } catch (e) {
      sendEvent(ChatPageEvent(
          action: ChatPageEventAction.error, message: e.toString()));
    }
  }
}
