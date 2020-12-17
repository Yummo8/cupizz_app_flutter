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
      model.update(
          colorsOfAnswer:
              await getService<SystemService>().getColorsOfAnswer());
    });
  }

  Future getUnreadMessageCount() async {
    await trycatch(() async {
      model.update(
          unreadMessageCount:
              await getService<SystemService>().getUnreadMessageCount());
    });
  }
}
