import 'package:cupizz_app/src/base/base.dart';

class ChatUser extends BaseModel {
  String nickName;
  FileModel avatar;
  FileModel cover;
  OnlineStatus onlineStatus;
  DateTime lastOnline;
  FriendType friendType;

  String get displayName => nickName;

  bool get meOrFriend =>
      friendType == FriendType.me || friendType == FriendType.friend;

  bool get isCurrentUser => friendType == FriendType.me;

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('data.nickName', nickName, (v) => nickName = v);
    map<FileModel>('data.avatar', avatar, (v) => avatar = v);
    map<FileModel>('data.cover', cover, (v) => cover = v);
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
      avatar ${FileModel.graphqlQuery}
      cover ${FileModel.graphqlQuery}
      onlineStatus
      lastOnline
      friendType {status}
    }
  }''';
}
