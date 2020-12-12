import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart' hide Router;

import '../../base/base.dart';

class UserImageViewScreen extends StatelessWidget {
  final UserImage userImage;

  const UserImageViewScreen({Key key, this.userImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userImage == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pop(context);
      });
    }
    final haveImageBackground = userImage?.image != null;
    return userImage == null
        ? LoadingIndicator()
        : PrimaryScaffold(
            onBack: () {
              Navigator.pop(context);
            },
            body: Hero(
              tag: userImage.id,
              child: Container(
                decoration: haveImageBackground
                    ? BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              CachedNetworkImageProvider(userImage?.image?.url),
                        ),
                      )
                    : null,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Opacity(
                        opacity:
                            haveImageBackground ? Config.userImageOpacity : 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: userImage.gradient != null &&
                                      userImage.gradient.length > 1
                                  ? null
                                  : userImage.color,
                              gradient: userImage.gradient != null &&
                                      userImage.gradient.length > 1
                                  ? AnswerGradient(userImage.gradient)
                                  : null),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        BackAppBar(
                          title: '',
                          onBackPressed: () {
                            Navigator.pop(context);
                          },
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          textColor: userImage.textColor,
                        ),
                        Expanded(
                          child: Container(
                            height: context.height,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                if (userImage.answer?.question != null
                                    ? userImage.answer.question.content
                                        .isExistAndNotEmpty
                                    : false) ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: InkWell(
                                          onTap: null,
                                          child: Text(
                                            userImage.answer.question.content,
                                            style: context.textTheme.bodyText1
                                                .copyWith(
                                                    color: userImage.textColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                                if (userImage.answer != null)
                                  Expanded(
                                    child: Center(
                                      child: TextFormField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        textAlign: TextAlign.center,
                                        style: context.textTheme.headline6
                                            .copyWith(
                                                color: userImage.textColor),
                                        readOnly: true,
                                        initialValue:
                                            userImage.answer?.content ?? '',
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Câu trả lời ...',
                                          hintStyle: context.textTheme.headline6
                                              .copyWith(
                                                  color: userImage.textColor),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
