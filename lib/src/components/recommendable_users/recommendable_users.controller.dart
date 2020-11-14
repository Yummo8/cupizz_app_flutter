part of '../index.dart';

class RecommendableUsersController
    extends MomentumController<RecommendableUsersModel> {
  @override
  RecommendableUsersModel init() {
    return RecommendableUsersModel(this, users: []);
  }

  bootstrapAsync() => fetchRecommendableUsers();

  Future<void> fetchRecommendableUsers() async {
    try {
      debugPrint('Fetching recommend users');
      this.model.update(isLoading: true);
      final users = await getService<UserService>().getRecommendableUsers();
      this.model.update(users: users, isLoading: false);
      debugPrint('Fetched ${users.length} recommend users');
    } catch (e) {
      this.model.update(error: e.toString(), isLoading: false);
    }
  }
}
