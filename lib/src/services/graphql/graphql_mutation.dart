part of 'index.dart';

extension GraphqlMutation on GraphqlService {
  Future loginMutation(
      {@required String email, @required String password}) async {
    final result = await this.mutate(MutationOptions(
      documentNode: gql('''
          mutation login(\$email: String, \$password: String){
            login(email: \$email password: \$password) {
              token
            }
          }
        '''),
      variables: {'email': email, 'password': password},
    ));

    return result.data['login'];
  }

  Future updateProfile([
    String nickName,
    String introduction,
    Gender gender,
    List<Hobby> hobbies,
    String phoneNumber,
    String job,
    int height,
    io.File avatar,
  ]) async {
    final result = await this.mutate(
      MutationOptions(documentNode: gql('''
          mutation updateProfile(\$avatar: Upload) {
            updateProfile(
              ${nickName != null ? 'nickName: "$nickName"' : ''}
              ${introduction != null ? 'introduction: "$introduction"' : ''}
              ${gender != null ? 'gender: ${gender.rawValue}' : ''}
              ${hobbies != null ? 'hobbieIds: ${jsonEncode(hobbies.map((e) => e.id).toList())}' : ''}
              ${phoneNumber != null ? 'phoneNumber: "$phoneNumber"' : ''}
              ${job != null ? 'job: "$job"' : ''}
              ${height != null ? 'height: $height' : ''}
              avatar: \$avatar
            ) ${User.graphqlQuery}
          }'''), variables: {
        'avatar': avatar != null ? await multiPartFile(avatar) : null
      }),
    );

    return result.data['updateProfile'];
  }

  Future updateMySetting([
    int minAgePrefer,
    int maxAgePrefer,
    int minHeightPrefer,
    int maxHeightPrefer,
    List<Gender> genderPrefer,
    int distancePrefer,
    List<String> mustHaveFields,
  ]) async {
    final result = await this.mutate(
      MutationOptions(
        documentNode: gql('''
          mutation {
            updateMySetting(
              ${minAgePrefer != null ? 'minAgePrefer: $minAgePrefer' : ''}
              ${maxAgePrefer != null ? 'maxAgePrefer: $maxAgePrefer' : ''}
              ${minHeightPrefer != null ? 'minHeightPrefer: $minHeightPrefer' : ''}
              ${maxHeightPrefer != null ? 'maxHeightPrefer: $maxHeightPrefer' : ''}
              ${genderPrefer != null ? 'genderPrefer: ${genderPrefer?.map((e) => e.rawValue)?.toList()}' : ''}
              ${distancePrefer != null ? 'distancePrefer: $distancePrefer' : ''}
              ${mustHaveFields != null ? 'mustHaveFields: $mustHaveFields' : ''}
            ) ${User.graphqlQuery}
          }'''),
      ),
    );

    return result.data['updateMySetting'];
  }

  Future addFriendMutation(
      {@required String id, bool isSuperLike = false}) async {
    final result = await this.mutate(MutationOptions(
      documentNode: gql('''mutation {
        addFriend(userId: "$id" isSuperLike: $isSuperLike) { status }
      }'''),
    ));

    return result.data['addFriend'];
  }

  Future<void> removeFriendMutation({@required String id}) async {
    await this.mutate(MutationOptions(
      documentNode: gql('''mutation {
        removeFriend(userId: "$id")
      }'''),
    ));
  }

  Future undoLastDislikeUserMutation() async {
    final result = await this.mutate(MutationOptions(
      documentNode: gql('''mutation {
        undoLastDislikedUser ${SimpleUser.graphqlQuery}
      }'''),
    ));

    return result.data['undoLastDislikedUser'];
  }
}
