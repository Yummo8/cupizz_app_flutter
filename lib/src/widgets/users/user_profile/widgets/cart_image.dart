part of '../user_profile.dart';

class CartImage extends StatelessWidget {
  final UserImage userImage;
  final bool readOnly;

  const CartImage({Key key, this.userImage, this.readOnly = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return UserImageViewScreen(userImage: userImage);
          },
        ));
      },
      child: Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 10.0),
        child: Stack(
          children: [
            Hero(
              tag: userImage.id,
              child: Container(
                height: userImage.image == null ? 300.0 : null,
                constraints: BoxConstraints(minHeight: 300),
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
                child: userImage?.image != null
                    ? CustomNetworkImage(
                        userImage.image.url,
                        borderRadius: BorderRadius.circular(10.0),
                      )
                    : null,
              ),
            ),
            if (userImage.answer != null)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: userImage?.color?.withOpacity(userImage?.opacity),
                    gradient: userImage != null &&
                            userImage.gradient.isExistAndNotEmpty
                        ? AnswerGradient(userImage.gradient
                            .map((e) => e.withOpacity(userImage.opacity))
                            .toList())
                        : null,
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
                                .copyWith(color: userImage?.textColor),
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
                                  .copyWith(color: userImage?.textColor),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Opacity(
                          opacity: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              userImage?.answer?.question?.content ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodyText1
                                  .copyWith(color: userImage?.textColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (!readOnly)
              Positioned(
                right: 0,
                bottom: 10,
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
                    Router.goto(
                      context,
                      EditUserImagesScreen,
                      params: EditUserImagesScreenParams(userImage),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
