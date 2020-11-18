part of 'index.dart';

class FriendData with Mappable {
  SimpleUser _friend;
  DateTime _sentAt;
  DateTime _acceptedAt;
  bool _isSuperLike;

  SimpleUser get friend => _friend;
  DateTime get sentAt => _sentAt;
  DateTime get acceptedAt => _acceptedAt;
  bool get isSuperLike => _isSuperLike;

  FriendData({
    SimpleUser friend,
    DateTime sentAt,
    DateTime acceptedAt,
    bool isSuperLike,
  })  : _friend = friend,
        _sentAt = sentAt,
        _acceptedAt = acceptedAt,
        _isSuperLike = isSuperLike;

  @override
  void mapping(Mapper map) {
    map<SimpleUser>('friend', _friend, (v) => _friend = v);
    map('sentAt', _sentAt, (v) => _sentAt = v, DateTransform());
    map('acceptedAt', _acceptedAt, (v) => _acceptedAt = v, DateTransform());
    map('isSuperLike', _isSuperLike, (v) => _isSuperLike = v);
  }

  static String get graphqlQuery =>
      '{friend ${SimpleUser.graphqlQuery} sentAt acceptedAt isSuperLike}';
}
