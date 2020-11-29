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
    model.update(currentUser: result);
  }

  Future toggleGenderButton(Gender gender) async {
    final currentUser = model.currentUser.clone<User>();
    if (currentUser.genderPrefer.contains(gender)) {
      currentUser.genderPrefer.remove(gender);
    } else {
      currentUser.genderPrefer.add(gender);
    }
    await updateSetting(genderPrefer: currentUser.genderPrefer);
  }

  Future toggleHobbyButton(Hobby hobby) async {
    final currentUser = model.currentUser.clone<User>();
    if (currentUser.hobbies.contains(hobby)) {
      currentUser.hobbies.remove(hobby);
    } else {
      currentUser.hobbies.add(hobby);
    }
    await updateProfile(hobbies: currentUser.hobbies);
  }

  Future updateCover(io.File cover) async {
    try {
      model.update(isUpdaingCover: true);
      await updateProfile(cover: cover);
    } catch (e) {
      debugPrint(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    } finally {
      model.update(isUpdaingCover: false);
    }
  }

  Future<void> updateProfile({
    String nickName,
    String introduction,
    Gender gender,
    List<Hobby> hobbies,
    String phoneNumber,
    String job,
    int height,
    io.File avatar,
    io.File cover,
  }) async {
    final currentUser = model.currentUser.clone<User>();
    if (nickName != null) currentUser.nickName = nickName;
    if (introduction != null) currentUser.introduction = introduction;
    if (gender != null) currentUser.gender = gender;
    if (hobbies != null) currentUser.hobbies = hobbies;
    if (phoneNumber != null) currentUser.phoneNumber = phoneNumber;
    if (job != null) currentUser.job = job;
    if (height != null) currentUser.height = height;
    model.update(currentUser: currentUser);

    try {
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
        cover: cover,
      );
      model.update(currentUser: result);
      if (hobbies != null) {
        unawaited(
            dependOn<RecommendableUsersController>().fetchRecommendableUsers());
      }
    } catch (_) {
      backward();
      rethrow;
    }
  }

  Future<void> updateSetting({
    int minAgePrefer,
    int maxAgePrefer,
    int minHeightPrefer,
    int maxHeightPrefer,
    List<Gender> genderPrefer,
    int distancePrefer,
    List<String> mustHaveFields,
  }) async {
    final currentUser = model.currentUser.clone<User>();

    if (minAgePrefer != null) currentUser.minAgePrefer = minAgePrefer;
    if (maxAgePrefer != null) currentUser.maxAgePrefer = maxAgePrefer;
    if (minHeightPrefer != null) currentUser.minHeightPrefer = minHeightPrefer;
    if (maxHeightPrefer != null) currentUser.maxHeightPrefer = maxHeightPrefer;
    if (genderPrefer != null) currentUser.genderPrefer = genderPrefer;
    if (distancePrefer != null) currentUser.distancePrefer = distancePrefer;

    model.update(currentUser: currentUser);

    final service = getService<UserService>();
    await service.updateSetting(
      minAgePrefer: minAgePrefer,
      maxAgePrefer: maxAgePrefer,
      minHeightPrefer: minHeightPrefer,
      maxHeightPrefer: maxHeightPrefer,
      genderPrefer: genderPrefer,
      distancePrefer: distancePrefer,
      mustHaveFields: mustHaveFields,
    );
    unawaited(
        dependOn<RecommendableUsersController>().fetchRecommendableUsers());
  }
}
