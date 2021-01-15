import 'package:cupizz_app/src/base/base.dart';

class FriendData with Mappable {
  SimpleUser _friend;
  DateTime _sentAt;
  DateTime _acceptedAt;
  DateTime _updatedAt;
  bool _isSuperLike;

  SimpleUser get friend => _friend;
  DateTime get sentAt => _sentAt;
  DateTime get acceptedAt => _acceptedAt;
  DateTime get updatedAt => _updatedAt;
  bool get isSuperLike => _isSuperLike;

  FriendData({
    SimpleUser friend,
    DateTime sentAt,
    DateTime acceptedAt,
    DateTime updatedAt,
    bool isSuperLike,
  })  : _friend = friend,
        _sentAt = sentAt,
        _acceptedAt = acceptedAt,
        _updatedAt = updatedAt,
        _isSuperLike = isSuperLike;

  @override
  void mapping(Mapper map) {
    map<SimpleUser>('friend', _friend, (v) => _friend = v);
    map('sentAt', _sentAt, (v) => _sentAt = v, DateTransform());
    map('acceptedAt', _acceptedAt, (v) => _acceptedAt = v, DateTransform());
    map('updatedAt', _updatedAt, (v) => _updatedAt = v, DateTransform());
    map('isSuperLike', _isSuperLike, (v) => _isSuperLike = v);
  }

  static String get graphqlQuery =>
      '{friend ${SimpleUser.graphqlQuery} sentAt acceptedAt updatedAt isSuperLike}';
}
