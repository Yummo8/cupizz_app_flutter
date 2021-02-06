import 'package:cupizz_app/src/base/base.dart';

class SystemModel extends MomentumModel<SystemController> {
  SystemModel(
    SystemController controller, {
    this.postCategories,
    this.colorsOfAnswer,
    this.unreadMessageCount = 0,
    this.unreadReceiveFriendCount = 0,
    this.unreadAcceptedFriendCount = 0,
  }) : super(controller);

  final List<PostCategory> postCategories;
  final List<ColorOfAnswer> colorsOfAnswer;
  final int unreadMessageCount;
  final int unreadReceiveFriendCount;
  final int unreadAcceptedFriendCount;

  @override
  void update({
    List<PostCategory> postCategories,
    List<ColorOfAnswer> colorsOfAnswer,
    int unreadMessageCount,
    int unreadReceiveFriendCount,
    int unreadAcceptedFriendCount,
  }) {
    SystemModel(
      controller,
      postCategories: postCategories ?? this.postCategories,
      colorsOfAnswer: colorsOfAnswer ?? this.colorsOfAnswer,
      unreadMessageCount: unreadMessageCount ?? this.unreadMessageCount,
      unreadReceiveFriendCount:
          unreadReceiveFriendCount ?? this.unreadReceiveFriendCount,
      unreadAcceptedFriendCount:
          unreadAcceptedFriendCount ?? this.unreadAcceptedFriendCount,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return SystemModel(
      controller,
      postCategories: json['postCategories'] != null
          ? (json['postCategories'] as List)
              .map((e) => Mapper.fromJson(e).toObject<PostCategory>())
              .toList()
          : [],
      colorsOfAnswer: json['colorsOfAnswer'] != null
          ? (json['colorsOfAnswer'] as List)
              .map((e) => Mapper.fromJson(e).toObject<ColorOfAnswer>())
              .toList()
          : [],
      unreadMessageCount: json['unreadMessageCount'] ?? 0,
      unreadReceiveFriendCount: json['unreadReceiveFriendCount'] ?? 0,
      unreadAcceptedFriendCount: json['unreadAcceptedFriendCount'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'postCategories':
            postCategories?.map((e) => e.toJson())?.toList() ?? [],
        'colorsOfAnswer':
            colorsOfAnswer?.map((e) => e.toJson())?.toList() ?? [],
        'unreadMessageCount': unreadMessageCount ?? 0,
        'unreadReceiveFriendCount': unreadReceiveFriendCount ?? 0,
        'unreadAcceptedFriendCount': unreadAcceptedFriendCount ?? 0,
      };
}
