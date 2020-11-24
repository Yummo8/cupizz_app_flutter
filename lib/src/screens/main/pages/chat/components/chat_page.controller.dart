part of '../chat_page.dart';

enum ChatPageEventAction {
  error,
}

class ChatPageEvent {
  final ChatPageEventAction action;
  final String message;

  ChatPageEvent({@required this.action, this.message});
}

class ChatPageController extends MomentumController<ChatPageModel> {
  StreamSubscription<Conversation> conversationSupscription;

  @override
  ChatPageModel init() {
    return ChatPageModel(this);
  }

  @override
  bootstrapAsync() async {
    this.model.update(isLoading: true);
    await _reload();
    _connectSubsciption();
    this.model.update(isLoading: false);
  }

  @override
  reset({bool clearHistory}) {
    conversationSupscription?.cancel();
    super.reset(clearHistory: clearHistory);
  }

  _connectSubsciption() {
    conversationSupscription = getService<MessageService>()
        .onConversationChange()
        .listen(onConversationChange);
  }

  void onConversationChange(newConversation) {
    final oldConversationIndex =
        this.model.conversations.indexWhere((e) => e.id == newConversation.id);

    if (this.model.conversations[oldConversationIndex].newestMessage?.id ==
        newConversation?.newestMessage?.id) {
      this.model.conversations[oldConversationIndex] = newConversation;
      this.model.update(conversations: this.model.conversations);
    } else {
      this.model.conversations
        ..removeAt(oldConversationIndex)
        ..insert(0, newConversation);
    }

    this.model.update(conversations: this.model.conversations);
  }

  Future refresh() => _reload();

  Future loadmore() async {
    if (this.model.isLastPage) return;
    try {
      final data = await getService<MessageService>().getMyConversations(
        page: this.model.currentPage + 1,
      );
      final conversations = data.data;
      this.model.conversations.addAll(conversations);

      this.model.update(
            conversations: this.model.conversations,
            currentPage: this.model.currentPage + 1,
            isLastPage: data.isLastPage,
          );
    } catch (e) {
      sendEvent(ChatPageEvent(
          action: ChatPageEventAction.error, message: e.toString()));
    }
  }

  Future _reload() async {
    try {
      final data = await getService<MessageService>().getMyConversations(
        page: 1,
      );
      this.model.update(
            conversations: data.data,
            currentPage: 1,
            isLastPage: data.isLastPage,
          );
    } catch (e) {
      sendEvent(ChatPageEvent(
          action: ChatPageEventAction.error, message: e.toString()));
    }
  }
}
