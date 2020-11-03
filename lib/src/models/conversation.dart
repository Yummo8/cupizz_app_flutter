part of 'index.dart';

class Conversation {
  String id;
  String avatar;
  String name;
  String message;
  String time;

  Conversation({this.id, this.avatar, this.name, this.message, this.time});

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
