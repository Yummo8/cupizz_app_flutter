part of 'index.dart';

class Conversation extends BaseModel {
  List<FileModel> _images;
  String _name;
  Message _newestMessage;
  OnlineStatus _onlineStatus;
  DateTime _lastOnline;
  int _unreadMessages;

  List<FileModel> get images => _images;
  String get name => _name;
  Message get newestMessage => _newestMessage;
  OnlineStatus get onlineStatus => _onlineStatus;
  DateTime get lastOnline => _lastOnline;
  int get unreadMessageCount => _unreadMessages;

  Conversation({
    String id,
    List<FileModel> images,
    String name,
    Message newestMessage,
    OnlineStatus onlineStatus,
    int unreadMessageCount,
  }) : super(id: id);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map<FileModel>('data.images', _images, (v) => _images = v);
    map('data.name', _name, (v) => _name = v);
    map<Message>(
        'data.newestMessage', _newestMessage, (v) => _newestMessage = v);
    map('data.onlineStatus', _onlineStatus, (v) => _onlineStatus = v,
        EnumTransform<OnlineStatus, String>());
    map('data.lastOnline', _lastOnline, (v) => _lastOnline = v,
        DateTransform());
    map('personalData.unreadMessageCount', _unreadMessages,
        (v) => _unreadMessages = v);
  }

  static String get graphqlQuery => '''{ 
    id 
    data {
      name
      images ${FileModel.graphqlQuery}
      newestMessage ${Message.graphqlQuery(includeConversation: false)}
      onlineStatus
      lastOnline
    }
    personalData {
      unreadMessageCount
    }
  }''';
}