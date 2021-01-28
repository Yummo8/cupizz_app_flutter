import 'package:cupizz_app/src/base/base.dart';

class User extends SimpleUser {
  DateTime birthday;
  int minAgePrefer;
  int maxAgePrefer;
  int minHeightPrefer;
  int maxHeightPrefer;
  int distancePrefer = 0;
  bool allowMatching;
  bool isPrivate;
  bool showActive;
  List<Gender> genderPrefer;
  List<SocialProvider> socialProviders;
  List<NotificationType> pushNotiSetting;
  List<EducationLevel> educationLevelsPrefer;
  HaveKids theirKids;
  List<Religious> religiousPrefer;
  int remainingSuperLike;

  int get getRemainingSuperLike => this?.remainingSuperLike ?? 0;

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('data.birthday', birthday, (v) => birthday = v, DateTransform());
    map('data.minAgePrefer', minAgePrefer, (v) => minAgePrefer = v);
    map('data.maxAgePrefer', maxAgePrefer, (v) => maxAgePrefer = v);
    map('data.minHeightPrefer', minHeightPrefer, (v) => minHeightPrefer = v);
    map('data.maxHeightPrefer', maxHeightPrefer, (v) => maxHeightPrefer = v);
    map('data.distancePrefer', distancePrefer, (v) => distancePrefer = v);
    map<Gender>('data.genderPrefer', genderPrefer, (v) => genderPrefer = v,
        EnumTransform<Gender, String>());
    map<EducationLevel>(
        'data.educationLevelsPrefer',
        educationLevelsPrefer,
        (v) => educationLevelsPrefer = v,
        EnumTransform<EducationLevel, String>());
    map('data.theirKids', theirKids, (v) => theirKids = v,
        EnumTransform<HaveKids, String>());
    map<Religious>('data.religiousPrefer', religiousPrefer,
        (v) => religiousPrefer = v, EnumTransform<Religious, String>());
    map('data.settings.allowMatching', allowMatching, (v) => allowMatching = v);
    map('data.settings.isPrivate', isPrivate, (v) => isPrivate = v);
    map('data.settings.showActive', showActive, (v) => showActive = v);
    map<NotificationType>('data.settings.pushNotiSetting', pushNotiSetting,
        (v) => pushNotiSetting = v, EnumTransform<NotificationType, String>());
    map<SocialProvider>(
        'data.socialProviders', socialProviders, (v) => socialProviders = v);
    map('data.remainingSuperLike', remainingSuperLike,
        (v) => remainingSuperLike = v);
  }

  static String get graphqlQuery => '''
  {
    id
    data {
      nickName
      avatar ${FileModel.graphqlQuery}
      cover ${FileModel.graphqlQuery}
      age
      birthday
      introduction
      gender
      hobbies ${Hobby.graphqlQuery}
      phoneNumber
      job
      height
      address
      educationLevel
      smoking
      drinking
      yourKids
      lookingFors
      religious
      minAgePrefer
      maxAgePrefer
      minHeightPrefer
      maxHeightPrefer
      genderPrefer
      distancePrefer
      educationLevelsPrefer
      theirKids
      religiousPrefer
      friendType { status }
      onlineStatus
      lastOnline
      settings {
        allowMatching
        isPrivate
        showActive
        pushNotiSetting
      }
      socialProviders ${SocialProvider.graphqlQuery}
      userImages ${UserImage.graphqlQuery}
      remainingSuperLike
    }
  }
''';
}
