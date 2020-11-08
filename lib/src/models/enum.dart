part of 'index.dart';

class FileType extends Enumerable<String> {
  final String rawValue;
  const FileType({@required this.rawValue});

  static const image = const FileType(rawValue: 'image');
}

class FriendType extends Enumerable<String> {
  final String rawValue;
  const FriendType({@required this.rawValue});

  static const none = const FriendType(rawValue: 'none');
  static const sent = const FriendType(rawValue: 'sent');
  static const received = const FriendType(rawValue: 'received');
  static const friend = const FriendType(rawValue: 'friend');
  static const me = const FriendType(rawValue: 'me');
}

class OnlineStatus extends Enumerable<String> {
  final String rawValue;
  const OnlineStatus({@required this.rawValue});

  static const online = const FileType(rawValue: 'online');
  static const offline = const FileType(rawValue: 'offline');
}

class Gender extends Enumerable<String> {
  final String rawValue;
  final String displayValue;

  const Gender({@required this.rawValue})
      : displayValue = rawValue == 'male'
            ? 'Nam'
            : rawValue == 'female'
                ? 'Nữ'
                : 'Khác';

  static const male = const FileType(rawValue: 'male');
  static const female = const FileType(rawValue: 'female');
  static const other = const FileType(rawValue: 'other');
}
