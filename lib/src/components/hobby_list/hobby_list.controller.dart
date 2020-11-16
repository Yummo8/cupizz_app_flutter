part of '../index.dart';

class HobbyListController extends MomentumController<HobbyListModel> {
  @override
  HobbyListModel init() {
    return HobbyListModel(
      this,
    );
  }

  bootstrapAsync() => loadHobbies();

  Future loadHobbies() async {
    try {
      this.model.update(isLoading: true);
      final hobbies = await getService<SystemService>().getAllHobbies();
      this.model.update(hobbies: hobbies);
    } catch (e) {
      this.model.update(error: e.toString());
    }
  }
}
