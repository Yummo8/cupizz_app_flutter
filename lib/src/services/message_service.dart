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
    ConversationKey key,
    int page,
  }) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.messagesQuery(key, page);
    final result = WithIsLastPageOutput<Message>.fromJson(data);
    return result;
  }

  Future<String> sendMessage(ConversationKey key,
      {String message, List<io.File> attachments = const []}) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.sendMessage(key, message, attachments);
    final result = data['id'];
    return result;
  }
}
