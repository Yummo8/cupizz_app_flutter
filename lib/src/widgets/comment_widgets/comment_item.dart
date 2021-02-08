import 'package:cupizz_app/src/base/base.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({Key key, @required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      enabled: comment == null,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom:
                  BorderSide(width: 0.5, color: context.colorScheme.surface),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: context.colorScheme.background,
                    child: ClipOval(
                      child: Image.asset(
                        Assets.images.defaultAvatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SkeletonItem(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '#' +
                                    (comment?.index?.toString() ?? 'Loading') +
                                    ' • ',
                                style: context.textTheme.subtitle1.copyWith(
                                  color: context.colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: TimeAgo.format(
                                    comment?.createdAt ?? DateTime.now()),
                                style: context.textTheme.bodyText2.copyWith(
                                    color: context.colorScheme.onSurface),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SkeletonItem(
                        child: Text(
                          comment?.content ?? 'Loading comment content\n',
                          style: context.textTheme.bodyText2,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
