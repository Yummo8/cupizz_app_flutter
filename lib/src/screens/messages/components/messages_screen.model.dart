part of '../messages_screen.dart';

class MessagesScreenModel extends MomentumModel<MessagesScreenController> {
  MessagesScreenModel(
    MessagesScreenController controller, {
    this.conversation,
    this.scrollOffset = 0,
    this.isLoading = false,
    this.isSendingMessage = false,
  }) : super(controller);

  final Conversation conversation;
  final double scrollOffset;

  final bool isLoading;
  final bool isSendingMessage;

  @override
  void update({
    Conversation conversation,
    double scrollOffset,
    bool isLoading,
    bool isSendingMessage,
  }) {
    MessagesScreenModel(
      controller,
      conversation: conversation ?? this.conversation,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      isLoading: isLoading ?? this.isLoading,
      isSendingMessage: isSendingMessage ?? this.isSendingMessage,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return MessagesScreenModel(
      controller,
      conversation: json['conversation'] != null
          ? Mapper.fromJson(json['conversation']).toObject<Conversation>()
          : null,
      scrollOffset: json['scrollOffset'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'conversation': conversation?.toJson(),
        'scrollOffset': scrollOffset,
      };
}
