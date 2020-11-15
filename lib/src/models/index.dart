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

objectMapping() {
  Mappable.factories = {
    FileType: (v) => FileType(rawValue: v),
    FriendType: (v) => FriendType(rawValue: v),
    Gender: (v) => Gender(rawValue: v),
    OnlineStatus: (v) => OnlineStatus(rawValue: v),
    SocialProviderType: (v) => SocialProviderType(rawValue: v),
    SocialProvider: () => SocialProvider(),
    File: () => File(),
    SimpleUser: () => SimpleUser(),
    KeyValue: () => KeyValue(),
    Hobby: () => Hobby(),
    User: () => User(),
  };
}
