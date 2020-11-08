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
}
