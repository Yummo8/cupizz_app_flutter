part of '../index.dart';

class HobbyListController extends MomentumController<HobbyListModel> {
  @override
  HobbyListModel init() {
    return HobbyListModel(
      this,
    );
  }

  @override
  Future<void> bootstrapAsync() => loadHobbies();

  Future loadHobbies() async {
    try {
      model.update(isLoading: true);
      final hobbies = await getService<SystemService>().getAllHobbies();
      model.update(hobbies: hobbies);
    } catch (e) {
      model.update(error: e.toString());
    }
  }
}
