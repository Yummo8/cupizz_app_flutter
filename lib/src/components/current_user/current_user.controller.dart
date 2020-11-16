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

  Future<void> _updateProfile({
    String nickName,
    String introduction,
    Gender gender,
    List<Hobby> hobbies,
    String phoneNumber,
    String job,
    int height,
    io.File avatar,
  }) async {
    final service = getService<UserService>();
    final result = await service.updateProfile(
      nickName: nickName,
      introduction: introduction,
      gender: gender,
      hobbies: hobbies,
      phoneNumber: phoneNumber,
      job: job,
      height: height,
      avatar: avatar,
    );
    this.model.update(currentUser: result);
    if (hobbies != null) {
      dependOn<RecommendableUsersController>().fetchRecommendableUsers();
    }
  }

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

  Future toggleHobbyButton(Hobby hobby) async {
    final currentUser = this.model.currentUser.clone<User>();
    if (currentUser.hobbies.contains(hobby)) {
      currentUser.hobbies.remove(hobby);
    } else {
      currentUser.hobbies.add(hobby);
    }
    this.model.update(currentUser: currentUser);
    try {
      await this._updateProfile(hobbies: currentUser.hobbies);
    } catch (e) {
      this.backward();
      rethrow;
    }
  }
}
