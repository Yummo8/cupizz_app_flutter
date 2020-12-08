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
    DateTime birthday,
    double latitude,
    double longitude,
    EducationLevel educationLevel,
    UsualType smoking,
    UsualType drinking,
    HaveKids yourKids,
    List<LookingFor> lookingFors,
    Religious religious,
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
      birthday,
      latitude,
      longitude,
      educationLevel,
      smoking,
      drinking,
      yourKids,
      lookingFors,
      religious,
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

  Future<SimpleUser> getUser({String id}) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.userQuery(id);
    final result = Mapper.fromJson(data).toObject<SimpleUser>();
    return result;
  }

  Future<UserImage> addImage(io.File image) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.addUserImage(image);
    final result = Mapper.fromJson(data).toObject<UserImage>();
    return result;
  }

  Future removeUserImage(String imageId) async {
    final graphql = getService<GraphqlService>();
    await graphql.removeUserImage(imageId);
  }

  Future<UserImage> answerQuestion(
    String questionId,
    String content, {
    String color,
    String textColor,
    List<String> gradient,
    io.File backgroundImage,
  }) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.answerQuestion(
      questionId,
      content,
      color: color,
      textColor: textColor,
      gradient: gradient,
      backgroundImage: backgroundImage,
    );
    final result = Mapper.fromJson(data).toObject<UserImage>();
    return result;
  }

  Future<UserImage> editAnswer(
    String answerId, {
    String content,
    Color color,
    Color textColor,
    List<Color> gradient,
    io.File backgroundImage,
  }) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.editAnswer(
      answerId,
      content,
      color,
      textColor,
      gradient,
      backgroundImage,
    );
    final result = Mapper.fromJson(data).toObject<UserImage>();
    return result;
  }
}
