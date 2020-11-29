part of '../user_screen.dart';

class UserScreenController extends MomentumController<_UserScreenModel> {
  @override
  _UserScreenModel init() {
    return _UserScreenModel(
      this,
    );
  }

  Future loadData(ChatUser chatUser) async {
    if (chatUser == null) return;
    model.update(user: chatUser);
    if (chatUser is! SimpleUser && chatUser is! User) {
      final user = await getService<UserService>().getUser(id: chatUser.id);
      model.update(user: user);
    }
  }
}
