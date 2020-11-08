part of '../index.dart';

class CurrentUserModel extends MomentumModel<CurrentUserController> {
  CurrentUserModel(CurrentUserController controller,
      {@required this.currentUser})
      : super(controller);

  final User currentUser;

  @override
  void update({@required User currentUser}) {
    CurrentUserModel(
      controller,
      currentUser: currentUser ?? this.currentUser,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(controller,
        currentUser: json != null && json['currentUser'] != null
            ? Mapper.fromJson(json['currentUser']).toObject<User>()
            : null);
  }

  @override
  Map<String, dynamic> toJson() {
    final result = {'currentUser': currentUser?.toJson()};
    debugPrint(result.toString());
    return result;
  }
}
