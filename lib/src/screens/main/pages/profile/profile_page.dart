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
