part of '../index.dart';

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
    final users = await getService<UserService>().getRecommendableUsers();
    model.update(users: users);
    debugPrint('Fetched ${users.length} recommend users');
  }

  Future onSwipe(BuildContext context, {bool isSwipeRight = false}) async {
    if (model.users.isNotEmpty) {
      final service = getService<UserService>();
      if (isSwipeRight) {
        final friendType = await service.addFriend(model.users[0].id);
        unawaited(dependOn<FriendPageController>().refresh());
        if (friendType == FriendType.friend) {
          _onMatched(context, model.users[0]);
        }
      } else {
        await service.removeFriend(model.users[0].id);
      }
      model.users.removeAt(0);
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
              Router.goto(context, MessagesScreen,
                  params: MessagesScreenParams(
                      ConversationKey(targetUserId: user.id)));
            }),
      ],
      close: popup.close,
    );
  }
}
