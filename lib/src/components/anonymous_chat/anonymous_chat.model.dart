import 'package:cupizz_app/src/base/base.dart';

import 'anonymous_chat.controller.dart';

class AnonymousChatModel extends MomentumModel<AnonymousChatController> {
  AnonymousChatModel(
    AnonymousChatController controller, {
    this.conversation,
    this.isFinding = false,
    this.isLoading = false,
  }) : super(controller);

  final Conversation conversation;
  final bool isFinding;
  final bool isLoading;

  @override
  void update({
    Conversation conversation,
    bool isFinding,
    bool isLoading,
  }) {
    AnonymousChatModel(
      controller,
      conversation: conversation ?? this.conversation,
      isFinding: isFinding ?? this.isFinding,
      isLoading: isLoading ?? this.isLoading,
    ).updateMomentum();
  }

  void deleteConversation() {
    AnonymousChatModel(
      controller,
      conversation: null,
      isFinding: isFinding,
      isLoading: isLoading,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return AnonymousChatModel(
      controller,
      conversation: json['conversation'] != null
          ? Mapper.fromJson(json['conversation']).toObject<Conversation>()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'conversation': conversation?.toJson(),
      };
}
