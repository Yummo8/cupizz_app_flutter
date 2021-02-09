import 'package:cupizz_app/src/base/base.dart';

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
      final hobbies = await Get.find<SystemService>().getAllHobbies();
      model.update(hobbies: hobbies);
    } catch (e) {
      model.update(error: e.toString());
    }
  }
}
