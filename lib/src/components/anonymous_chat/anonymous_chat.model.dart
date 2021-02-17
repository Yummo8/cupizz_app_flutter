import 'package:cupizz_app/src/base/base.dart';

import 'anonymous_chat.controller.dart';

class AnonymousChatModel extends MomentumModel<AnonymousChatController> {
  AnonymousChatModel(
    AnonymousChatController controller, {
    this.conversation,
    this.isFinding = false,
  }) : super(controller);

  final Conversation conversation;
  final bool isFinding;

  @override
  void update({
    Conversation conversation,
    bool isFinding,
  }) {
    AnonymousChatModel(
      controller,
      conversation: conversation ?? this.conversation,
      isFinding: isFinding ?? this.isFinding,
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
