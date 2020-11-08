import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/models/index.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';

class RecommendableUsersModel
    extends MomentumModel<RecommendableUsersController> {
  RecommendableUsersModel(RecommendableUsersController controller,
      {this.users, this.isLoading, this.error})
      : super(controller);

  final List<SimpleUser> users;
  final bool isLoading;
  final String error;

  @override
  void update({List<SimpleUser> users, bool isLoading, String error}) {
    RecommendableUsersModel(
      controller,
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading ?? false,
      error: error,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return RecommendableUsersModel(
      controller,
      users: (json['users'] as List)
          .map((e) => Mapper.fromJson(e).toObject<SimpleUser>())
          .toList(),
      isLoading: json['isLoading'],
      error: json['error'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'users': users.map((e) => e.toJson()).toList(),
        'isLoading': isLoading,
        'error': error,
      };
}
