import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/screens/main/pages/friend/friend_page.dart';
import 'package:flutter_beautiful_popup/main.dart';

class RecommendableUsersController
    extends MomentumController<RecommendableUsersModel> {
  @override
  RecommendableUsersModel init() {
    return RecommendableUsersModel(this, users: []);
  }

  @override
  Future<void> bootstrapAsync() =>
      model.users.isExistAndNotEmpty ? _reload() : fetchRecommendableUsers();

  Future<void> fetchRecommendableUsers() async {
    try {
      model.update(isLoading: true);
      await _reload();
    } catch (e) {
      model.update(error: e.toString(), isLoading: false);
      rethrow;
    } finally {
      model.update(isLoading: false);
    }
  }

  Future _reload() async {
    final users = await Get.find<UserService>().getRecommendableUsers();
    model.update(users: users, isLastPage: !users.isExistAndNotEmpty);
    debugPrint('Fetched ${users.length} recommend users');
  }

  Future onSwipe(
    BuildContext context, {
    bool isSwipeRight = false,
    bool isSuperLike = false,
    Future waitForUpdateUi,
  }) async {
    if (model.users.isNotEmpty) {
      final service = Get.find<UserService>();
      if (isSwipeRight) {
        if (isSuperLike &&
            dependOn<CurrentUserController>()
                    .model
                    .currentUser
                    .remainingSuperLike <=
                0) {
          await Fluttertoast.showToast(msg: Strings.error.outOfSuperLike);
          return;
        }
        final friendType = await service.addFriend(
          model.users[0].id,
          isSuperLike: isSuperLike,
        );
        if (isSuperLike) {
          await dependOn<CurrentUserController>().reloadRemainingSuperLike();
        }
        unawaited(dependOn<FriendPageController>().refresh());
        if (friendType == FriendType.friend) {
          _onMatched(context, model.users[0]);
        }
      } else {
        await service.removeFriend(model.users[0].id);
      }
      model.users.removeAt(0);
      if (waitForUpdateUi != null) {
        await waitForUpdateUi;
      }
      model.update(users: model.users);
    }
  }

  void _onMatched(BuildContext context, SimpleUser user) {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateGift,
    );

    popup.show(
      title: 'Chúc mừng',
      content:
          'Chúc mừng bạn đã ghép đôi thành công với ${user.displayName}.\n\nBắt đầu tìm hiểu đối phương thôi nào.',
      barrierDismissible: true,
      actions: [
        popup.button(
            label: 'Nhắn tin',
            onPressed: () {
              Get.toNamed(Routes.messages,
                  arguments: MessagesScreenParams(
                      conversationKey: ConversationKey(targetUserId: user.id)));
            }),
      ],
      close: popup.close,
    );
  }
}
