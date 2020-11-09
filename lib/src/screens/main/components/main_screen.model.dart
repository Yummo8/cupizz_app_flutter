part of './main_screen.controller.dart';

class MainScreenModel extends MomentumModel<MainScreenController> {
  MainScreenModel(MainScreenController controller, {this.currentTabIndex = 0})
      : super(controller);

  final int currentTabIndex;

  @override
  void update({int currentTabIndex}) {
    MainScreenModel(
      controller,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return MainScreenModel(controller,
        currentTabIndex: json['currentTabIndex']);
  }

  @override
  Map<String, dynamic> toJson() => {'currentTabIndex': currentTabIndex};
}
