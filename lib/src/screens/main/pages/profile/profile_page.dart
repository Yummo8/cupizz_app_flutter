library profile_page;

import 'package:cupizz_app/src/components/auth/auth.controller.dart';
import 'package:cupizz_app/src/components/current_user/index.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:momentum/momentum.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
