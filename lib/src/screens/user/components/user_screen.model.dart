part of '../user_screen.dart';

class _UserScreenModel extends MomentumModel<UserScreenController> {
  _UserScreenModel(UserScreenController controller, {this.user})
      : super(controller);

  final SimpleUser user;

  @override
  void update({SimpleUser user}) {
    _UserScreenModel(
      controller,
      user: user ?? this.user,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return _UserScreenModel(controller, user: json['user']);
  }

  @override
  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
      };
}
