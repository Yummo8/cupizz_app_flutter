import 'package:cupizz_app/src/base/base.dart';

class Message extends BaseModel {
  Conversation _conversation;
  String _message;
  DateTime _createdAt;
  DateTime _updatedAt;
  List<FileModel> _attachments;
  ChatUser _sender;

  String _roomId;
  bool _isCallMessage;
  bool _isCaller;
  DateTime _startedCallAt;
  DateTime _endedCallAt;
  CallStatus _callStatus;
  String _agoraToken;

  Conversation get conversation => _conversation;
  String get message => _message;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  List<FileModel> get attachments => _attachments;
  ChatUser get sender => _sender;
  String get roomId => _roomId;
  bool get isCallMessage => _isCallMessage;
  bool get isCaller => _isCaller;
  DateTime get startedCallAt => _startedCallAt;
  DateTime get endedCallAt => _endedCallAt;
  CallStatus get callStatus => _callStatus;
  String get agoraToken => _agoraToken;

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
    map('roomId', roomId, (v) => _roomId = v);
    map('isCallMessage', isCallMessage, (v) => _isCallMessage = v);
    map('isCaller', isCaller, (v) => _isCaller = v);
    map('startedCallAt', startedCallAt, (v) => _startedCallAt = v,
        DateTransform());
    map('endedCallAt', endedCallAt, (v) => _endedCallAt = v, DateTransform());
    map('callStatus', callStatus, (v) => _callStatus = v,
        EnumTransform<CallStatus, String>());
    map('agoraToken', agoraToken, (v) => _agoraToken = v);
  }

  static String graphqlQuery({bool includeConversation = true}) => '''{ 
    id 
    message 
    ${includeConversation ? 'conversation ${Conversation.graphqlQuery}' : ''}
    createdAt 
    updatedAt 
    attachments ${FileModel.graphqlQuery} 
    sender ${ChatUser.graphqlQuery} 
    roomId
    isCallMessage
    isCaller
    startedCallAt
    endedCallAt
    callStatus
    agoraToken
  }''';
}
