part of '../post_page.dart';

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
    return SkeletonItem(
      child: Card(
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
                              .copyWith(color: context.colorScheme.onPrimary)),
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
            child: Text(
              post == null
                  ? 'Loading'
                  : '#${post.id} • ${post.category?.value}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
          SkeletonItem(
            child: Text(
              post != null ? TimeAgo.format(post.createdAt) : 'Loading',
              style: TextStyle(
                color: AppColors.indigo100,
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
    var iconTextStyle = theme.textTheme.subtitle1.copyWith(
      color: AppColors.white,
    );
    return IntrinsicHeight(
      child: Row(
        children: [
          ActionIcon(
            onTap: () => {},
            title: post.totalReaction.toString(),
            iconData: FeatherIcons.heart,
            isHorizontal: true,
            titleStyle: iconTextStyle,
            color: AppColors.white,
            hasTitle: post.totalReaction > 0,
          ),
          SpaceW16(),
          ActionIcon(
            onTap: () => {},
            title: post.commentCount.toString(),
            iconData: FeatherIcons.messageSquare,
            isHorizontal: true,
            color: AppColors.white,
            titleStyle: iconTextStyle,
            hasTitle: post.commentCount > 0,
          ),
          Spacer(),
          IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(FeatherIcons.share2,
                  color: post.category.color ?? context.colorScheme.background),
              onPressed: () {
                Fluttertoast.showToast(msg: 'Tính năng đang phát triển mà 😞');
              })
        ],
      ),
    );
  }
}
