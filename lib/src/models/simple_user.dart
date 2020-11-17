part of 'index.dart';

class SimpleUser extends BaseModel {
  String nickName;
  int age;
  String introduction;
  Gender gender;
  List<Hobby> hobbies;
  String phoneNumber;
  String job;
  int height;
  File avatar;
  File cover;
  OnlineStatus onlineStatus;
  DateTime lastOnline;
  FriendType friendType;

  String get displayName => nickName;

  List<HobbyWithIsSelect> _sameHobbies;
  List<HobbyWithIsSelect> getSameHobbies(BuildContext context) {
    if (_sameHobbies == null) {
      final currentUserHobbies = Momentum.of<CurrentUserController>(context)
              .model
              .currentUser
              ?.hobbies ??
          [];

      _sameHobbies = [];
      List<Hobby> userHobbies = [...hobbies] ?? [];

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

  SimpleUser({
    String id,
    this.nickName,
    this.age,
    this.introduction,
    this.avatar,
    this.cover,
    this.hobbies,
    this.gender,
    this.phoneNumber,
    this.job,
    this.height,
    this.onlineStatus,
    this.lastOnline,
    this.friendType,
  }) : super(id: id);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('data.nickName', nickName, (v) => nickName = v);
    map('data.age', age, (v) => age = v);
    map('data.introduction', introduction, (v) => introduction = v);
    map('data.gender', gender, (v) => gender = v,
        EnumTransform<Gender, String>());
    map<Hobby>('data.hobbies', hobbies, (v) => hobbies = v);
    map('data.phoneNumber', phoneNumber, (v) => phoneNumber = v);
    map('data.job', job, (v) => job = v);
    map('data.height', height, (v) => height = v);
    map<File>('data.avatar', avatar, (v) => avatar = v);
    map<File>('data.cover', cover, (v) => cover = v);
    map('data.onlineStatus', onlineStatus, (v) => onlineStatus = v,
        EnumTransform<OnlineStatus, String>());
    map('data.lastOnline', lastOnline, (v) => lastOnline = v, DateTransform());
    map('data.friendType.status', friendType, (v) => friendType = v,
        EnumTransform<FriendType, String>());
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
      avatar ${File.graphqlQuery}
      cover ${File.graphqlQuery}
      friendType {status}
      onlineStatus
      lastOnline
    }
  }''';
}
