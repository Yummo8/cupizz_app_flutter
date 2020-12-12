part of '../user_screen.dart';

class _UserScreenModel extends MomentumModel<UserScreenController> {
  _UserScreenModel(
    UserScreenController controller, {
    this.user,
    this.isLoading = false,
  }) : super(controller);

  final SimpleUser user;
  final bool isLoading;

  @override
  void update({
    SimpleUser user,
    bool isLoading,
  }) {
    _UserScreenModel(
      controller,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return _UserScreenModel(
      controller,
      user: json['user'] != null
          ? Mapper.fromJson(json['user']).toObject<SimpleUser>()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
      };
}
