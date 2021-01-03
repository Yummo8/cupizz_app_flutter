part of '../index.dart';

class SystemController extends MomentumController<SystemModel> {
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
      getUnreadMessageCount(),
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

  Future getUnreadMessageCount() async {
    await trycatch(() async {
      final unreadMessageCount =
          await getService<SystemService>().getUnreadMessageCount();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        model.update(unreadMessageCount: unreadMessageCount);
      });
    });
  }
}
