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

  Future<FriendType> addFriend(String userId) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.addFriendMutation(id: userId);
    final result = FriendType(rawValue: data['status']);
    return result;
  }

  Future<void> removeFriend(String userId) async {
    final graphql = getService<GraphqlService>();
    await graphql.removeFriendMutation(id: userId);
  }

  Future<User> updateProfile({
    String nickName,
    String introduction,
    Gender gender,
    List<Hobby> hobbies,
    String phoneNumber,
    String job,
    int height,
    io.File avatar,
    io.File cover,
  }) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.updateProfile(
      nickName,
      introduction,
      gender,
      hobbies,
      phoneNumber,
      job,
      height,
      avatar,
      cover,
    );
    final user = Mapper.fromJson(data).toObject<User>();
    return user;
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

  Future<List<FriendData>> getFriends({
    FriendQueryType type,
    FriendQueryOrderBy orderBy,
    int page,
  }) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.friendsQuery(type, orderBy, page);
    final friends = (data as List)
        .map((e) => Mapper.fromJson(e).toObject<FriendData>())
        .toList();
    return friends;
  }

  Future<WithIsLastPageOutput<FriendData>> getFriendsV2({
    FriendQueryType type,
    FriendQueryOrderBy orderBy,
    int page,
  }) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.friendsV2Query(type, orderBy, page);
    final result = WithIsLastPageOutput<FriendData>.fromJson(data);
    return result;
  }
}
