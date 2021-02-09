import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/screens/main/pages/post/components/post_page.controller.dart';
import 'package:cupizz_app/src/screens/main/pages/post/components/post_page.model.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'comment_item.dart';

class CommentBottomSheet {
  final BuildContext context;
  final Post post;
  final int totalLike;
  final bool autoFocusInput;

  CommentBottomSheet(
    this.context, {
    @required this.post,
    @required this.totalLike,
    this.autoFocusInput = false,
  }) : assert(post != null);

  Future show() async {
    final inputController = TextEditingController();
    final sheetController = SheetController();

    await showSlidingBottomSheet(
      context,
      useRootNavigator: true,
      builder: (context) {
        return SlidingSheetDialog(
          controller: sheetController,
          snapSpec: SnapSpec(snappings: [0.9, 0.7], initialSnap: 0.9),
          cornerRadius: 10,
          color: context.colorScheme.background,
          headerBuilder: (context, state) {
            return totalLike == null
                ? SizedBox.shrink()
                : Material(
                    color: context.colorScheme.background,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: context.colorScheme.surface),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.favorite,
                                color: context.colorScheme.primary),
                            const SizedBox(width: 10),
                            Text(
                              '$totalLike người yêu thích',
                              style: context.textTheme.subtitle1.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
          footerBuilder: (context, state) {
            return Material(
              color: context.colorScheme.background,
              child: MomentumBuilder(
                  controllers: [PostPageController],
                  builder: (context, snapshot) {
                    final model = snapshot<PostPageModel>();
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                        top: BorderSide(
                            width: 1, color: context.colorScheme.surface),
                      )),
                      child: ListView(
                        shrinkWrap: true,
                        itemExtent: null,
                        padding: EdgeInsets.zero,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                model.controller.changeIsIncognitoComment();
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    value: model.isIncognitoComment,
                                    activeColor: context.colorScheme.primary,
                                    onChanged: (_) {
                                      model.controller
                                          .changeIsIncognitoComment();
                                    },
                                  ),
                                  Text(
                                    'Bình luận ẩn danh',
                                    style: context.textTheme.bodyText1.copyWith(
                                      color: model.isIncognitoComment
                                          ? context.colorScheme.primary
                                          : context.colorScheme.onBackground,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          TextField(
                            controller: inputController,
                            autofocus: autoFocusInput,
                            style: context.textTheme.bodyText2,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: 'Nhập bình luận',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              prefixIcon: AnimatedSwitcher(
                                duration: 500.milliseconds,
                                transitionBuilder: (child, animation) =>
                                    ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                                child: Padding(
                                  key: ValueKey(model.isIncognitoComment),
                                  padding: const EdgeInsets.all(8.0),
                                  child: UserAvatar.fromChatUser(
                                      size: 30,
                                      user: !model.isIncognitoComment
                                          ? Momentum.controller<
                                                      CurrentUserController>(
                                                  context)
                                              .model
                                              .currentUser
                                          : null),
                                ),
                              ),
                              suffixIcon: ArgonButton(
                                height: 30,
                                width: 30,
                                borderRadius: 22.0,
                                roundLoadingShape: false,
                                color: Colors.transparent,
                                child: Icon(
                                  CupertinoIcons.paperplane,
                                  color: context.colorScheme.primary,
                                ),
                                loader: Center(
                                  child: LoadingIndicator(
                                    color: context.colorScheme.primaryVariant,
                                    size: 25,
                                  ),
                                ),
                                onTap: (startLoading, stopLoading,
                                    btnState) async {
                                  startLoading();
                                  try {
                                    await Momentum.controller<
                                            PostPageController>(context)
                                        .commentPost(
                                            post, inputController.text);
                                    inputController.clear();
                                    await sheetController.scrollTo(0);
                                  } finally {
                                    stopLoading();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          },
          builder: (context, state) {
            if (post.commentCount <= 0) {
              return Material(
                color: context.colorScheme.background,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Chưa có bình luận nào hết.\nNhanh nào bạn sẽ là người bình luận đầu tiên.',
                      style: context.textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }
            return MomentumBuilder(
                controllers: [PostPageController],
                builder: (context, snapshot) {
                  final model = snapshot<PostPageModel>();
                  return ListView(
                    itemExtent: null,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      ..._buildListComment(post.comments),
                      if (post.comments.length < post.commentCount)
                        ArgonButton(
                          height: 50,
                          width: context.width,
                          child: Text(
                            'Tải thêm bình luận',
                            style: context.textTheme.button.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                          loader: LoadingIndicator(
                              size: 30,
                              color: context.colorScheme.onBackground),
                          onTap: (startLoading, stopLoading, btnState) async {
                            startLoading();
                            await trycatch(() async {
                              await model.controller.loadmoreComments(post);
                            });
                            stopLoading();
                          },
                        ),
                    ],
                  );
                });
          },
        );
      },
    );
  }

  List<Widget> _buildListComment(List<Comment> comments) {
    return comments
        .mapIndexed((e, index) => FadeInTranslate(
              key: ValueKey(e.id),
              delay: 1,
              delayDuration: 300,
              child: Padding(
                padding: EdgeInsets.only(top: index == 0 ? 8.0 : 0),
                child: CommentItem(comment: e),
              ),
            ))
        .toList();
  }
}
