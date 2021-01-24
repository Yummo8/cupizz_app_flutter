part of 'index.dart';

extension GraphqlQuery on GraphqlService {
  Future meQuery() async {
    final result = await query(QueryOptions(
      documentNode: gql('{ me ${User.graphqlQuery} }'),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    return result.data['me'];
  }

  Future recommendableUsersQuery() async {
    final result = await query(QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        documentNode:
            gql('{ recommendableUsers ${SimpleUser.graphqlQuery} }')));
    return result.data['recommendableUsers'];
  }

  Future hobbiesQuery() async {
    final result = await query(
        QueryOptions(documentNode: gql('{ hobbies ${Hobby.graphqlQuery} }')));
    return result.data['hobbies'];
  }

  Future friendsQuery([
    FriendQueryType type = FriendQueryType.all,
    FriendQueryOrderBy orderBy = FriendQueryOrderBy.recent,
    int page = 1,
  ]) async {
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(
          '{ friends(type: ${type.rawValue} orderBy: ${orderBy.rawValue} page: $page) ${FriendData.graphqlQuery} }'),
    ));
    return result.data['friends'];
  }

  Future friendsV2Query([
    FriendQueryType type = FriendQueryType.all,
    FriendQueryOrderBy orderBy = FriendQueryOrderBy.recent,
    int page = 1,
  ]) async {
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(
          '{ friendsV2(type: ${type.rawValue} orderBy: ${orderBy.rawValue} page: $page) ${WithIsLastPageOutput.graphqlQuery(FriendData.graphqlQuery)} }'),
    ));
    return result.data['friendsV2'];
  }

  Future myConversationsQuery([
    int page = 1,
  ]) async {
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(
          '{ myConversations(page: $page) ${WithIsLastPageOutput.graphqlQuery(Conversation.graphqlQuery)} }'),
    ));
    return result.data['myConversations'];
  }

  Future messagesQuery(
    ConversationKey key, [
    int page = 1,
  ]) async {
    final queryString = '''{ 
        messages(
          ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'userId: "${key.targetUserId}"'} 
          page: $page
        ) ${WithIsLastPageOutput.graphqlQuery(Message.graphqlQuery(includeConversation: false))}
      }''';
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(queryString),
    ));
    return result.data['messages'];
  }

  Future conversationQuery(ConversationKey key) async {
    final queryString = '''{ 
        conversation(
          ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'userId: "${key.targetUserId}"'} 
        ) ${Conversation.graphqlQuery}
      }''';
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(queryString),
    ));
    return result.data['conversation'];
  }

  Future userQuery(String id) async {
    final queryString = '''{ 
        user(id: "$id") ${SimpleUser.graphqlQuery}
      }''';
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(queryString),
    ));
    return result.data['user'];
  }

  Future getAddressQuery(String latitude, String longitude) async {
    final queryString = '''{ 
        getAddress(latitude: "$latitude" longitude: "$longitude")
      }''';
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheFirst,
      documentNode: gql(queryString),
    ));
    return result.data['getAddress'];
  }

  Future questionsQuery([String keyword, int page]) async {
    final queryString = '''query questions(\$keyword: String, \$page: Int){ 
        questions(keyword: \$keyword, page: \$page) ${WithIsLastPageOutput.graphqlQuery(Question.graphqlQuery)}
      }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.cacheFirst,
        documentNode: gql(queryString),
        variables: {
          'keyword': keyword,
          'page': page,
        },
      ),
    );
    return result.data['questions'];
  }

  Future colorsOfAnswerQuery() async {
    final queryString = '''{ 
        colorsOfAnswer ${ColorOfAnswer.graphqlQuery}
      }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        documentNode: gql(queryString),
      ),
    );
    return result.data['colorsOfAnswer'];
  }

  Future<int> unreadMessageCountQuery() async {
    final queryString = '''{ unreadMessageCount }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        documentNode: gql(queryString),
      ),
    );
    return result.data['unreadMessageCount'] ?? 0;
  }

  Future<int> unreadReceiveFriendCountQuery() async {
    final queryString = '''{ unreadReceiveFriendCount(justSuperLike: true) }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        documentNode: gql(queryString),
      ),
    );
    return result.data['unreadReceiveFriendCount'] ?? 0;
  }

  Future<int> unreadAcceptedFriendCountQuery() async {
    final queryString = '''{ unreadAcceptedFriendCount }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        documentNode: gql(queryString),
      ),
    );
    return result.data['unreadAcceptedFriendCount'] ?? 0;
  }
}
