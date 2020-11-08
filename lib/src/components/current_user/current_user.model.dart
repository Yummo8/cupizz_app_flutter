import 'package:cupizz_app/src/models/index.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';
import '../../base/base.dart';

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
        currentUser: json != null
            ? Mapper.fromJson(json['currentUser']).toObject<User>()
            : null);
  }

  @override
  Map<String, dynamic> toJson() {
    final result = {'currentUser': currentUser.toJson()};
    debugPrint(result.toString());
    return result;
  }
}
