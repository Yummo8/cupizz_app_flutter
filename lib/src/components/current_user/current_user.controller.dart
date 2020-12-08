part of '../index.dart';

enum CurrentUserEventAction {
  newUserImage,
}

class CurrentUserEvent {
  final CurrentUserEventAction action;
  final String message;

  CurrentUserEvent({@required this.action, this.message});
}

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
      model.update(isUpdatingCover: true);
      await updateProfile(cover: cover);
    } catch (e) {
      debugPrint(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    } finally {
      model.update(isUpdatingCover: false);
    }
  }

  Future updateAvatar(io.File avatar) async {
    try {
      model.update(isUpdatingAvatar: true);
      await updateProfile(avatar: avatar);
    } catch (e) {
      debugPrint(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    } finally {
      model.update(isUpdatingAvatar: false);
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
    DateTime birthday,
    io.File avatar,
    io.File cover,
    double latitude,
    double longitude,
    EducationLevel educationLevel,
    UsualType smoking,
    UsualType drinking,
    HaveKids yourKids,
    List<LookingFor> lookingFors,
    Religious religious,
  }) async {
    final currentUser = model.currentUser.clone<User>();
    if (nickName != null) currentUser.nickName = nickName;
    if (introduction != null) currentUser.introduction = introduction;
    if (gender != null) currentUser.gender = gender;
    if (hobbies != null) currentUser.hobbies = hobbies;
    if (phoneNumber != null) currentUser.phoneNumber = phoneNumber;
    if (job != null) currentUser.job = job;
    if (height != null) currentUser.height = height;
    if (birthday != null) {
      currentUser.birthday = birthday;
      currentUser.age = birthday.getAge();
    }
    if (educationLevel != null) currentUser.educationLevel = educationLevel;
    if (smoking != null) currentUser.smoking = smoking;
    if (drinking != null) currentUser.drinking = drinking;
    if (yourKids != null) currentUser.yourKids = yourKids;
    if (lookingFors != null) currentUser.lookingFors = lookingFors;
    if (religious != null) currentUser.religious = religious;

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
        birthday: birthday,
        latitude: latitude,
        longitude: longitude,
        educationLevel: educationLevel,
        smoking: smoking,
        drinking: drinking,
        yourKids: yourKids,
        lookingFors: lookingFors,
        religious: religious,
      );
      model.update(currentUser: result);
      if (hobbies != null || longitude != null || latitude != null) {
        unawaited(
            dependOn<RecommendableUsersController>().fetchRecommendableUsers());
      }
    } catch (e) {
      backward();
      unawaited(Fluttertoast.showToast(msg: e.toString()));
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

  Future addImage(io.File image) async {
    try {
      model.update(isAddingImage: true);
      final service = getService<UserService>();
      final userImage = await service.addImage(image);
      model.currentUser.userImages.add(userImage);
      model.update(currentUser: model.currentUser);
      unawaited(getCurrentUser());
      sendEvent(CurrentUserEvent(action: CurrentUserEventAction.newUserImage));
    } catch (e) {
      debugPrint(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    } finally {
      model.update(isAddingImage: false);
    }
  }

  Future addAnswer(UserImage userImage) async {
    try {
      model.currentUser.userImages.add(userImage);
      model.update(currentUser: model.currentUser);
      unawaited(getCurrentUser().then((value) => sendEvent(
          CurrentUserEvent(action: CurrentUserEventAction.newUserImage))));
    } catch (e) {
      debugPrint(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    }
  }
}
