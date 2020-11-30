library user_setting_screen;

import '../../base/base.dart';
import 'package:flutter/material.dart';

class UserSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MomentumBuilder(
                  controllers: [CurrentUserController],
                  builder: (context, snapshot) {
                    var model = snapshot<CurrentUserModel>();
                    return Text(model.currentUser?.nickName ?? 'No User');
                  }),
              TextButton(
                onPressed: () {
                  Momentum.of<AuthController>(context).logout();
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
