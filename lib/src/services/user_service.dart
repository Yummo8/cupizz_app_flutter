part of 'index.dart';

class UserService extends MomentumService {
  Future<User> getCurrentUser() async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.meQuery();
    final user = Mapper.fromJson(data).toObject<User>();
    return user;
  }

  Future<List<SimpleUser>> getRecommendableUsers() async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.recommendableUsersQuery();
    final users = (data as List)
        .map((e) => Mapper.fromJson(e).toObject<SimpleUser>())
        .toList();
    return users;
  }

  Future<User> updateSetting({
    int minAgePrefer,
    int maxAgePrefer,
    int minHeightPrefer,
    int maxHeightPrefer,
    List<Gender> genderPrefer,
    int distancePrefer,
    List<String> mustHaveFields,
  }) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.updateMySetting(
      minAgePrefer,
      maxAgePrefer,
      minHeightPrefer,
      maxHeightPrefer,
      genderPrefer,
      distancePrefer,
      mustHaveFields,
    );
    final user = Mapper.fromJson(data).toObject<User>();
    return user;
  }
}
