part of '../user_screen.dart';

class UserScreenController extends MomentumController<_UserScreenModel> {
  @override
  _UserScreenModel init() {
    return _UserScreenModel(
      this,
    );
  }

  Future refresh() async {
    if (model!.user == null) return;

    final user = await Get.find<UserService>().getUser(id: model!.user!.id);
    model!.update(user: user);
  }

  Future loadData({String? userId, ChatUser? chatUser}) async {
    if (chatUser == null && userId == null) return;

    if (chatUser is SimpleUser || chatUser is User) {
      model!.update(user: chatUser as SimpleUser?);
    } else {
      await _loading(() async {
        final user =
            await Get.find<UserService>().getUser(id: chatUser?.id ?? userId);
        model!.update(user: user);
      });
    }
    unawaited(
        Get.find<UserService>().readFriendRequest(model!.user!.id).then((value) {
      dependOn<FriendPageV2Controller>().updateReadFriendRequest(model!.user!.id);
      dependOn<SystemController>().fetchUnreadNoti();
    }));
    UserProfileState.lastScrollOffset = 0;
  }

  Future addFriend() async {
    model!.update(isLoading: true);
    try {
      if (model!.user!.friendType == FriendType.received) {
        await Get.find<UserService>().addFriend(model!.user!.id);
        await refresh();
      }
    } catch (e) {
      await Fluttertoast.showToast(msg: e.toString());
      rethrow;
    } finally {
      model!.update(isLoading: false);
    }
  }

  Future _loading(Function func,
      {bool throwError = false, bool enableLoading = true}) async {
    if (enableLoading) {
      model!.update(isLoading: true);
    }
    try {
      await func();
    } catch (e) {
      unawaited(Fluttertoast.showToast(msg: e.toString()));
      if (throwError) rethrow;
    } finally {
      if (enableLoading) {
        model!.update(isLoading: false);
      }
    }
  }
}
