part of 'index.dart';

class ChatUser extends BaseModel {
  String nickName;
  FileModel avatar;
  OnlineStatus onlineStatus;
  DateTime lastOnline;

  String get displayName => nickName;

  ChatUser({
    String id,
    this.nickName,
    this.avatar,
    this.onlineStatus,
    this.lastOnline,
  }) : super(id: id);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('data.nickName', nickName, (v) => nickName = v);
    map<FileModel>('data.avatar', avatar, (v) => avatar = v);
    map('data.onlineStatus', onlineStatus, (v) => onlineStatus = v,
        EnumTransform<OnlineStatus, String>());
    map('data.lastOnline', lastOnline, (v) => lastOnline = v, DateTransform());
  }

  static String get graphqlQuery => '''
  {
    id
    data {
      nickName
      avatar ${FileModel.graphqlQuery}
      onlineStatus
      lastOnline
    }
  }''';
}
