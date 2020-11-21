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

class FriendQueryType extends Enumerable<String> {
  final String rawValue;
  final String displayValue;

  const FriendQueryType({
    @required this.rawValue,
  }) : displayValue = rawValue == 'all'
            ? 'Tất cả'
            : rawValue == 'friend'
                ? 'Đã phù hợp'
                : rawValue == 'sent'
                    ? 'Đã thích'
                    : rawValue == 'received'
                        ? 'Thích bạn'
                        : '';

  static const all = const FriendQueryType(rawValue: 'all');
  static const friend = const FriendQueryType(rawValue: 'friend');
  static const sent = const FriendQueryType(rawValue: 'sent');
  static const received = const FriendQueryType(rawValue: 'received');

  static List<FriendQueryType> getAll() => [all, friend, sent, received];
}

class FriendQueryOrderBy extends Enumerable<String> {
  final String rawValue;
  final String displayValue;

  const FriendQueryOrderBy({@required this.rawValue})
      : displayValue = rawValue == 'new'
            ? 'Mới nhất'
            : rawValue == 'login'
                ? 'Đăng nhập'
                : rawValue == 'age'
                    ? 'Tuổi'
                    : '';

  static const recent = const FriendQueryOrderBy(rawValue: 'new');
  static const login = const FriendQueryOrderBy(rawValue: 'login');
  static const age = const FriendQueryOrderBy(rawValue: 'age');

  static List<FriendQueryOrderBy> getAll() => [recent, login, age];
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

  Gender({@required this.rawValue})
      : displayValue = rawValue == 'male'
            ? Strings.common.man
            : rawValue == 'female'
                ? Strings.common.woman
                : Strings.common.other;

  static final male = Gender(rawValue: 'male');
  static final female = Gender(rawValue: 'female');
  static final other = Gender(rawValue: 'other');

  static List<Gender> getAll() => [male, female, other];
}

class SocialProviderType extends Enumerable<String> {
  final String rawValue;
  final String displayValue;

  SocialProviderType({@required this.rawValue, String displayValue})
      : this.displayValue = displayValue ??
            getAll().firstWhere((e) => e.rawValue == rawValue).displayValue;

  static final email =
      SocialProviderType(rawValue: 'email', displayValue: 'Email');
  static final facebook =
      SocialProviderType(rawValue: 'facebook', displayValue: 'Facebook');
  static final google =
      SocialProviderType(rawValue: 'google', displayValue: 'Google');
  static final instagram =
      SocialProviderType(rawValue: 'instagram', displayValue: 'Instagram');

  static List<SocialProviderType> getAll() =>
      [email, facebook, google, instagram];
}

class NotificationType extends Enumerable<String> {
  final String rawValue;

  const NotificationType({@required this.rawValue});

  static const like = const NotificationType(rawValue: 'like');
  static const matching = const NotificationType(rawValue: 'matching');
  static const newMessage = const NotificationType(rawValue: 'newMessage');
  static const other = const NotificationType(rawValue: 'other');

  static List<NotificationType> getAll() => [like, matching, newMessage, other];
}
