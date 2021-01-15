library models;

import 'package:cupizz_app/src/screens/main/pages/friend_v2/friend_page_v2.dart';

import '../base/base.dart';

export 'base.dart';
export 'chat_user.dart';
export 'colorOfAnswer.dart';
export 'conversation.dart';
export 'conversation_key.dart';
export 'enum.dart';
export 'file.dart';
export 'forgot_pass_output.dart';
export 'friend_data.dart';
export 'hobby.dart';
export 'key_value.dart';
export 'message.dart';
export 'question.dart';
export 'simple_user.dart';
export 'social_provider.dart';
export 'user.dart';
export 'user_answer.dart';
export 'user_image.dart';
export 'with_is_past_page_output.dart';

void objectMapping() {
  Mappable.factories = {
    ChatUser: () => ChatUser(),
    ColorOfAnswer: () => ColorOfAnswer(),
    Conversation: () => Conversation(),
    EducationLevel: (v) => EducationLevel(rawValue: v),
    FileModel: () => FileModel(),
    FileType: (v) => FileType(rawValue: v),
    ForgotPassOutput: () => ForgotPassOutput(),
    FriendData: () => FriendData(),
    FriendV2TabData: () => FriendV2TabData(),
    FriendType: (v) => FriendType(rawValue: v),
    Gender: (v) => Gender(rawValue: v),
    HaveKids: (v) => HaveKids(rawValue: v),
    Hobby: () => Hobby(),
    KeyValue: () => KeyValue(),
    LookingFor: (v) => LookingFor(rawValue: v),
    Message: () => Message(),
    NotificationType: (v) => NotificationType(rawValue: v),
    OnlineStatus: (v) => OnlineStatus(rawValue: v),
    Question: () => Question(),
    Religious: (v) => Religious(rawValue: v),
    SimpleUser: () => SimpleUser(),
    SocialProvider: () => SocialProvider(),
    SocialProviderType: (v) => SocialProviderType(rawValue: v),
    User: () => User(),
    UserAnswer: () => UserAnswer(),
    UserImage: () => UserImage(),
    UsualType: (v) => UsualType(rawValue: v),
  };
}
