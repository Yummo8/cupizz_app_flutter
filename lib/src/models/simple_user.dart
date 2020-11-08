part of 'index.dart';

class SimpleUser extends BaseModel {
  String _nickName;
  int _age;
  String _introduction;
  Gender _gender;
  List<Hobby> _hobbies;
  String _phoneNumber;
  String _job;
  int _height;
  File _avatar;
  OnlineStatus _onlineStatus;
  DateTime _lastOnline;
  FriendType _friendType;

  String get displayName => nickName;
  String get nickName => _nickName;
  int get age => _age;
  String get introduction => _introduction;
  Gender get gender => _gender;
  List<Hobby> get hobbies => _hobbies;
  String get phoneNumber => _phoneNumber;
  String get job => _job;
  int get height => _height;
  File get avatar => _avatar;
  OnlineStatus get onlineStatus => _onlineStatus;
  DateTime get lastOnline => _lastOnline;
  FriendType get friendType => _friendType;

  List<HobbyWithIsSelect> _sameHobbies;
  List<HobbyWithIsSelect> getSameHobbies(BuildContext context) {
    if (_sameHobbies == null) {
      final currentUserHobbies = Momentum.of<CurrentUserController>(context)
              .model
              .currentUser
              ?.hobbies ??
          [];

      _sameHobbies = [];
      List<Hobby> userHobbies = [..._hobbies] ?? [];

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
    String nickname,
    int age,
    String introduction,
    File avatar,
    List<Hobby> hobbies,
    Gender gender,
    String phoneNumber,
    String job,
    int height,
    OnlineStatus onlineStatus,
    DateTime lastOnline,
    FriendType friendType,
  })  : _nickName = nickname,
        _age = age,
        _introduction = introduction,
        _avatar = avatar,
        _hobbies = hobbies,
        _gender = gender,
        _phoneNumber = phoneNumber,
        _job = job,
        _height = height,
        _onlineStatus = onlineStatus,
        _lastOnline = lastOnline,
        _friendType = friendType,
        super(id: id);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('data.nickName', _nickName, (v) => _nickName = v);
    map('data.age', _age, (v) => _age = v);
    map('data.introduction', _introduction, (v) => _introduction = v);
    map('data.gender', _gender, (v) => _gender = v,
        EnumTransform<Gender, String>());
    map<Hobby>('data.hobbies', _hobbies, (v) => _hobbies = v);
    map('data.phoneNumber', _phoneNumber, (v) => _phoneNumber = v);
    map('data.job', _job, (v) => _job = v);
    map('data.height', _height, (v) => _height = v);
    map<File>('data.avatar', _avatar, (v) => _avatar = v);
    map('data.onlineStatus', _onlineStatus, (v) => _onlineStatus = v,
        EnumTransform<OnlineStatus, String>());
    map('data.lastOnline', _lastOnline, (v) => _lastOnline = v,
        DateTransform());
    map('data.friendType.status', _friendType, (v) => _friendType = v,
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
      friendType {status}
      onlineStatus
      lastOnline
    }
  }''';
}
