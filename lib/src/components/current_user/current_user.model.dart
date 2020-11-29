part of '../index.dart';

class CurrentUserModel extends MomentumModel<CurrentUserController> {
  CurrentUserModel(
    CurrentUserController controller, {
    @required this.currentUser,
    this.isLoading = false,
    this.isUpdatingCover = false,
    this.isUpdatingAvatar = false,
  }) : super(controller);

  final User currentUser;
  final bool isLoading;
  final bool isUpdatingCover;
  final bool isUpdatingAvatar;

  @override
  void update({
    User currentUser,
    bool isLoading,
    bool isUpdatingCover,
    bool isUpdatingAvatar,
  }) {
    CurrentUserModel(
      controller,
      currentUser: currentUser ?? this.currentUser,
      isLoading: isLoading ?? this.isLoading,
      isUpdatingCover: isUpdatingCover ?? this.isUpdatingCover,
      isUpdatingAvatar: isUpdatingAvatar ?? this.isUpdatingAvatar,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      controller,
      currentUser: json != null && json['currentUser'] != null
          ? Mapper.fromJson(json['currentUser']).toObject<User>()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final result = {
      'currentUser': currentUser?.toJson(),
    };
    return result;
  }
}
