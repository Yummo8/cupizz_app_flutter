library models;

import 'dart:math';

import 'package:flutter/cupertino.dart';
import '../base/base.dart';

import '../packages/object_mapper/object_mapper.dart';

part 'base.dart';
part 'conversation.dart';
part 'enum.dart';
part 'fake.dart';
part 'file.dart';
part 'hobby.dart';
part 'key_value.dart';
part 'simple_user.dart';
part 'user.dart';
part 'social_provider.dart';
part 'friend_data.dart';
part 'message.dart';

objectMapping() {
  Mappable.factories = {
    Conversation: () => Conversation(),
    File: () => File(),
    FileType: (v) => FileType(rawValue: v),
    FriendData: () => FriendData(),
    FriendType: (v) => FriendType(rawValue: v),
    Gender: (v) => Gender(rawValue: v),
    Hobby: () => Hobby(),
    KeyValue: () => KeyValue(),
    NotificationType: (v) => NotificationType(rawValue: v),
    Message: () => Message(),
    OnlineStatus: (v) => OnlineStatus(rawValue: v),
    SocialProviderType: (v) => SocialProviderType(rawValue: v),
    SocialProvider: () => SocialProvider(),
    SimpleUser: () => SimpleUser(),
    User: () => User(),
  };
}
