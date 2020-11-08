import 'package:flutter/cupertino.dart';

class CartImage extends StatelessWidget {
  final String imageUrl;

  const CartImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0, top: 4.0),
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
