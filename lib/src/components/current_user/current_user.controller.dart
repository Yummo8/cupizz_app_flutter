part of '../index.dart';

class CurrentUserController extends MomentumController<CurrentUserModel> {
  @override
  CurrentUserModel init() {
    return CurrentUserModel(
      this,
      currentUser: null,
    );
  }

  Future<void> getCurrentUser() async {
    final service = getService<UserService>();
    final result = await service.getCurrentUser();
    this.model.update(currentUser: result);
  }

  // ignore: unused_element Chưa dùng
  Future<void> _updateSetting({
    int minAgePrefer,
    int maxAgePrefer,
    int minHeightPrefer,
    int maxHeightPrefer,
    List<Gender> genderPrefer,
    int distancePrefer,
    List<String> mustHaveFields,
  }) async {
    final service = getService<UserService>();
    final result = await service.updateSetting(
      minAgePrefer: minAgePrefer,
      maxAgePrefer: maxAgePrefer,
      minHeightPrefer: minHeightPrefer,
      maxHeightPrefer: maxHeightPrefer,
      genderPrefer: genderPrefer,
      distancePrefer: distancePrefer,
      mustHaveFields: mustHaveFields,
    );
    this.model.update(currentUser: result);
    dependOn<RecommendableUsersController>().fetchRecommendableUsers();
  }

  Future toggleGenderButton(Gender gender) async {
    final currentUser = this.model.currentUser.clone<User>();
    if (currentUser.genderPrefer.contains(gender)) {
      currentUser.genderPrefer.remove(gender);
    } else {
      currentUser.genderPrefer.add(gender);
    }
    this.model.update(currentUser: currentUser);
    try {
      await this._updateSetting(genderPrefer: currentUser.genderPrefer);
    } catch (e) {
      this.backward();
      rethrow;
    }
  }
}
