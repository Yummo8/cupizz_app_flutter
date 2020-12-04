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
  Future<void> bootstrapAsync() async {
    await _reload();
    _connectSubsciption();
  }

  void initState() async {
    if (!model.conversations.isExistAndNotEmpty) {
      model.update(isLoading: true);
      await _reload();
      _connectSubsciption();
      model.update(isLoading: false);
    }
  }

  @override
  void reset({bool clearHistory}) {
    conversationSupscription?.cancel();
    super.reset(clearHistory: clearHistory);
  }

  void _connectSubsciption() {
    conversationSupscription = getService<MessageService>()
        .onConversationChange()
        .listen(onConversationChange);
    debugPrint('Subscribed conversation changes');
  }

  void onConversationChange(newConversation) {
    final oldConversationIndex =
        model.conversations.indexWhere((e) => e.id == newConversation.id);

    if (model.conversations[oldConversationIndex].newestMessage?.id ==
        newConversation?.newestMessage?.id) {
      model.conversations[oldConversationIndex] = newConversation;
      model.update(conversations: model.conversations);
    } else {
      model.conversations
        ..removeAt(oldConversationIndex)
        ..insert(0, newConversation);
    }

    model.update(conversations: model.conversations);
  }

  Future refresh() => _reload();

  Future loadmore() async {
    if (model.isLastPage) return;
    try {
      final data = await getService<MessageService>().getMyConversations(
        page: model.currentPage + 1,
      );
      final conversations = data.data;
      model.conversations.addAll(conversations);

      model.update(
        conversations: model.conversations,
        currentPage: model.currentPage + 1,
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
      model.update(
        conversations: data.data,
        currentPage: 1,
        isLastPage: data.isLastPage,
      );
      debugPrint('Reload conversations');
    } catch (e) {
      sendEvent(ChatPageEvent(
          action: ChatPageEventAction.error, message: e.toString()));
    }
  }
}
