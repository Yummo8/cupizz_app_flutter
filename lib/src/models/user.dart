part of 'index.dart';

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

  User({
    String id,
    String name,
    File avatar,
    int age,
    String bio,
    List<Hobby> hobbies,
    Gender gender,
    int height,
    String job,
    DateTime lastOnline,
    OnlineStatus onlineStatus,
    String phoneNumber,
    FriendType friendType,
    this.birthday,
    this.minAgePrefer,
    this.maxAgePrefer,
    this.minHeightPrefer,
    this.maxHeightPrefer,
    this.distancePrefer,
    this.allowMatching,
    this.isPrivate,
    this.showActive,
    this.genderPrefer,
  }) : super(
          id: id,
          age: age,
          avatar: avatar,
          nickname: name,
          introduction: bio,
          hobbies: hobbies,
          gender: gender,
          height: height,
          job: job,
          lastOnline: lastOnline,
          onlineStatus: onlineStatus,
          phoneNumber: phoneNumber,
          friendType: friendType,
        );

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
    map('data.settings.allowMatching', allowMatching, (v) => allowMatching = v);
    map('data.settings.isPrivate', isPrivate, (v) => isPrivate = v);
    map('data.settings.showActive', showActive, (v) => showActive = v);
    map<SocialProvider>(
        'data.socialProviders', socialProviders, (v) => socialProviders = v);
  }

  static String get graphqlQuery => '''
  {
    id
    data {
      nickName
      avatar ${File.graphqlQuery}
      age
      birthday
      introduction
      gender
      hobbies ${Hobby.graphqlQuery}
      phoneNumber
      job
      height
      minAgePrefer
      maxAgePrefer
      minHeightPrefer
      maxHeightPrefer
      genderPrefer
      distancePrefer
      friendType { status }
      onlineStatus
      lastOnline
      settings {
        allowMatching
        isPrivate
        showActive
      }
      socialProviders ${SocialProvider.graphqlQuery}
    }
  }
''';
}
