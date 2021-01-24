library post_page;

import 'package:cupizz_app/src/constants/values.dart';
import 'package:cupizz_app/src/screens/main/pages/post/widgets/action_icon.dart';
import 'package:cupizz_app/src/screens/main/pages/post/widgets/spaces.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'widgets/post_cart.dart';


class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, i) {
          return PostCard();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.pink50,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
