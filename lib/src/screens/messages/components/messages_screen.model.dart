part of '../messages_screen.dart';

class MessagesScreenModel extends MomentumModel<MessagesScreenController> {
  MessagesScreenModel(
    MessagesScreenController controller, {
    this.conversation,
    this.messages = const [],
    this.scrollOffset = 0,
    this.currentPage = 1,
    this.isLastPage = false,
    this.isLoading = false,
  }) : super(controller);

  final Conversation conversation;
  final List<Message> messages;
  final double scrollOffset;
  final int currentPage;
  final bool isLastPage;

  final bool isLoading;

  @override
  void update({
    Conversation conversation,
    List<Message> messages,
    double scrollOffset,
    int currentPage,
    int unreadMessageCount,
    bool isLastPage,
    bool isLoading,
  }) {
    MessagesScreenModel(
      controller,
      conversation: conversation ?? this.conversation,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return MessagesScreenModel(
      controller,
      conversation:
          Mapper.fromJson(json['conversation']).toObject<Conversation>(),
      messages: ((json['messages'] ?? []) as List)
          .map((e) => Mapper.fromJson(e).toObject<Message>())
          .toList(),
      scrollOffset: json['scrollOffset'],
      currentPage: json['currentPage'],
      isLastPage: json['isLastPage'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'conversation': conversation.toJson(),
        'messages': messages.map((e) => e.toJson()).toList(),
        'scrollOffset': scrollOffset,
        'currentPage': currentPage,
        'isLastPage': isLastPage,
      };
}
