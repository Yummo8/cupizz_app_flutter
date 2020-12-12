part of 'index.dart';

class FileType extends Enumerable<String> {
  @override
  final String rawValue;
  const FileType({@required this.rawValue});

  static const image = FileType(rawValue: 'image');
}

class FriendType extends Enumerable<String> {
  @override
  final String rawValue;
  const FriendType({@required this.rawValue});

  static const none = FriendType(rawValue: 'none');
  static const sent = FriendType(rawValue: 'sent');
  static const received = FriendType(rawValue: 'received');
  static const friend = FriendType(rawValue: 'friend');
  static const me = FriendType(rawValue: 'me');
}

class FriendQueryType extends Enumerable<String> {
  @override
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

  static const all = FriendQueryType(rawValue: 'all');
  static const friend = FriendQueryType(rawValue: 'friend');
  static const sent = FriendQueryType(rawValue: 'sent');
  static const received = FriendQueryType(rawValue: 'received');

  static List<FriendQueryType> getAll() => [all, friend, sent, received];
}

class FriendQueryOrderBy extends Enumerable<String> {
  @override
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

  static const recent = FriendQueryOrderBy(rawValue: 'new');
  static const login = FriendQueryOrderBy(rawValue: 'login');
  static const age = FriendQueryOrderBy(rawValue: 'age');

  static List<FriendQueryOrderBy> getAll() => [recent, login, age];
}

class OnlineStatus extends Enumerable<String> {
  @override
  final String rawValue;
  const OnlineStatus({@required this.rawValue});

  static const online = FileType(rawValue: 'online');
  static const offline = FileType(rawValue: 'offline');
}

class Gender extends Enumerable<String> {
  @override
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
  @override
  final String rawValue;
  final String displayValue;

  SocialProviderType({@required this.rawValue, String displayValue})
      : displayValue = displayValue ??
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
  @override
  final String rawValue;

  const NotificationType({@required this.rawValue});

  static const like = NotificationType(rawValue: 'like');
  static const matching = NotificationType(rawValue: 'matching');
  static const newMessage = NotificationType(rawValue: 'newMessage');
  static const other = NotificationType(rawValue: 'other');

  static List<NotificationType> getAll() => [like, matching, newMessage, other];
}

class EducationLevel extends Enumerable<String> {
  @override
  final String rawValue;
  final String displayValue;

  EducationLevel({@required this.rawValue, String displayValue})
      : displayValue = displayValue ??
            getAll().firstWhere((e) => e.rawValue == rawValue).displayValue ??
            Strings.common.notDisclose;

  static final highSchool =
      EducationLevel(rawValue: 'highSchool', displayValue: 'Bằng trung học');
  static final college =
      EducationLevel(rawValue: 'college', displayValue: 'Bằng đại học');
  static final gradSchool =
      EducationLevel(rawValue: 'gradSchool', displayValue: 'Bằng cao học');

  static List<EducationLevel> getAll() => [highSchool, college, gradSchool];
}

class UsualType extends Enumerable<String> {
  @override
  final String rawValue;
  final String displayValue;

  UsualType({@required this.rawValue, String displayValue})
      : displayValue = displayValue ??
            getAll().firstWhere((e) => e.rawValue == rawValue).displayValue ??
            Strings.common.notDisclose;

  static final never =
      UsualType(rawValue: 'never', displayValue: 'Không bao giờ');
  static final occasionally =
      UsualType(rawValue: 'occasionally', displayValue: 'Thỉnh thoảng');
  static final often =
      UsualType(rawValue: 'often', displayValue: 'Thường xuyên');

  static List<UsualType> getAll() => [never, occasionally, often];
}

class HaveKids extends Enumerable<String> {
  @override
  final String rawValue;
  final String displayValue;

  HaveKids({@required this.rawValue, String displayValue})
      : displayValue = displayValue ??
            getAll().firstWhere((e) => e.rawValue == rawValue).displayValue ??
            Strings.common.notDisclose;

  static final dontHave =
      HaveKids(rawValue: 'dontHave', displayValue: 'Tôi chưa có con');
  static final have = HaveKids(rawValue: 'have', displayValue: 'Tôi đã có con');

  static List<HaveKids> getAll() => [dontHave, have];
}

class LookingFor extends Enumerable<String> {
  @override
  final String rawValue;
  final String displayValue;

  LookingFor({@required this.rawValue, String displayValue})
      : displayValue = displayValue ??
            getAll().firstWhere((e) => e.rawValue == rawValue).displayValue ??
            Strings.common.notDisclose;

  static final chatting =
      LookingFor(rawValue: 'chatting', displayValue: 'Người trò chuyện');
  static final friendship =
      LookingFor(rawValue: 'friendship', displayValue: 'Quan hệ bạn bè');
  static final somethingCasual =
      LookingFor(rawValue: 'somethingCasual', displayValue: 'Hẹn hò thoải mái');
  static final longtermRelationship = LookingFor(
      rawValue: 'longtermRelationship', displayValue: 'Mối quan hệ lâu dài');

  static List<LookingFor> getAll() =>
      [chatting, friendship, somethingCasual, longtermRelationship];
}

class Religious extends Enumerable<String> {
  @override
  final String rawValue;
  final String displayValue;

  Religious({@required this.rawValue, String displayValue})
      : displayValue = displayValue ??
            getAll().firstWhere((e) => e.rawValue == rawValue).displayValue ??
            Strings.common.notDisclose;

  static final agnostic = Religious(
      rawValue: 'agnostic', displayValue: 'Người theo thuyết bất khả tri');
  static final atheist =
      Religious(rawValue: 'atheist', displayValue: 'Người vô thần');
  static final buddhist =
      Religious(rawValue: 'buddhist', displayValue: 'Phật giáo');
  static final catholic =
      Religious(rawValue: 'catholic', displayValue: 'Công giáo');
  static final christian =
      Religious(rawValue: 'christian', displayValue: 'Cơ đốc giáo');
  static final hindu = Religious(rawValue: 'hindu', displayValue: 'Hindu giáo');
  static final jewish = Religious(rawValue: 'jewish', displayValue: 'Do Thái');
  static final muslim =
      Religious(rawValue: 'muslim', displayValue: 'Hồi giáo ');
  static final sikh = Religious(rawValue: 'sikh', displayValue: 'Sikh giáo');
  static final spiritual =
      Religious(rawValue: 'spiritual', displayValue: 'Tâm linh');
  static final other = Religious(rawValue: 'other', displayValue: 'Khác');

  static List<Religious> getAll() => [
        agnostic,
        atheist,
        buddhist,
        catholic,
        christian,
        hindu,
        jewish,
        muslim,
        sikh,
        spiritual,
        other,
      ];
}
