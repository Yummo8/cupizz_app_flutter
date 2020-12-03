import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cupizz_app/src/app.dart';
import 'package:cupizz_app/src/assets.dart';
import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/services/graphql/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectMapping();

  final tester = MomentumTester(momentum(isTesting: true));
  await tester.init();

  final graphql = tester.service<GraphqlService>();
  final storage = tester.service<StorageService>();
  final loginEmail = 'test12@gmail.com';
  final loginPassword = '123456789';

  final token = (await graphql.loginMutation(
      email: loginEmail, password: loginPassword))['token'];

  await storage.saveToken(token);
  graphql.reset();
  final currentUserJson = await graphql.meQuery();
  final currentUser = Mapper.fromJson(currentUserJson).toObject<User>();

  group('User Service Test', () {
    test('Token must be String', () {
      expect(token is String, true);
    });

    test('Get my info', () async {
      final email = currentUser.socialProviders
          ?.firstWhere((e) => e.type == SocialProviderType.email)
          ?.id;
      expect(email, loginEmail);
    });

    group('Test recommend & friend system', () {
      test('Get recommend, dislike, undo, like', () async {
        final recommendUsers = (await graphql.recommendableUsersQuery() as List)
            .map((e) => Mapper.fromJson(e).toObject<SimpleUser>())
            .toList();

        expect(
          recommendUsers.length,
          greaterThan(0),
          reason:
              'Tìm user khác có từ 1 người recommend trờ lên mới test được.',
        );

        // Dislike
        debugPrint('Testing dislike');
        await graphql.removeFriendMutation(id: recommendUsers[0].id);
        final usersTestAfterDislike =
            (await graphql.recommendableUsersQuery() as List)
                .map((e) => Mapper.fromJson(e).toObject<SimpleUser>())
                .toList();
        if (usersTestAfterDislike.isExistAndNotEmpty) {
          expect(usersTestAfterDislike[0] != recommendUsers[0], true);
        }

        // Undo
        debugPrint('Testing undo');
        final userUndo =
            Mapper.fromJson(await graphql.undoLastDislikeUserMutation())
                .toObject<SimpleUser>();
        expect(userUndo, recommendUsers[0]);
        final recommendUsersAfterUndo =
            (await graphql.recommendableUsersQuery() as List)
                .map((e) => Mapper.fromJson(e).toObject<User>())
                .toList();
        expect(recommendUsersAfterUndo[0] != userUndo, true);

        // Like
        debugPrint('Testing like');
        final friendType = FriendType(
            rawValue: (await graphql.addFriendMutation(
                id: recommendUsers[0].id, isSuperLike: true))['status']);
        expect(friendType.rawValue, FriendType.sent.rawValue);
        final recommendUsersAfterLike =
            (await graphql.recommendableUsersQuery() as List)
                .map((e) => Mapper.fromJson(e).toObject<User>())
                .toList();
        expect(recommendUsersAfterLike[0] != recommendUsers[0], true);
      });
    });
  });

  group('Update user profile', () {
    test('Update setting', () async {
      final newMinAgePrefer = Random().nextInt(50 - 18) + 18;
      final newMaxAgePrefer = Random().nextInt(60 - newMinAgePrefer) + 18 + 1;
      final newMinHeightPrefer = Random().nextInt(180 - 150) + 150;
      final newMaxHeightPrefer =
          Random().nextInt(190 - newMinHeightPrefer) + newMinHeightPrefer;
      final newGenderPrefer = Gender.getAll()
          .take(Random().nextInt(Gender.getAll().length))
          .toList();
      final newDistancePrefer = Random().nextInt(1000);

      final json = await graphql.updateMySetting(
        newMinAgePrefer,
        newMaxAgePrefer,
        newMinHeightPrefer,
        newMaxHeightPrefer,
        newGenderPrefer,
        newDistancePrefer,
      );

      final user = Mapper.fromJson(json).toObject<User>();

      expect(newMinAgePrefer, user.minAgePrefer);
      expect(newMaxAgePrefer, user.maxAgePrefer);
      expect(newMinHeightPrefer, user.minHeightPrefer);
      expect(newMaxHeightPrefer, user.maxHeightPrefer);
      expect(newGenderPrefer, user.genderPrefer);
      expect(newDistancePrefer, user.distancePrefer);
    });

    test('Update Profile', () async {
      final allHobbies = (await graphql.hobbiesQuery() as List)
          .map((e) => Mapper.fromJson(e).toObject<Hobby>())
          .toList();
      final currentAvatar =
          Mapper.fromJson(await graphql.meQuery()).toObject<ChatUser>().avatar;
      final currentCover =
          Mapper.fromJson(await graphql.meQuery()).toObject<SimpleUser>().cover;
      final nickName = 'Hien ${Random().nextInt(100)}';
      final introduction = 'Introduction ${Random().nextInt(100)}';
      final gender =
          Gender.getAll()[Random().nextInt(Gender.getAll().length - 1)];
      final hobbies =
          allHobbies.take(Random().nextInt(allHobbies.length)).toList();
      final phoneNumber = '097196370${Random().nextInt(9)}';
      final job = 'Job ${Random().nextInt(100)}';
      final height = Random().nextInt(190 - 160) + 160;
      final avatar = File(Assets.i.images.defaultAvatar);
      final cover = File(Assets.i.images.defaultAvatar);
      final birthday =
          DateTime(2000, Random().nextInt(12), Random().nextInt(28));
      final latitude = Random().nextDouble() * 10 + 10;
      final longitude = Random().nextDouble() * 10 + 10;
      final address = await graphql.getAddressQuery(
          latitude.toString(), longitude.toString());

      final json = await graphql.updateProfile(
        nickName,
        introduction,
        gender,
        hobbies,
        phoneNumber,
        job,
        height,
        avatar,
        cover,
        birthday,
        latitude,
        longitude,
      );

      final user = Mapper.fromJson(json).toObject<User>();

      expect(nickName, user.nickName);
      expect(introduction, user.introduction);
      expect(gender, user.gender);
      expect(hobbies, user.hobbies);
      expect(phoneNumber, user.phoneNumber);
      expect(job, user.job);
      expect(height, user.height);
      expect(currentAvatar != user.avatar, true);
      expect(currentCover != user.cover, true);
      expect(birthday, user.birthday.toLocal());
      expect(address, user.address);
    });
  });

  group('System test', () {
    test('Get all hobbies', () async {
      final json = await graphql.hobbiesQuery();
      final hobbies = (json as List)
          .map((e) => Mapper.fromJson(e).toObject<Hobby>())
          .toList();

      expect(hobbies.length, greaterThan(0));
    });
    test('Get address', () async {
      final address = await graphql.getAddressQuery('10.762622', '106.660172');
      expect(address, 'Phường 7, Quận 11, Việt Nam');
    });
  });

  group('Friends test', () {
    test('Get all friends', () async {
      final json = await graphql.friendsQuery(FriendQueryType.all);
      final friends = (json as List)
          .map((e) => Mapper.fromJson(e).toObject<FriendData>())
          .toList();

      expect(friends.length, greaterThan(0));
    });
    test('Get all friends sort recent', () async {
      final json = await graphql.friendsQuery(
          FriendQueryType.all, FriendQueryOrderBy.recent);
      final friends = (json as List)
          .map((e) => Mapper.fromJson(e).toObject<FriendData>())
          .toList();

      expect(friends.length, greaterThan(0));
      for (var i = 0; i < friends.length - 1; i++) {
        expect(friends[i].updatedAt,
            greaterThanOrEqualTo(friends[i + 1].updatedAt));
      }
    });
    test('Get all friends sort age', () async {
      final json = await graphql.friendsQuery(
          FriendQueryType.all, FriendQueryOrderBy.age);
      final friends = (json as List)
          .map((e) => Mapper.fromJson(e).toObject<FriendData>())
          .toList();

      expect(friends.length, greaterThan(0));
      for (var i = 0; i < friends.length - 1; i++) {
        expect(
          (currentUser.age - friends[i].friend.age).abs() <
              (currentUser.age - friends[i + 1].friend.age),
          true,
        );
      }
    });
    test('Get all friends sort login', () async {
      final json = await graphql.friendsQuery(
          FriendQueryType.all, FriendQueryOrderBy.login);
      final friends = (json as List)
          .map((e) => Mapper.fromJson(e).toObject<FriendData>())
          .toList();

      expect(friends.length, greaterThan(0));
      for (var i = 0; i < friends.length - 1; i++) {
        if (friends[i].friend.lastOnline == null) {
          expect(friends[i + 1].friend.lastOnline, null);
        } else if (friends[i + 1].friend.lastOnline == null) {
          continue;
        } else {
          expect(
              friends[i]
                  .friend
                  .lastOnline
                  .compareTo(friends[i + 1].friend.lastOnline),
              1);
        }
      }
    });
  });

  group('Message test', () {
    final conversationKey = ConversationKey(targetUserId: currentUser.id);

    test('Send string message', () async {
      final messageId = (await graphql.sendMessage(
        conversationKey,
        'Test from Flutter testing.',
      ))['id'];

      final newestMessages = WithIsLastPageOutput<Message>.fromJson(
          await graphql.messagesQuery(conversationKey));

      expect(newestMessages.data[0].id, messageId);
    });

    test('Send images message', () async {
      final messageId = (await graphql.sendMessage(
          conversationKey, null, [File(Assets.i.images.defaultAvatar)]))['id'];

      final newestMessages = WithIsLastPageOutput<Message>.fromJson(
          await graphql.messagesQuery(conversationKey));

      expect(newestMessages.data[0].id, messageId);
      expect(newestMessages.data[0].attachments.length, 1);
    });

    test('Test get my conversation matching with newest message', () async {
      final messageId = (await graphql.sendMessage(
        conversationKey,
        'Test from Flutter testing.',
      ))['id'];

      final newestConversations = WithIsLastPageOutput<Conversation>.fromJson(
          await graphql.myConversationsQuery());

      expect(newestConversations.data[0].newestMessage?.id, messageId);
    });

    test('Test get conversation detail', () async {
      final json = await graphql.conversationQuery(
        conversationKey,
      );

      final conversation = Mapper.fromJson(json).toObject<Conversation>();

      if (conversationKey?.conversationId != null) {
        expect(conversationKey.conversationId, conversation.id);
      } else {
        expect(conversation, isNotNull);
      }
    });

    test('Test realtime send message', () async {
      String messageId;
      StreamSubscription subscription;
      subscription =
          graphql.newMessageSubscription(conversationKey).listen((message) {
        expect(message.id, messageId);
        subscription.cancel();
      });

      messageId = (await graphql.sendMessage(
        conversationKey,
        'Test from Flutter testing.',
      ))['id'];
    });

    test('Test realtime conversation change', () async {
      String messageId;
      StreamSubscription subscription;
      subscription =
          graphql.conversationChangeSubscription().listen((conversation) {
        expect(conversation.newestMessage.id, messageId);
        subscription.cancel();
      });

      messageId = (await graphql.sendMessage(
        conversationKey,
        'Test from Flutter testing.',
      ))['id'];
    });
  });

  group('Test user image', () {
    test('addUserImage & removeUserImage', () async {
      final json =
          await graphql.addUserImage(File(Assets.i.images.defaultAvatar));

      final userImage = Mapper.fromJson(json).toObject<UserImage>();

      expect(userImage?.image != null, true);

      final currentUserImages =
          Mapper.fromJson(await graphql.meQuery()).toObject<User>().userImages;

      expect(currentUserImages.contains(userImage), false);

      await graphql.removeUserImage(userImage.id);

      final currentUserImagesAfterDelete =
          Mapper.fromJson(await graphql.meQuery()).toObject<User>().userImages;

      expect(currentUserImagesAfterDelete.contains(userImage), false);
    });

    test('answerQuestion', () async {
      // TODO missing api get questions
    });

    test('updateUserImagesSortOrder', () async {
      final currentUserImages =
          Mapper.fromJson(await graphql.meQuery()).toObject<User>().userImages;
      final expectSort = [...currentUserImages];
      expectSort.shuffle();

      final json = await graphql
          .updateUserImagesSortOrder(expectSort.map((e) => e.id).toList());

      final afterSort = Mapper.fromJson(json).toObject<User>().userImages;

      expect(
        afterSort.map((e) => e.id).toList(),
        expectSort.map((e) => e.id).toList(),
      );
    });
  });
}
