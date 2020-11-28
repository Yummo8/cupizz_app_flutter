library models;

import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../base/base.dart';
import '../packages/object_mapper/object_mapper.dart';

part 'base.dart';
part 'conversation.dart';
part 'conversation_key.dart';
part 'enum.dart';
part 'fake.dart';
part 'file.dart';
part 'friend_data.dart';
part 'hobby.dart';
part 'key_value.dart';
part 'message.dart';
part 'simple_user.dart';
part 'social_provider.dart';
part 'user.dart';
part 'with_is_past_page_output.dart';
part 'chat_user.dart';

void objectMapping() {
  Mappable.factories = {
    ChatUser: () => ChatUser(),
    Conversation: () => Conversation(),
    FileModel: () => FileModel(),
    FileType: (v) => FileType(rawValue: v),
    FriendData: () => FriendData(),
    FriendType: (v) => FriendType(rawValue: v),
    Gender: (v) => Gender(rawValue: v),
    Hobby: () => Hobby(),
    KeyValue: () => KeyValue(),
    NotificationType: (v) => NotificationType(rawValue: v),
    Message: () => Message(),
    OnlineStatus: (v) => OnlineStatus(rawValue: v),
    SimpleUser: () => SimpleUser(),
    SocialProvider: () => SocialProvider(),
    SocialProviderType: (v) => SocialProviderType(rawValue: v),
    User: () => User(),
  };
}
