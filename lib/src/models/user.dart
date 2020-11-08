part of 'index.dart';

class User extends SimpleUser {
  DateTime _birthday;
  int _minAgePrefer;
  int _maxAgePrefer;
  int _distancePrefer;
  bool _allowMatching;
  bool _isPrivate;
  bool _showActive;
  List<Gender> _genderPrefer;
  FriendType _friendType;

  DateTime get birthday => _birthday;
  int get minAgePrefer => _minAgePrefer;
  int get maxAgePrefer => _maxAgePrefer;
  int get distancePrefer => _distancePrefer;
  bool get allowMatching => _allowMatching;
  bool get isPrivate => _isPrivate;
  bool get showActive => _showActive;
  List<Gender> get genderPrefer => _genderPrefer;
  FriendType get friendType => _friendType;

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
    DateTime birthday,
    int minAgePrefer,
    int maxAgePrefer,
    int distancePrefer,
    bool allowMatching,
    bool isPrivate,
    bool showActive,
    List<Gender> genderPrefer,
    FriendType friendType,
  })  : _birthday = birthday,
        _minAgePrefer = minAgePrefer,
        _maxAgePrefer = maxAgePrefer,
        _distancePrefer = distancePrefer,
        _allowMatching = allowMatching,
        _isPrivate = isPrivate,
        _showActive = showActive,
        _genderPrefer = genderPrefer,
        _friendType = friendType,
        super(
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
        );

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('data.birthday', _birthday, (v) => _birthday = v, DateTransform());
    map('data.minAgePrefer', _minAgePrefer, (v) => _minAgePrefer = v);
    map('data.maxAgePrefer', _maxAgePrefer, (v) => _maxAgePrefer = v);
    map('data.distancePrefer', _distancePrefer, (v) => _distancePrefer = v);
    map<Gender>('data.genderPrefer', _genderPrefer, (v) => _genderPrefer = v,
        EnumTransform<Gender, String>());
    map('data.settings.allowMatching', _allowMatching,
        (v) => _allowMatching = v);
    map('data.settings.isPrivate', _isPrivate, (v) => _isPrivate = v);
    map('data.settings.showActive', _showActive, (v) => _showActive = v);
    map('data.friendType.status', _friendType, (v) => _friendType = v,
        EnumTransform<FriendType, String>());
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
    }
  }
''';
}
