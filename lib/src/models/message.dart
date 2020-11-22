part of 'index.dart';

class Message extends BaseModel {
  Conversation _conversation;
  String _message;
  DateTime _createdAt;
  DateTime _updatedAt;
  List<File> _attachments;
  SimpleUser _sender;

  Conversation get conversation => _conversation;
  String get message => _message;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  List<File> get attachments => _attachments;
  SimpleUser get sender => _sender;

  Message({
    String id,
    Conversation conversation,
    String message,
    DateTime createdAt,
    DateTime updatedAt,
    List<File> attachments,
    SimpleUser sender,
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
    map<File>('attachments', _attachments, (v) => _attachments = v);
    map<SimpleUser>('sender', _sender, (v) => _sender = v);
  }

  static String graphqlQuery({bool includeConversation = true}) => '''{ 
    id 
    message 
    ${includeConversation ? 'conversation ${Conversation.graphqlQuery}' : ''}
    createdAt 
    updatedAt 
    attachments ${File.graphqlQuery} 
    sender ${SimpleUser.graphqlQuery} 
  }''';
}
