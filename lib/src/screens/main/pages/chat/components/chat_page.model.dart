part of '../chat_page.dart';

class ChatPageModel extends MomentumModel<ChatPageController> {
  ChatPageModel(
    ChatPageController controller, {
    this.conversations = const [],
    this.scrollOffset = 0,
    this.currentPage = 1,
    this.unreadMessageCount = 0,
    this.isLastPage = false,
    this.isLoading = false,
  }) : super(controller);

  final List<Conversation> conversations;
  final double? scrollOffset;
  final int? currentPage;
  final bool? isLastPage;
  final int? unreadMessageCount;

  final bool isLoading;

  @override
  void update({
    List<Conversation>? conversations,
    double? scrollOffset,
    int? currentPage,
    int? unreadMessageCount,
    bool? isLastPage,
    bool? isLoading,
  }) {
    ChatPageModel(
      controller,
      unreadMessageCount: unreadMessageCount ?? this.unreadMessageCount,
      conversations: conversations ?? this.conversations,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
      isLoading: isLoading ?? this.isLoading,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic>? json) {
    return ChatPageModel(
      controller,
      conversations: ((json!['conversations'] ?? []) as List)
          .map((e) => Mapper.fromJson(e).toObject<Conversation>())
          .toList(),
      scrollOffset: json['scrollOffset'],
      currentPage: json['currentPage'],
      unreadMessageCount: json['unreadMessageCount'],
      isLastPage: json['isLastPage'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'conversations': conversations.map((e) => e.toJson()).toList(),
        'scrollOffset': scrollOffset,
        'currentPage': currentPage,
        'isLastPage': isLastPage,
        'unreadMessageCount': unreadMessageCount,
      };
}
