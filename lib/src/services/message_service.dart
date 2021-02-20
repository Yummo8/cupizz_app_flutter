import 'dart:io';

import 'package:cupizz_app/src/base/base.dart';

class MessageService extends GetxService {
  Future<WithIsLastPageOutput<Conversation>> getMyConversations(
      {int page}) async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.myConversationsQuery(page);
    final result = WithIsLastPageOutput<Conversation>.fromJson(data);
    return result;
  }

  Future<WithIsLastPageOutput<Message>> getMessages({
    @required ConversationKey key,
    int page,
  }) async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.messagesQuery(key, page);
    final result = WithIsLastPageOutput<Message>.fromJson(data);
    return result;
  }

  Future<WithIsLastPageOutput<Message>> getMessagesV2({
    @required ConversationKey key,
    String cursor,
  }) async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.messagesV2Query(key, cursor);
    final result = WithIsLastPageOutput<Message>.fromJson(data);
    return result;
  }

  Future<Conversation> getConversation({
    @required ConversationKey key,
  }) async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.conversationQuery(key);
    final result = Mapper.fromJson(data).toObject<Conversation>();
    return result;
  }

  Future<Conversation> getMyAnonymousChat() async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.myAnonymousChatQuery();
    if (data == null) return null;
    final result = Mapper.fromJson(data).toObject<Conversation>();
    return result;
  }

  Future<String> sendMessage(ConversationKey key,
      {String message, List<File> attachments = const []}) async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.sendMessage(key, message, attachments);
    final result = data['id'];
    return result;
  }

  Future deleteAnonymousChat() =>
      Get.find<GraphqlService>().deleteAnonymousChatMutation();

  Future endCall(String messageId) =>
      Get.find<GraphqlService>().endCallMutation(messageId);

  Future acceptCall(String messageId) =>
      Get.find<GraphqlService>().acceptCallMutation(messageId);

  Stream<Message> onNewMessage(ConversationKey key) =>
      Get.find<GraphqlService>().newMessageSubscription(key);

  Stream<Message> onMessageChange(ConversationKey key) =>
      Get.find<GraphqlService>().messageChangeSubscription(key);

  Stream<Conversation> onConversationChange() =>
      Get.find<GraphqlService>().conversationChangeSubscription();

  Stream<Conversation> findAnonymousChat() =>
      Get.find<GraphqlService>().findAnonymousChatSubscription();
}
