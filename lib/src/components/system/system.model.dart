import 'package:cupizz_app/src/base/base.dart';

class SystemModel extends MomentumModel<SystemController> {
  SystemModel(
    SystemController controller, {
    this.colorsOfAnswer,
    this.unreadMessageCount,
  }) : super(controller);

  final List<ColorOfAnswer> colorsOfAnswer;
  final int unreadMessageCount;

  @override
  void update({
    List<ColorOfAnswer> colorsOfAnswer,
    int unreadMessageCount,
  }) {
    SystemModel(
      controller,
      colorsOfAnswer: colorsOfAnswer ?? this.colorsOfAnswer,
      unreadMessageCount: unreadMessageCount ?? this.unreadMessageCount,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return SystemModel(
      controller,
      colorsOfAnswer: json['colorsOfAnswer'] != null
          ? (json['colorsOfAnswer'] as List)
              .map((e) => Mapper.fromJson(e).toObject<ColorOfAnswer>())
              .toList()
          : [],
      unreadMessageCount: json['unreadMessageCount'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'colorsOfAnswer': colorsOfAnswer?.map((e) => e.toJson())?.toList(),
        'unreadMessageCount': unreadMessageCount ?? 0,
      };
}
