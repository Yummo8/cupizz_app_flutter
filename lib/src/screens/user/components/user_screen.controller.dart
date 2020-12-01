part of '../user_screen.dart';

class UserScreenController extends MomentumController<_UserScreenModel> {
  @override
  _UserScreenModel init() {
    return _UserScreenModel(
      this,
    );
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
  }
}
