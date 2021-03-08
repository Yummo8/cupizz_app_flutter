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
      _fetchAgoraAppId(),
    ]);
  }

  Future fetchColor() async {
    await trycatch(() async {
      final colors = await Get.find<SystemService>().getColorsOfAnswer();
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        model!.update(colorsOfAnswer: colors);
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
          await Get.find<SystemService>().getUnreadMessageCount();
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        model!.update(unreadMessageCount: unreadMessageCount);
      });
    });
  }

  Future getUnreadReceiveFriendCount() async {
    await trycatch(() async {
      final unreadReceiveFriendCount =
          await Get.find<SystemService>().getUnreadReceiveFriendCount();
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        model!.update(unreadReceiveFriendCount: unreadReceiveFriendCount);
      });
    });
  }

  Future getUnreadAcceptedFriendCount() async {
    await trycatch(() async {
      final unreadAcceptedFriendCount =
          await Get.find<SystemService>().getUnreadAcceptedFriendCount();
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        model!.update(unreadAcceptedFriendCount: unreadAcceptedFriendCount);
      });
    });
  }

  Future getPostCategories() async {
    await trycatch(() async {
      final postCategories = await Get.find<PostService>().getPostCategories();
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        model!.update(postCategories: postCategories);
      });
    });
  }

  Future<String?> getAgoraAppId() async {
    if (!model!.agoraAppId.isExistAndNotEmpty) {
      await _fetchAgoraAppId();
    }

    return model!.agoraAppId;
  }

  Future _fetchAgoraAppId() async {
    await trycatch(() async {
      final getAgoraAppId = await Get.find<SystemService>().getAgoraAppId();
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        model!.update(agoraAppId: getAgoraAppId);
      });
    });
  }
}
