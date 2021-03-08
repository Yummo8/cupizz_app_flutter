part of '../chat_page.dart';

enum ChatPageEventAction {
  error,
}

class ChatPageEvent {
  final ChatPageEventAction action;
  final String? message;

  ChatPageEvent({required this.action, this.message});
}

class ChatPageController extends MomentumController<ChatPageModel> {
  StreamSubscription<Conversation>? conversationSupscription;

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
    if (!model!.conversations.isExistAndNotEmpty) {
      model!.update(isLoading: true);
      await _reload();
      _connectSubsciption();
      model!.update(isLoading: false);
    }
  }

  @override
  void reset({bool? clearHistory}) {
    conversationSupscription?.cancel();
    debugPrint('Unsubscribed conversation changes');
    super.reset(clearHistory: clearHistory);
  }

  void _connectSubsciption() {
    conversationSupscription?.cancel();
    conversationSupscription = Get.find<MessageService>()
        .onConversationChange()
        .listen(onConversationChange);
    debugPrint('Subscribed conversation changes');
  }

  void onConversationChange(Conversation newConversation) {
    final oldConversationIndex =
        model!.conversations.indexWhere((e) => e.id == newConversation.id);

    if (oldConversationIndex >= 0) {
      if (model!.conversations[oldConversationIndex].newestMessage?.id ==
          newConversation.newestMessage?.id) {
        model!.conversations[oldConversationIndex] = newConversation;
      } else {
        model!.conversations
          ..removeAt(oldConversationIndex)
          ..insert(0, newConversation);
      }
    } else {
      model!.conversations.insert(0, newConversation);
    }

    // Show Incoming call screen if newest message is a call
    if (newConversation.newestMessage?.callStatus == CallStatus.ringing &&
        !newConversation.newestMessage!.isCaller!) {
      dependOn<CallController>()
          .onNewIncomingCall(newConversation.newestMessage);
    } else if (newConversation.newestMessage?.callStatus ==
            CallStatus.missing ||
        newConversation.newestMessage?.callStatus == CallStatus.rejected ||
        newConversation.newestMessage?.callStatus == CallStatus.ended) {
      dependOn<CallController>()
          .onNewMissingCall(newConversation.newestMessage);
    }

    model!.update(conversations: model!.conversations);
    dependOn<SystemController>().getUnreadMessageCount();
  }

  Future refresh() async {
    _connectSubsciption();
    await _reload();
  }

  Future loadmore() async {
    if (model!.isLastPage!) return;
    try {
      final data = await Get.find<MessageService>().getMyConversations(
        page: model!.currentPage! + 1,
      );
      final conversations = data.data!;
      model!.conversations.addAll(conversations);

      model!.update(
        conversations: model!.conversations,
        currentPage: model!.currentPage! + 1,
        isLastPage: data.isLastPage,
      );
    } catch (e) {
      sendEvent(ChatPageEvent(
          action: ChatPageEventAction.error, message: e.toString()));
    }
  }

  Future _reload() async {
    try {
      final data = await Get.find<MessageService>().getMyConversations(
        page: 1,
      );
      model!.update(
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
