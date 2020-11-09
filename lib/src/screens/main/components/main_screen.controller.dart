library main_screen_component;

import '../../../base/base.dart';

part './main_screen.model.dart';

class MainScreenController extends MomentumController<MainScreenModel> {
  @override
  MainScreenModel init() {
    return MainScreenModel(this);
  }

  void changeTab(int index) {
    if (index != this.model.currentTabIndex && index >= 0 && index < 4) {
      this.model.update(currentTabIndex: index);
    }
  }
}
