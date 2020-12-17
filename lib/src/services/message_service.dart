part of 'index.dart';

class MessageService extends MomentumService {
  Future<WithIsLastPageOutput<Conversation>> getMyConversations(
      {int page}) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.myConversationsQuery(page);
    final result = WithIsLastPageOutput<Conversation>.fromJson(data);
    return result;
  }

  Future<WithIsLastPageOutput<Message>> getMessages({
    @required ConversationKey key,
    int page,
  }) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.messagesQuery(key, page);
    final result = WithIsLastPageOutput<Message>.fromJson(data);
    return result;
  }

  Future<Conversation> getConversation({
    @required ConversationKey key,
  }) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.conversationQuery(key);
    final result = Mapper.fromJson(data).toObject<Conversation>();
    return result;
  }

  Future<String> sendMessage(ConversationKey key,
      {String message, List<io.File> attachments = const []}) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.sendMessage(key, message, attachments);
    final result = data['id'];
    return result;
  }

  Stream<Message> onNewMessage(ConversationKey key) =>
      getService<GraphqlService>().newMessageSubscription(key);

  Stream<Conversation> onConversationChange() =>
      getService<GraphqlService>().conversationChangeSubscription();
}
