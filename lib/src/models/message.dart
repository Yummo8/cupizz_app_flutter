part of 'index.dart';

class Message extends BaseModel {
  Conversation _conversation;
  String _message;
  DateTime _createdAt;
  DateTime _updatedAt;
  List<FileModel> _attachments;
  ChatUser _sender;

  Conversation get conversation => _conversation;
  String get message => _message;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  List<FileModel> get attachments => _attachments;
  ChatUser get sender => _sender;

  Message({
    String id,
    Conversation conversation,
    String message,
    DateTime createdAt,
    DateTime updatedAt,
    List<FileModel> attachments,
    ChatUser sender,
  })  : _conversation = conversation,
        _message = message,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _attachments = attachments,
        _sender = sender,
        super(id: id);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map<Conversation>('conversation', _conversation, (v) => _conversation = v);
    map('message', _message, (v) => _message = v);
    map('createdAt', _createdAt, (v) => _createdAt = v, DateTransform());
    map('updatedAt', _updatedAt, (v) => _updatedAt = v, DateTransform());
    map<FileModel>('attachments', _attachments, (v) => _attachments = v);
    map<ChatUser>('sender', _sender, (v) => _sender = v);
  }

  static String graphqlQuery({bool includeConversation = true}) => '''{ 
    id 
    message 
    ${includeConversation ? 'conversation ${Conversation.graphqlQuery}' : ''}
    createdAt 
    updatedAt 
    attachments ${FileModel.graphqlQuery} 
    sender ${ChatUser.graphqlQuery} 
  }''';
}
