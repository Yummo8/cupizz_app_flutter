part of '../user_profile.dart';

class CartImage extends StatelessWidget {
  final UserImage userImage;
  final bool readOnly;

  const CartImage({Key key, this.userImage, this.readOnly = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(top: 4.0, bottom: 10.0),
      child: Stack(
        children: [
          Container(
            height: 300.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: CustomNetworkImage(
              userImage.image.thumbnail,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: (userImage.answer?.color ??
                            userImage.answer?.question?.color)
                        ?.withOpacity(0.7) ??
                    Colors.transparent,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        userImage?.answer?.question?.content ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyText1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          userImage?.answer?.content ?? '',
                          textAlign: TextAlign.center,
                          style: context.textTheme.headline6
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  if (!readOnly)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: RaisedButton(
                          elevation: 2.0,
                          color: context.colorScheme.background,
                          padding: EdgeInsets.all(10.0),
                          shape: CircleBorder(),
                          child: Icon(
                            Icons.edit,
                            color: _theme.primaryColor,
                          ),
                          onPressed: () {
                            Router.goto(context, EditPicturesScreen);
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
