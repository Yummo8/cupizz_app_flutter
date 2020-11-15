import 'package:cupizz_app/src/screens/main/pages/profile/sub_edit_screen/edit_pictrues_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartImage extends StatelessWidget {
  final String imageUrl;

  const CartImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    // TODO: implement build
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 4.0, bottom: 10.0),
          height: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
        Positioned(
          right: -10,
          bottom: 20,
          child: RawMaterialButton(
            elevation: 2.0,
            padding: EdgeInsets.all(10.0),
            shape: CircleBorder(),
            fillColor: Colors.white,
            child: Icon(
              Icons.edit,
              color: _theme.primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPicturesScreen(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
