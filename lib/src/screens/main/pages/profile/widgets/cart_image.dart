part of '../profile_screen.dart';

class CartImage extends StatelessWidget {
  final String imageUrl;

  const CartImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 4.0, bottom: 10.0),
          height: 300.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: CustomNetworkImage(imageUrl),
        ),
        Positioned(
          right: -10,
          bottom: 20,
          child: RawMaterialButton(
            elevation: 2.0,
            padding: EdgeInsets.all(10.0),
            shape: CircleBorder(),
            fillColor: context.colorScheme.background,
            child: Icon(
              Icons.edit,
              color: _theme.primaryColor,
            ),
            onPressed: () {
              RouterService.goto(context, EditPicturesScreen);
            },
          ),
        )
      ],
    );
  }
}
