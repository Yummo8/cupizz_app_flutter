part of '../user_screen.dart';

class UserScreenController extends MomentumController<_UserScreenModel> {
  @override
  _UserScreenModel init() {
    return _UserScreenModel(
      this,
    );
  }

  Future refresh() async {
    if (model.user == null) return;

    final user = await getService<UserService>().getUser(id: model.user.id);
    model.update(user: user);
  }

  Future loadData({String userId, ChatUser chatUser}) async {
    if (chatUser == null && userId == null) return;

    if (chatUser != null) {
      model.update(user: chatUser);
    }
    if (chatUser is! SimpleUser && chatUser is! User) {
      final user =
          await getService<UserService>().getUser(id: chatUser?.id ?? userId);
      model.update(user: user);
    }
    UserProfileState.lastScrollOffset = 0;
  }

  Future addFriend() async {
    model.update(isLoading: true);
    try {
      if (model.user.friendType == FriendType.received) {
        await getService<UserService>().addFriend(model.user.id);
        await refresh();
      }
    } catch (e) {
      await Fluttertoast.showToast(msg: e.toString());
      rethrow;
    } finally {
      model.update(isLoading: false);
    }
  }
}
