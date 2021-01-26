import 'package:cupizz_app/src/base/base.dart';

class RecommendableUsersModel
    extends MomentumModel<RecommendableUsersController> {
  RecommendableUsersModel(
    RecommendableUsersController controller, {
    this.users,
    this.isLoading = false,
    this.error,
    this.isLastPage = false,
  }) : super(controller);

  final List<SimpleUser> users;
  final bool isLoading;
  final bool isLastPage;
  final String error;

  @override
  void update(
      {List<SimpleUser> users, bool isLoading, String error, bool isLastPage}) {
    RecommendableUsersModel(
      controller,
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading ?? false,
      error: error,
      isLastPage: isLastPage ?? this.isLastPage ?? false,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return RecommendableUsersModel(
      controller,
      users: (json['users'] as List)
          .map((e) => Mapper.fromJson(e).toObject<SimpleUser>())
          .toList(),
      error: json['error'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'users': users.map((e) => e.toJson()).toList(),
        'error': error,
      };
}
