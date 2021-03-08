part of 'index.dart';

extension GraphqlQuery on GraphqlService {
  Future meQuery() async {
    final queryString = '{ me ${User.graphqlQuery} }';
    final result = await query(QueryOptions(
      document: gql(queryString),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    return result.data['me'];
  }

  Future<int> remainingSuperLikeQuery() async {
    final result = await query(QueryOptions(
      document: gql('{ me { data { remainingSuperLike } } }'),
      fetchPolicy: FetchPolicy.networkOnly,
    ));
    return result.data['me']['data']['remainingSuperLike'];
  }

  Future recommendableUsersQuery() async {
    final result = await query(QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql('{ recommendableUsers ${SimpleUser.graphqlQuery} }')));
    return result.data['recommendableUsers'];
  }

  Future hobbiesQuery() async {
    final result = await query(
        QueryOptions(document: gql('{ hobbies ${Hobby.graphqlQuery} }')));
    return result.data['hobbies'];
  }

  Future friendsQuery([
    FriendQueryType type = FriendQueryType.all,
    FriendQueryOrderBy orderBy = FriendQueryOrderBy.recent,
    int page = 1,
  ]) async {
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(
          '{ friends(type: ${type.rawValue} orderBy: ${orderBy.rawValue} page: $page) ${FriendData.graphqlQuery} }'),
    ));
    return result.data['friends'];
  }

  Future friendsV2Query([
    FriendQueryType type = FriendQueryType.all,
    FriendQueryOrderBy orderBy = FriendQueryOrderBy.recent,
    int page = 1,
    bool isSuperLike,
  ]) async {
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(
          '''{ friendsV2(type: ${type.rawValue} orderBy: ${orderBy.rawValue} page: $page ${isSuperLike != null ? 'isSuperLike: $isSuperLike' : ''}) 
          ${WithIsLastPageOutput.graphqlQuery(FriendData.graphqlQuery)} }'''),
    ));
    return result.data['friendsV2'];
  }

  Future myConversationsQuery([
    int page = 1,
  ]) async {
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(
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
      document: gql(queryString),
    ));
    return result.data['messages'];
  }

  Future messagesV2Query(
    ConversationKey key, [
    String cursor,
  ]) async {
    final queryString = '''{ 
        messagesV2(
          ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'userId: "${key.targetUserId}"'} 
          cursor: "$cursor"
          ${cursor.isExistAndNotEmpty ? 'skip: 1' : ''}
        ) ${WithIsLastPageOutput.graphqlQuery(Message.graphqlQuery(includeConversation: false))}
      }''';
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(queryString),
    ));
    return result.data['messagesV2'];
  }

  Future conversationQuery(ConversationKey key) async {
    final queryString = '''{ 
        conversation(
          ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'userId: "${key.targetUserId}"'} 
        ) ${Conversation.graphqlQuery}
      }''';
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(queryString),
    ));
    return result.data['conversation'];
  }

  Future userQuery(String id) async {
    final queryString = '''{ 
        user(id: "$id") ${SimpleUser.graphqlQuery}
      }''';
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(queryString),
    ));
    return result.data['user'];
  }

  Future getAddressQuery(String latitude, String longitude) async {
    final queryString = '''{ 
        getAddress(latitude: "$latitude" longitude: "$longitude")
      }''';
    final result = await query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheFirst,
      document: gql(queryString),
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
        document: gql(queryString),
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
        document: gql(queryString),
      ),
    );
    return result.data['colorsOfAnswer'];
  }

  Future<int> unreadMessageCountQuery() async {
    final queryString = '''{ unreadMessageCount }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(queryString),
      ),
    );
    return result.data['unreadMessageCount'] ?? 0;
  }

  Future<int> unreadReceiveFriendCountQuery() async {
    final queryString = '''{ unreadReceiveFriendCount(justSuperLike: true) }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(queryString),
      ),
    );
    return result.data['unreadReceiveFriendCount'] ?? 0;
  }

  Future<int> unreadAcceptedFriendCountQuery() async {
    final queryString = '''{ unreadAcceptedFriendCount }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(queryString),
      ),
    );
    return result.data['unreadAcceptedFriendCount'] ?? 0;
  }

  Future<String> getAgoraAppIdQuery() async {
    final queryString = '''{ agoraAppId }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(queryString),
      ),
    );
    return result.data['agoraAppId'];
  }

  Future postsQuery({
    int page = 1,
    String categoryId,
    String keyword,
    bool isMyPost = false,
  }) async {
    final queryString = '''{ 
      posts(
        page: $page 
        orderBy: { createdAt: desc }
        where: {
          content: {contains: "${keyword ?? ''}"}
          isMyPost: $isMyPost
          categoryId: ${categoryId.isExistAndNotEmpty ? '{ equals: "$categoryId" }' : 'null'}
        }
      ) {
        data ${Post.graphqlQuery} 
        isLastPage
      }
    }
    ''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(queryString),
      ),
    );
    return result.data['posts'];
  }

  Future postCategoriesQuery() async {
    final queryString = '''{ postCategories ${PostCategory.graphqlQuery} }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(queryString),
      ),
    );
    return result.data['postCategories'];
  }

  Future postCommentsQuery(int postId, [String commentCursorId]) async {
    final queryString = '''{
      post(where: {id: $postId}) {
        comments${Comment.listFilter(cursorId: commentCursorId)} ${Comment.graphqlQuery}
      }
    }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(queryString),
      ),
    );
    final post = result.data['post'];
    return post == null ? null : post['comments'];
  }

  Future myAnonymousChatQuery() async {
    final queryString = '''{ myAnonymousChat ${Conversation.graphqlQuery} }''';
    final result = await query(
      QueryOptions(
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(queryString),
      ),
    );
    return result.data['myAnonymousChat'];
  }
}
