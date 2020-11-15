part of '../index.dart';

class HobbyListController extends MomentumController<HobbyListModel> {
  @override
  HobbyListModel init() {
    return HobbyListModel(
      this,
    );
  }

  Future loadHobbies() {}
}
