library user_screen;

import 'package:cupizz_app/src/screens/main/pages/friend_v2/friend_page_v2.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:fluttertoast/fluttertoast.dart';
import '../../base/base.dart';

part 'components/user_screen.controller.dart';
part 'components/user_screen.model.dart';

class UserScreenParams extends RouterParam {
  final ChatUser user;
  final String userId;

  UserScreenParams({this.userId, this.user})
      : assert(userId != null || user != null);
}

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Momentum.controller<UserScreenController>(context);
    final params = Router.getParam<UserScreenParams>(context);
    controller.loadData(chatUser: params?.user, userId: params?.userId);

    return MomentumBuilder(
      controllers: [UserScreenController],
      builder: (context, snapshot) {
        var model = snapshot<_UserScreenModel>();
        return UserProfile(
          user: model.user,
          showBackButton: true,
          onRefresh: controller.refresh,
          isLoading: model.isLoading,
        );
      },
    );
  }
}
