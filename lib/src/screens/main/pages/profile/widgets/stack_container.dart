import 'package:cupizz_app/src/helpers/index.dart';
import 'package:flutter/material.dart';

import 'custom_clipper.dart';

class StackContainer extends StatelessWidget {
  const StackContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    const opacity = 0.3;
    // TODO: implement build
    SizeHelper sizeHelper = SizeHelper(context);
    return Container(
      height: sizeHelper.rH(45),
      child: Stack(
        children: [
          ClipPath(
            clipper: BackgroudClipper(),
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: _theme.primaryColor)),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://static.onecms.io/wp-content/uploads/sites/20/2017/05/alexandra-daddario-womens-health-1-2000.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: PinkOneClipper(),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: _theme.primaryColor),
                ),
                color: _theme.primaryColor.withOpacity(opacity),
              ),
            ),
          ),
          ClipPath(
            clipper: PinkTwoClipper(),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.pink[300]),
                ),
                color: _theme.primaryColor.withOpacity(opacity),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width / 12,
            child: Container(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                          width: 1,
                          color: Colors.pink[300],
                          style: BorderStyle.solid)),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://celebmafia.com/wp-content/uploads/2020/05/alexandra-daddario-instagram-photos-05-16-2020-5.jpg"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
