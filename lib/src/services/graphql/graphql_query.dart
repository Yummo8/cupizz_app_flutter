part of 'index.dart';

extension GraphqlQuery on GraphqlService {
  Future meQuery() async {
    final result = await this
        .query(QueryOptions(documentNode: gql('{ me ${User.graphqlQuery} }')));
    return result.data['me'];
  }

  Future recommendableUsersQuery() async {
    final result = await this.query(QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        documentNode:
            gql('{ recommendableUsers ${SimpleUser.graphqlQuery} }')));
    return result.data['recommendableUsers'];
  }

  Future hobbiesQuery() async {
    final result = await this.query(
        QueryOptions(documentNode: gql('{ hobbies ${Hobby.graphqlQuery} }')));
    return result.data['hobbies'];
  }

  Future friendsQuery([
    FriendQueryType type = FriendQueryType.all,
    FriendQueryOrderBy orderBy = FriendQueryOrderBy.recent,
    int page = 1,
  ]) async {
    final result = await this.query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(
          '{ friends(type: ${type.rawValue} orderBy: ${orderBy.rawValue} page: $page) ${FriendData.graphqlQuery} }'),
    ));
    return result.data['friends'];
  }

  Future myConversationsQuery([
    int page = 1,
  ]) async {
    final result = await this.query(QueryOptions(
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
    final query = '''{ 
        messages(
          ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'userId: "${key.targetUserId}"'} 
          page: $page
        ) ${WithIsLastPageOutput.graphqlQuery(Message.graphqlQuery(includeConversation: false))}
        }''';
    final result = await this.query(QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(query),
    ));
    return result.data['messages'];
  }
}
