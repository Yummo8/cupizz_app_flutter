part of 'index.dart';

class Conversation extends BaseModel {
  List<File> _images;
  String _name;
  Message _newestMessage;
  OnlineStatus _onlineStatus;
  int _unreadMessages;

  List<File> get images => _images;
  String get name => _name;
  Message get newestMessage => _newestMessage;
  OnlineStatus get onlineStatus => _onlineStatus;
  int get unreadMessages => _unreadMessages;

  Conversation({
    String id,
    List<File> images,
    String name,
    Message newestMessage,
    OnlineStatus onlineStatus,
    int unreadMessageCount,
  }) : super(id: id);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map<File>('data.images', _images, (v) => _images = v);
    map('data.name', _name, (v) => _name = v);
    map<Message>(
        'data.newestMessage', _newestMessage, (v) => _newestMessage = v);
    map('data.onlineStatus', _onlineStatus,
        (v) => _onlineStatus = v, EnumTransform<OnlineStatus, String>());
    map('personalData.unreadMessageCount', _unreadMessages,
        (v) => _unreadMessages = v);
  }

  static String get graphqlQuery => '''{ 
    id 
    data {
      name
      images ${File.graphqlQuery}
      newestMessage ${Message.graphqlQuery(includeConversation: false)}
      onlineStatus
    }
    personalData {
      unreadMessageCount
    }
  }''';
}
