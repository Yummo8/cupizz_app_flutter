part of '../index.dart';

class HobbyListModel extends MomentumModel<HobbyListController> {
  HobbyListModel(HobbyListController controller, {this.hobbies})
      : super(controller);

  final List<Hobby> hobbies;

  @override
  void update({List<Hobby> hobbies}) {
    HobbyListModel(
      controller,
      hobbies: hobbies,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return HobbyListModel(controller,
        hobbies: (json['hobbies'] as List)
            .map((e) => Mapper.fromJson(e).toObject<Hobby>())
            .toList());
  }

  @override
  Map<String, dynamic> toJson() =>
      {'hobbies': hobbies.map((e) => e.toJson()).toList()};
}
