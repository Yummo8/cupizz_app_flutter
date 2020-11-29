part of '../index.dart';

class CurrentUserModel extends MomentumModel<CurrentUserController> {
  CurrentUserModel(
    CurrentUserController controller, {
    @required this.currentUser,
    this.isLoading = false,
    this.isUpdaingCover = false,
  }) : super(controller);

  final User currentUser;
  final bool isLoading;
  final bool isUpdaingCover;

  @override
  void update({
    User currentUser,
    bool isLoading,
    bool isUpdaingCover,
  }) {
    CurrentUserModel(
      controller,
      currentUser: currentUser ?? this.currentUser,
      isLoading: isLoading ?? this.isLoading,
      isUpdaingCover: isUpdaingCover ?? this.isUpdaingCover,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      controller,
      currentUser: json != null && json['currentUser'] != null
          ? Mapper.fromJson(json['currentUser']).toObject<User>()
          : null,
      isLoading: (json ?? {})['isLoading'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final result = {
      'currentUser': currentUser?.toJson(),
      'isLoading': isLoading,
    };
    return result;
  }
}
