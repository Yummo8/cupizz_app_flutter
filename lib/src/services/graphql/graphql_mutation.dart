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

  Future loginSocialMutation(
      {@required SocialProviderType type, @required String accessToken}) async {
    final result = await mutate(MutationOptions(
      documentNode: gql('''
          mutation loginSocialNetwork(\$type: SocialProviderEnumType!, \$accessToken: String!){
            loginSocialNetwork(type: \$type accessToken: \$accessToken) {
              token
              info { id }
            }
          }
        '''),
      variables: {'type': type.rawValue, 'accessToken': accessToken},
    ));
    debugPrint(result.data['loginSocialNetwork']['info']['id']);
    return result.data['loginSocialNetwork'];
  }

  Future registerMutation(
      {@required String nickname,
      @required String token,
      @required String password}) async {
    final result = await mutate(MutationOptions(
      documentNode: gql('''
          mutation register(\$nickname: String!, \$password: String, \$token: String!){
            register(nickname: \$nickname password: \$password token: "\$token") {
              token
              info { id }
            }
          }
        '''),
      variables: {'nickname': nickname, 'password': password, 'token': token},
    ));
    debugPrint(result.data['register']['info']['id']);
    return result.data['register'];
  }

  Future<String> registerEmailMutation(String email) async {
    final result = await mutate(MutationOptions(
      documentNode: gql('''
          mutation { registerEmail(email:"$email") { token } }
        '''),
    ));
    debugPrint('registerEmail token: ' + result.data['registerEmail']['token']);
    return result.data['registerEmail']['token'];
  }

  Future<String> verifyOtpMutation(String token, String otp) async {
    final result = await mutate(MutationOptions(
      documentNode: gql('''
          mutation { verifyOtp(token: "$token" otp: "$otp") { token } }
        '''),
    ));
    debugPrint('verifyOtp token: ' + result.data['verifyOtp']['token']);
    return result.data['verifyOtp']['token'];
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
    EducationLevel educationLevel,
    UsualType smoking,
    UsualType drinking,
    HaveKids yourKids,
    List<LookingFor> lookingFors,
    Religious religious,
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
              ${birthday != null ? 'birthday: "${birthday.toUtc().toIso8601String()}"' : ''}
              ${latitude != null ? 'latitude: $latitude' : ''}
              ${longitude != null ? 'longitude: $longitude' : ''}
              avatar: \$avatar
              cover: \$cover
              ${educationLevel != null ? 'educationLevel: ${educationLevel.rawValue}' : ''}
              ${smoking != null ? 'smoking: ${smoking.rawValue}' : ''}
              ${drinking != null ? 'drinking: ${drinking.rawValue}' : ''}
              ${yourKids != null ? 'yourKids: ${yourKids.rawValue}' : ''}
              ${lookingFors != null ? 'lookingFors: ${lookingFors.map((e) => e.rawValue).toList()}' : ''}
              ${religious != null ? 'religious: ${religious.rawValue}' : ''}
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
    bool allowMatching,
    bool isPrivate,
    bool showActive,
    List<NotificationType> pushNotiSetting,
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
              ${allowMatching != null ? 'allowMatching: $allowMatching' : ''}
              ${isPrivate != null ? 'isPrivate: $isPrivate' : ''}
              ${showActive != null ? 'showActive: $showActive' : ''}
              ${pushNotiSetting != null ? 'pushNotiSetting: ${pushNotiSetting.map((e) => e.rawValue).toList()}' : ''}
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
          mutation answerQuestion(\$backgroundImage: Upload, \$content: String!) {
            answerQuestion(
              questionId: "$questionId"
              content: \$content
              ${color != null ? 'color: "$color"' : ''}
              ${textColor != null ? 'textColor: "$textColor"' : ''}
              ${gradient != null ? 'gradient: ${jsonEncode(gradient)}' : ''}
              backgroundImage: \$backgroundImage
            ) ${UserImage.graphqlQuery}
          }''';
    final result = await mutate(
      MutationOptions(documentNode: gql(query), variables: {
        'backgroundImage': backgroundImage != null
            ? await multiPartFile(backgroundImage)
            : null,
        'content': content,
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
    final result = await mutate(MutationOptions(
      documentNode: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    return result.data['updateUserImagesSortOrder'];
  }

  Future editAnswer(
    String answerId, [
    String content,
    Color color,
    Color textColor,
    List<Color> gradient = const [],
    io.File backgroundImage,
  ]) async {
    final query = '''
          mutation editAnswer(
            \$backgroundImage: Upload 
            \$answerId: ID!
            \$content: String
            \$color: String
            \$textColor: String
            \$gradient: [String]
          ) {
            editAnswer(
              answerId: \$answerId
              content: \$content
              color: \$color
              textColor: \$textColor
              gradient: \$gradient
              backgroundImage: \$backgroundImage
            ) ${UserImage.graphqlQuery}
          }''';
    final variables = {
      'backgroundImage':
          backgroundImage != null ? await multiPartFile(backgroundImage) : null,
      'answerId': answerId,
      'content': content,
      'color': color?.toHex(leadingHashSign: false),
      'textColor': textColor?.toHex(leadingHashSign: false),
      'gradient':
          gradient?.map((e) => e.toHex(leadingHashSign: false))?.toList() ??
              (color != null ? [] : null),
    };
    final result = await mutate(MutationOptions(
      documentNode: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
      variables: variables,
    ));

    return result.data['editAnswer'];
  }
}
