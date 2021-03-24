import 'package:cupizz_app/src/base/base.dart';

class FileType extends Enumerable<String> {
  @override
  final String rawValue;
  const FileType({required this.rawValue});

  static const image = FileType(rawValue: 'image');
}

class FriendType extends Enumerable<String> {
  @override
  final String rawValue;
  const FriendType({required this.rawValue});

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
    required this.rawValue,
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

  const FriendQueryOrderBy({required this.rawValue})
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
  const OnlineStatus({required this.rawValue});

  static const online = FileType(rawValue: 'online');
  static const offline = FileType(rawValue: 'offline');
}

class Gender extends Enumerable<String> {
  @override
  final String rawValue;
  final String displayValue;

  Gender({required this.rawValue})
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

  SocialProviderType({required this.rawValue, String? displayValue})
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
  final String shortTitle;
  final String title;

  NotificationType({required this.rawValue, String? shortTitle, String? title})
      : shortTitle = shortTitle ??
            getAll()
                .where((e) => e.rawValue == rawValue)
                .toList()
                .getAt(0)
                ?.shortTitle ??
            rawValue,
        title =
            title ?? getAll().firstWhere((e) => e.rawValue == rawValue).title;

  static final like = NotificationType(
      rawValue: 'like',
      shortTitle: 'Khi có người thích bạn',
      title: 'Khi có người thích bạn');
  static final matching = NotificationType(
      rawValue: 'matching',
      shortTitle: 'Khi ghép đôi thành công',
      title: 'Khi ghép đôi thành công');
  static final newMessage = NotificationType(
      rawValue: 'newMessage',
      shortTitle: 'Khi có tin nhắn mới',
      title: 'Khi có tin nhắn mới');
  static final otherFindingAnonymousChat = NotificationType(
    rawValue: 'otherFindingAnonymousChat',
    shortTitle: 'Khi có người muốn trò chuyện ẩn danh',
    title: 'Nhận thông báo khi có người muốn trò chuyện ẩn danh',
  );
  static final other = NotificationType(
      rawValue: 'other',
      shortTitle: 'Những thông báo khác',
      title: 'Những thông báo khác');

  static List<NotificationType> getAll() =>
      [like, matching, newMessage, otherFindingAnonymousChat, other];
}

class EducationLevel extends Enumerable<String> {
  @override
  final String rawValue;
  final String displayValue;

  EducationLevel({required this.rawValue, String? displayValue})
      : displayValue = displayValue ??
            getAll()
                .where((e) => e.rawValue == rawValue)
                .toList()
                .getAt(0)
                ?.displayValue ??
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

  UsualType({required this.rawValue, String? displayValue})
      : displayValue = displayValue ??
            getAll()
                .where((e) => e.rawValue == rawValue)
                .toList()
                .getAt(0)
                ?.displayValue ??
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
  final String theirDisplay;

  HaveKids({required this.rawValue, String? displayValue, String? theirDisplay})
      : displayValue = displayValue ??
            getAll()
                .where((e) => e.rawValue == rawValue)
                .toList()
                .getAt(0)
                ?.displayValue ??
            Strings.common.notDisclose,
        theirDisplay = theirDisplay ??
            getAll()
                .where((e) => e.rawValue == rawValue)
                .toList()
                .getAt(0)
                ?.theirDisplay ??
            Strings.common.notDisclose;

  static final dontHave = HaveKids(
      rawValue: 'dontHave',
      displayValue: 'Tôi chưa có con',
      theirDisplay: 'Chưa có con');
  static final have = HaveKids(
      rawValue: 'have',
      displayValue: 'Tôi đã có con',
      theirDisplay: 'Đã có con');

  static List<HaveKids> getAll() => [dontHave, have];
}

class LookingFor extends Enumerable<String> {
  @override
  final String rawValue;
  final String displayValue;

  LookingFor({required this.rawValue, String? displayValue})
      : displayValue = displayValue ??
            getAll()
                .where((e) => e.rawValue == rawValue)
                .toList()
                .getAt(0)
                ?.displayValue ??
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

  Religious({required this.rawValue, String? displayValue})
      : displayValue = displayValue ??
            getAll()
                .where((e) => e.rawValue == rawValue)
                .toList()
                .getAt(0)
                ?.displayValue ??
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

class LikeType extends Enumerable<String> {
  @override
  final String rawValue;
  final String gifPath;
  final String iconPath;

  factory LikeType({required String rawValue}) {
    return rawValue.isNotEmpty
        ? LikeType.getAll()
                .where((e) => e.rawValue == rawValue)
                .toList()
                .getAt(0) ??
            LikeType.love
        : LikeType.love;
  }

  const LikeType._(this.rawValue, this.gifPath, this.iconPath);

  static final like = LikeType._('like', Assets.gifs.like, Assets.icons.like);
  static final love = LikeType._('love', Assets.gifs.love, Assets.icons.love);
  static final wow = LikeType._('wow', Assets.gifs.wow, Assets.icons.wow);
  static final haha = LikeType._('haha', Assets.gifs.haha, Assets.icons.haha);
  static final angry =
      LikeType._('angry', Assets.gifs.angry, Assets.icons.angry);
  static final sad = LikeType._('sad', Assets.gifs.sad, Assets.icons.sad);

  static List<LikeType> getAll() => [like, love, wow, haha, angry, sad];
}

class CallStatus extends Enumerable<String> {
  @override
  final String rawValue;

  const CallStatus({required this.rawValue});

  static final ringing = CallStatus(rawValue: 'ringing');
  static final rejected = CallStatus(rawValue: 'rejected');
  static final missing = CallStatus(rawValue: 'missing');
  static final inCall = CallStatus(rawValue: 'inCall');
  static final ended = CallStatus(rawValue: 'ended');

  static List<CallStatus> getAll() =>
      [ringing, rejected, missing, inCall, ended];
}
