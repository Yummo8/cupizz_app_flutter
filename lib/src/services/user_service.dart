part of 'index.dart';

class UserService extends MomentumService {
  Future<User> getCurrentUser() async {
    final graphql = getService<GraphqlService>();
    final result = await graphql.query(GraphqlQuery.meQuery());
    final user = Mapper.fromJson(result.data['me']).toObject<User>();
    return user;
  }

  Future<List<SimpleUser>> getRecommendableUsers() async {
    final graphql = getService<GraphqlService>();
    final result = await graphql.query(GraphqlQuery.recommendableUsersQuery());
    final users = (result.data['recommendableUsers'] as List)
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
    final result = await graphql.query(GraphqlQuery.updateMySetting(
      minAgePrefer: minAgePrefer,
      maxAgePrefer: maxAgePrefer,
      minHeightPrefer: minHeightPrefer,
      maxHeightPrefer: maxHeightPrefer,
      genderPrefer: genderPrefer,
      distancePrefer: distancePrefer,
      mustHaveFields: mustHaveFields,
    ));
    final user =
        Mapper.fromJson(result.data['updateMySetting']).toObject<User>();
    return user;
  }
}
