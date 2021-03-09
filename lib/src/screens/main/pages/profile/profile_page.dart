library profile_page;

import 'package:flutter/material.dart' hide Router;
import '../../../../base/base.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [CurrentUserController],
      builder: (context, snapshot) {
        var model = snapshot<CurrentUserModel>()!;
        return UserProfile(
          user: model.currentUser,
          showBackButton: false,
        );
      },
    );
  }
}
