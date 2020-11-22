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
  @override
  ChatPageModel init() {
    return ChatPageModel(this);
  }

  @override
  bootstrapAsync() async {
    this.model.update(isLoading: true);
    await _reload();
    this.model.update(isLoading: false);
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
            messages: this.model.conversations,
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
            messages: data.data,
            currentPage: 1,
            isLastPage: data.isLastPage,
          );
    } catch (e) {
      sendEvent(ChatPageEvent(
          action: ChatPageEventAction.error, message: e.toString()));
    }
  }
}
