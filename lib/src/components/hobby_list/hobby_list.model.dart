import 'package:cupizz_app/src/base/base.dart';

class HobbyListModel extends MomentumModel<HobbyListController> {
  HobbyListModel(
    HobbyListController controller, {
    this.hobbies,
    this.error,
    this.isLoading,
  }) : super(controller);

  final List<Hobby>? hobbies;
  final String? error;
  final bool? isLoading;

  @override
  void update({List<Hobby>? hobbies, String? error, bool? isLoading}) {
    HobbyListModel(
      controller,
      hobbies: hobbies ?? this.hobbies,
      error: error,
      isLoading: isLoading ?? false,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic>? json) {
    return HobbyListModel(controller,
        hobbies: (json!['hobbies'] as List)
            .map((e) => Mapper.fromJson(e).toObject<Hobby>())
            .toList());
  }

  @override
  Map<String, dynamic> toJson() =>
      {'hobbies': hobbies?.map((e) => e.toJson()).toList() ?? []};
}
