import 'dart:math';

import 'package:cupizz_app/src/app.dart';
import 'package:cupizz_app/src/assets.dart';
import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/services/graphql/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io' as io;

void main() async {
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    objectMapping();
  });
  final tester = MomentumTester(momentum(isTesting: true));
  await tester.init();

  final graphql = tester.service<GraphqlService>();
  final storage = tester.service<StorageService>();
  final loginEmail = 'test111@gmail.com';
  final loginPassword = '123456789';

  final token = (await graphql.loginMutation(
      email: loginEmail, password: loginPassword))['token'];

  await storage.saveToken(token);
  graphql.reset();

  group('User Service Test', () {
    test('Token must be String', () {
      expect(token is String, true);
    });

    test('Get my info', () async {
      final json = await graphql.meQuery();
      final user = Mapper.fromJson(json).toObject<User>();

      final email = user.socialProviders
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
        if (usersTestAfterDislike.length > 0) {
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
      final currentAvatar = Mapper.fromJson(await graphql.meQuery())
          .toObject<SimpleUser>()
          .avatar;
      final nickName = 'Hien ${Random().nextInt(100)}';
      final introduction = 'Introduction ${Random().nextInt(100)}';
      final gender =
          Gender.getAll()[Random().nextInt(Gender.getAll().length - 1)];
      final hobbies =
          allHobbies.take(Random().nextInt(allHobbies.length)).toList();
      final phoneNumber = '097196370${Random().nextInt(9)}';
      final job = 'Job ${Random().nextInt(100)}';
      final height = Random().nextInt(190 - 160) + 160;
      final avatar = io.File(Assets.images.defaultAvatar);

      final json = await graphql.updateProfile(
        nickName,
        introduction,
        gender,
        hobbies,
        phoneNumber,
        job,
        height,
        avatar,
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
  });
}
