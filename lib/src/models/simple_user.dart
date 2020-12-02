part of 'index.dart';

class SimpleUser extends ChatUser {
  int age;
  String introduction;
  Gender gender;
  List<Hobby> hobbies;
  String phoneNumber;
  String job;
  int height;
  FriendType friendType;
  String address;
  EducationLevel educationLevel;
  UsualType smoking;
  UsualType drinking;
  HaveKids yourKids;
  LookingFor lookingFor;
  Religious religious;
  List<UserImage> userImages;

  List<HobbyWithIsSelect> _sameHobbies;
  List<HobbyWithIsSelect> getSameHobbies(BuildContext context) {
    if (_sameHobbies == null) {
      final currentUserHobbies = Momentum.of<CurrentUserController>(context)
              .model
              .currentUser
              ?.hobbies ??
          [];

      _sameHobbies = [];
      final userHobbies = [...hobbies] ?? <Hobby>[];

      for (var hobby in userHobbies) {
        if (_sameHobbies.length >= 5) break;
        if (currentUserHobbies.firstWhere((e) => e.id == hobby.id,
                orElse: () => null) !=
            null) {
          _sameHobbies.add(HobbyWithIsSelect(hobby, true));
        }
      }

      if (_sameHobbies.length < 5) {
        _sameHobbies.addAll(userHobbies
            .takeWhile((e) => !currentUserHobbies.contains(e))
            .take(5 - _sameHobbies.length)
            .map((e) => HobbyWithIsSelect(e, false))
            .toList());
      }
      _sameHobbies.shuffle();
    }
    return _sameHobbies;
  }

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('data.age', age, (v) => age = v);
    map('data.introduction', introduction, (v) => introduction = v);
    map('data.gender', gender, (v) => gender = v,
        EnumTransform<Gender, String>());
    map<Hobby>('data.hobbies', hobbies, (v) => hobbies = v);
    map('data.phoneNumber', phoneNumber, (v) => phoneNumber = v);
    map('data.job', job, (v) => job = v);
    map('data.height', height, (v) => height = v);
    map('data.friendType.status', friendType, (v) => friendType = v,
        EnumTransform<FriendType, String>());
    map('data.address', address, (v) => address = v);
    map('data.educationLevel', educationLevel, (v) => educationLevel = v,
        EnumTransform<EducationLevel, String>());
    map('data.smoking', smoking, (v) => smoking = v,
        EnumTransform<UsualType, String>());
    map('data.drinking', drinking, (v) => drinking = v,
        EnumTransform<UsualType, String>());
    map('data.yourKids', yourKids, (v) => yourKids = v,
        EnumTransform<HaveKids, String>());
    map('data.lookingFor', lookingFor, (v) => lookingFor = v,
        EnumTransform<LookingFor, String>());
    map('data.religious', religious, (v) => religious = v,
        EnumTransform<Religious, String>());
    map<UserImage>('data.userImages', userImages, (v) => userImages = v);
  }

  static String get graphqlQuery => '''
  {
    id
    data {
      nickName
      age
      introduction
      gender
      hobbies ${Hobby.graphqlQuery}
      phoneNumber
      job
      height
      avatar ${FileModel.graphqlQuery}
      cover ${FileModel.graphqlQuery}
      friendType {status}
      onlineStatus
      lastOnline
      address
      educationLevel
      smoking
      drinking
      yourKids
      lookingFor
      religious
      userImages ${UserImage.graphqlQuery}
    }
  }''';
}
