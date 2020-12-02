part of 'index.dart';

extension GraphqlMutation on GraphqlService {
  Future loginMutation(
      {@required String email, @required String password}) async {
    final result = await mutate(MutationOptions(
      documentNode: gql('''
          mutation login(\$email: String, \$password: String){
            login(email: \$email password: \$password) {
              token
              info { id }
            }
          }
        '''),
      variables: {'email': email, 'password': password},
    ));
    debugPrint(result.data['login']['info']['id']);
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
    io.File cover,
    DateTime birthday,
    double latitude,
    double longitude,
  ]) async {
    final query = '''
          mutation updateProfile(\$avatar: Upload, \$cover: Upload) {
            updateProfile(
              ${nickName != null ? 'nickName: "$nickName"' : ''}
              ${introduction != null ? 'introduction: "$introduction"' : ''}
              ${gender != null ? 'gender: ${gender.rawValue}' : ''}
              ${hobbies != null ? 'hobbyIds: ${jsonEncode(hobbies.map((e) => e.id).toList())}' : ''}
              ${phoneNumber != null ? 'phoneNumber: "$phoneNumber"' : ''}
              ${job != null ? 'job: "$job"' : ''}
              ${height != null ? 'height: $height' : ''}
              ${birthday != null ? 'birthday: $birthday' : ''}
              ${latitude != null ? 'latitude: $latitude' : ''}
              ${longitude != null ? 'longitude: $longitude' : ''}
              avatar: \$avatar
              cover: \$cover
            ) ${User.graphqlQuery}
          }''';
    final result = await mutate(
      MutationOptions(documentNode: gql(query), variables: {
        'avatar': avatar != null ? await multiPartFile(avatar) : null,
        'cover': cover != null ? await multiPartFile(cover) : null,
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
    final result = await mutate(
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
    final result = await mutate(MutationOptions(
      documentNode: gql('''mutation {
        addFriend(userId: "$id" isSuperLike: $isSuperLike) { status }
      }'''),
    ));

    return result.data['addFriend'];
  }

  Future<void> removeFriendMutation({@required String id}) async {
    await mutate(MutationOptions(
      documentNode: gql('''mutation {
        removeFriend(userId: "$id")
      }'''),
    ));
  }

  Future undoLastDislikeUserMutation() async {
    final result = await mutate(MutationOptions(
      documentNode: gql('''mutation {
        undoLastDislikedUser ${SimpleUser.graphqlQuery}
      }'''),
    ));

    return result.data['undoLastDislikedUser'];
  }

  Future sendMessage(ConversationKey key,
      [String message, List<io.File> attachments = const []]) async {
    final result = await mutate(MutationOptions(
        documentNode: gql(
            '''mutation sendMessage(\$attachments: [Upload], \$message: String) {
          sendMessage(
            ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'receiverId: "${key.targetUserId}"'} 
            message: \$message
            attachments: \$attachments
          ) {
            id
          }
        }'''),
        variables: {
          'message': message,
          'attachments': await Future.wait(
              (attachments ?? []).map((e) => multiPartFile(e))),
        }));

    return result.data['sendMessage'];
  }

  Future addUserImage(io.File image) async {
    final query = '''
          mutation addUserImage(\$image: Upload!) {
            addUserImage(image: \$image) ${UserImage.graphqlQuery}
          }''';
    final result = await mutate(
      MutationOptions(documentNode: gql(query), variables: {
        'image': await multiPartFile(image),
      }),
    );

    return result.data['addUserImage'];
  }

  Future answerQuestion(
    String questionId,
    String content, {
    String color,
    String textColor,
    List<String> gradient,
    io.File backgroundImage,
  }) async {
    final query = '''
          mutation answerQuestion(\$backgroundImage: Upload) {
            updateProfile(
              questionId: "$questionId"
              content: "$content"
              ${color != null ? 'color: $color' : ''}
              ${textColor != null ? 'textColor: $textColor' : ''}
              ${gradient != null ? 'gradient: $gradient' : ''}
              backgroundImage: \$backgroundImage
            ) ${UserImage.graphqlQuery}
          }''';
    final result = await mutate(
      MutationOptions(documentNode: gql(query), variables: {
        'backgroundImage': backgroundImage != null
            ? await multiPartFile(backgroundImage)
            : null,
      }),
    );

    return result.data['answerQuestion'];
  }

  Future removeUserImage(String id) async {
    final query = '''
          mutation {
            removeUserImage(id: "$id") { id }
          }''';
    final result = await mutate(MutationOptions(documentNode: gql(query)));

    return result.data['removeUserImage'];
  }

  Future updateUserImagesSortOrder(List<String> userImagesSortOrder) async {
    final query = '''
          mutation {
            updateUserImagesSortOrder(
              userImagesSortOrder: ${jsonEncode(userImagesSortOrder)}
            ) ${User.graphqlQuery}
          }''';
    final result = await mutate(MutationOptions(documentNode: gql(query)));

    return result.data['updateUserImagesSortOrder'];
  }
}
