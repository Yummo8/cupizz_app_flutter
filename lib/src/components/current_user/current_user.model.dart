import 'package:cupizz_app/src/models/index.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';

class CurrentUserModel extends MomentumModel<CurrentUserController> {
  CurrentUserModel(CurrentUserController controller,
      {@required this.currentUser})
      : super(controller);

  final User currentUser;

  @override
  void update({@required User currentUser}) {
    CurrentUserModel(
      controller,
      currentUser: currentUser,
    ).updateMomentum();
  }
}
