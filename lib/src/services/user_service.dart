part of 'index.dart';

class UserService extends MomentumService {
  Future<User> getCurrentUser() async {
    final graphql = getService<GraphqlService>();
    final result = await graphql.mutate(GraphqlQuery.meQuery());
    final user = Mapper.fromJson(result.data['me']).toObject<User>();
    return user;
  }
}
