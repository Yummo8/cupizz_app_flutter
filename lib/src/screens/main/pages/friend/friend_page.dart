library friend_page;

import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/widgets/index.dart';
import 'package:flutter/material.dart';

const _PADDING = 20.0;

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        HeadingBar(title: Strings.friendPage.title),
        Expanded(
          child: Container(
            color: context.colorScheme.background,
            child: GridView(
              padding: EdgeInsets.all(_PADDING),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: _PADDING,
                mainAxisSpacing: _PADDING,
              ),
              children: Fake.users.map((e) => UserItem(simpleUser: e)).toList(),
            ),
          ),
        )
      ],
    ));
  }
}
