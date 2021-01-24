import 'package:cupizz_app/src/base/base.dart';

class SystemController extends MomentumController<SystemModel> {
  static final SystemController _instance = SystemController._();
  SystemController._();
  factory SystemController() => _instance;

  @override
  SystemModel init() {
    return SystemModel(
      this,
    );
  }

  @override
  Future bootstrapAsync() async {
    await Future.wait([
      fetchColor(),
      fetchUnreadNoti(),
    ]);
  }

  Future fetchColor() async {
    await trycatch(() async {
      final colors = await getService<SystemService>().getColorsOfAnswer();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        model.update(colorsOfAnswer: colors);
      });
    });
  }

  Future fetchUnreadNoti() => Future.wait([
        getUnreadMessageCount(),
        getUnreadReceiveFriendCount(),
        getUnreadAcceptedFriendCount(),
      ]);

  Future getUnreadMessageCount() async {
    await trycatch(() async {
      final unreadMessageCount =
          await getService<SystemService>().getUnreadMessageCount();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        model.update(unreadMessageCount: unreadMessageCount);
      });
    });
  }

  Future getUnreadReceiveFriendCount() async {
    await trycatch(() async {
      final unreadReceiveFriendCount =
          await getService<SystemService>().getUnreadReceiveFriendCount();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        model.update(unreadReceiveFriendCount: unreadReceiveFriendCount);
      });
    });
  }

  Future getUnreadAcceptedFriendCount() async {
    await trycatch(() async {
      final unreadAcceptedFriendCount =
          await getService<SystemService>().getUnreadAcceptedFriendCount();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        model.update(unreadAcceptedFriendCount: unreadAcceptedFriendCount);
      });
    });
  }
}
