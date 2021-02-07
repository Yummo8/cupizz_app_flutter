import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/screens/main/pages/post/components/post_page.controller.dart';
import 'package:flutter/gestures.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      enabled: post == null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _PostHeader(post: post),
            _PostBody(post: post),
          ],
        ),
      ),
    );
  }
}

class _PostBody extends StatelessWidget {
  final Post post;
  const _PostBody({Key key, @required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textColor = getTextColorFromColor(
        post?.category?.color ?? context.colorScheme.background);
    return SkeletonItem(
      child: Card(
        elevation: 4,
        shadowColor: context.colorScheme.onSurface,
        color: post?.category?.color ?? context.colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 15.0)
              .copyWith(bottom: 5),
          child: post == null
              ? Container(height: 100)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(post?.content ?? '',
                          style: context.textTheme.bodyText1
                              .copyWith(color: textColor)),
                    ),
                    const SizedBox(height: 20.0),
                    _PostAction(post: post)
                  ],
                ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;
  const _PostHeader({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: _PostName(post: post),
    );
  }
}

class _PostName extends StatelessWidget {
  final Post post;

  const _PostName({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SkeletonItem(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onBackground),
                children: [
                  TextSpan(text: post == null ? 'Loading' : '#${post.id} • '),
                  TextSpan(
                      text:
                          post == null ? 'Loading' : '${post.category?.value}',
                      recognizer: TapGestureRecognizer()
                        ..onTap = post?.category == null
                            ? null
                            : () {
                                Momentum.controller<PostPageController>(context)
                                    .selectCategory(post.category);
                              }),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
          SkeletonItem(
            child: Text(
              post != null ? TimeAgo.format(post.createdAt) : 'Loading',
              style: TextStyle(
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostAction extends StatelessWidget {
  final Post post;

  const _PostAction({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final color = getTextColorFromColor(
        post?.category?.color ?? context.colorScheme.background);
    var iconTextStyle = theme.textTheme.subtitle1.copyWith(color: color);
    return IntrinsicHeight(
      child: Row(
        children: [
          ActionIcon(
            onTap: () {
              final _c = Momentum.controller<PostPageController>(context);
              if (post.myLikedPostType == null) {
                _c.likePost(post);
              } else {
                _c.unlikePost(post);
              }
            },
            title: post.totalReaction.toString(),
            iconData: post.myLikedPostType != null
                ? Icons.favorite
                : Icons.favorite_border_sharp,
            isHorizontal: true,
            titleStyle: iconTextStyle,
            color: color,
            hasTitle: post.totalReaction > 0,
          ),
          const SizedBox(width: 16),
          ActionIcon(
            onTap: () => {},
            title: post.commentCount.toString(),
            iconData: CupertinoIcons.chat_bubble_2,
            isHorizontal: true,
            color: color,
            titleStyle: iconTextStyle,
            hasTitle: post.commentCount > 0,
          ),
          Spacer(),
          IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.share,
                  color: post.category.color ?? context.colorScheme.background),
              onPressed: () {
                Fluttertoast.showToast(msg: 'Tính năng đang phát triển mà 😞');
              })
        ],
      ),
    );
  }
}

class ActionIcon extends StatelessWidget {
  ActionIcon({
    this.iconData,
    this.color = Colors.grey,
    this.title,
    this.size,
    this.hasTitle = true,
    this.isHorizontal = false,
    this.titleStyle,
    this.onTap,
  }) : assert(hasTitle == false || title != null);

  final IconData iconData;
  final double size;
  final Color color;
  final String title;
  final TextStyle titleStyle;
  final bool hasTitle;
  final bool isHorizontal;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      child: !isHorizontal
          ? Column(
              children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      iconData,
                      size: size,
                      color: color,
                    ),
                    onPressed: onTap),
                hasTitle
                    ? InkWell(
                        onTap: onTap,
                        child: Text(
                          title,
                          style: titleStyle ??
                              theme.textTheme.bodyText1
                                  .copyWith(color: Colors.grey, fontSize: 14),
                        ),
                      )
                    : Container()
              ],
            )
          : Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    iconData,
                    size: size,
                    color: color,
                  ),
                  onPressed: onTap,
                ),
                hasTitle
                    ? InkWell(
                        onTap: onTap,
                        child: Text(
                          title,
                          style: titleStyle ??
                              theme.textTheme.bodyText1
                                  .copyWith(color: Colors.grey, fontSize: 14),
                        ),
                      )
                    : Container()
              ],
            ),
    );
  }
}
