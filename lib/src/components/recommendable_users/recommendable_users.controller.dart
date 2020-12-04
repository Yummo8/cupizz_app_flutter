part of '../index.dart';

class RecommendableUsersController
    extends MomentumController<RecommendableUsersModel> {
  @override
  RecommendableUsersModel init() {
    return RecommendableUsersModel(this, users: []);
  }

  Future initState() async {
    if (!model.users.isExistAndNotEmpty) {
      return await fetchRecommendableUsers();
    }
  }

  @override
  Future<void> bootstrapAsync() => fetchRecommendableUsers();

  Future<void> fetchRecommendableUsers() async {
    try {
      debugPrint('Fetching recommend users');
      model.update(isLoading: true);
      final users = await getService<UserService>().getRecommendableUsers();
      model.update(users: users, isLoading: false);
      debugPrint('Fetched ${users.length} recommend users');
    } catch (e) {
      model.update(error: e.toString(), isLoading: false);
    }
  }

  Future onSwipe({bool isSwipeRight = false}) async {
    if (model.users.isNotEmpty) {
      final service = getService<UserService>();
      if (isSwipeRight) {
        await service.addFriend(model.users[0].id);
        unawaited(dependOn<FriendPageController>().refresh());
      } else {
        await service.removeFriend(model.users[0].id);
      }
      model.users.removeAt(0);
    }
  }
}
