part of 'index.dart';

class Conversation extends BaseModel {
  String id;
  List<File> avatar;
  String name;
  String message;
  DateTime time;
  bool isOnline;
  int unreadMessages;

  Conversation({
    this.id,
    this.avatar,
    this.name,
    this.message,
    this.time,
    this.isOnline,
    this.unreadMessages,
  }) : super(id: id);

  @override
  void mapping(Mapper map) {
    // TODO immplement mapping
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json["id"],
      avatar: json['avatar'],
      name: json['name'],
      message: json['message'],
      time: json['time'],
    );
  }
}
