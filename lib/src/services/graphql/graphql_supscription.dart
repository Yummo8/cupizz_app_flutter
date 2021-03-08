part of 'index.dart';

class MessageSubscription extends MomentumService {
  StreamSubscription<QueryResult> _streamSubscription;
  final StreamController _controller = StreamController<Message>.broadcast();

  void init(ConversationKey key) {
    _streamSubscription?.cancel();
    _streamSubscription = Get.find<GraphqlService>()
        .subscribe(SubscriptionOptions(document: gql('''subscription {
          newMessage (
            ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'senderId: "${key.targetUserId}"'}
          ) ${Message.graphqlQuery(includeConversation: false)}
        }''')))
        .listen((event) {
      if (event.hasException && event.exception != null) {
        _controller.addError(event.exception.graphqlErrors.first.message);
      }
      if (event.data != null) {
        _controller
            .add(Mapper.fromJson(event.data['newMessage']).toObject<Message>());
      }
    });
  }

  Stream<Message> listen() => _controller.stream;

  Future cancel() => _streamSubscription?.cancel();
}

extension GraphqlSupscription on GraphqlService {
  Stream<Message> newMessageSubscription(ConversationKey key) {
    StreamSubscription<QueryResult> _streamSubscription;
    // ignore: close_sinks
    final controller = StreamController<Message>.broadcast(
      onCancel: () {
        _streamSubscription?.cancel();
      },
    );
    _streamSubscription = subscribe(
      SubscriptionOptions(document: gql('''subscription {
          newMessage (
            ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'senderId: "${key.targetUserId}"'}
          ) ${Message.graphqlQuery(includeConversation: false)}
        }''')),
    ).listen(
      (event) {
        if (event.hasException && event.exception != null) {
          controller.addError(event.exception.graphqlErrors.first.message);
        }
        if (event.data != null) {
          controller.add(
              Mapper.fromJson(event.data['newMessage']).toObject<Message>());
        }
      },
    );

    return controller.stream;
  }

  Stream<Message> messageChangeSubscription(ConversationKey key) {
    StreamSubscription<QueryResult> _streamSubscription;
    // ignore: close_sinks
    final controller = StreamController<Message>.broadcast(
      onCancel: () {
        _streamSubscription?.cancel();
      },
    );
    _streamSubscription = subscribe(
      SubscriptionOptions(document: gql('''subscription {
          messageChange (
            ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'senderId: "${key.targetUserId}"'}
          ) ${Message.graphqlQuery(includeConversation: false)}
        }''')),
    ).listen(
      (event) {
        if (event.hasException && event.exception != null) {
          controller.addError(event.exception.graphqlErrors.first.message);
        }
        if (event.data != null) {
          controller.add(
              Mapper.fromJson(event.data['messageChange']).toObject<Message>());
        }
      },
    );

    return controller.stream;
  }

  Stream<Conversation> conversationChangeSubscription() {
    StreamSubscription<QueryResult> _streamSubscription;
    // ignore: close_sinks
    final controller = StreamController<Conversation>.broadcast(
      onCancel: () {
        _streamSubscription?.cancel();
      },
    );
    _streamSubscription = subscribe(
      SubscriptionOptions(document: gql('''subscription {
          conversationChange ${Conversation.graphqlQuery}
        }''')),
    ).listen(
      (event) {
        if (event.hasException && event.exception != null) {
          controller.addError(event.exception.graphqlErrors.first.message);
        }
        if (event.data != null) {
          controller.add(Mapper.fromJson(event.data['conversationChange'])
              .toObject<Conversation>());
        }
      },
    );

    return controller.stream;
  }

  Stream<Conversation> findAnonymousChatSubscription() {
    StreamSubscription<QueryResult> _streamSubscription;
    // ignore: close_sinks
    final controller = StreamController<Conversation>.broadcast(
      onCancel: () {
        _streamSubscription?.cancel();
      },
    );
    _streamSubscription = subscribe(
      SubscriptionOptions(document: gql('''subscription {
          findAnonymousChat ${Conversation.graphqlQuery}
        }''')),
    ).listen(
      (event) {
        if (event.hasException && event.exception != null) {
          controller.addError(event.exception.graphqlErrors.first.message);
        }
        if (event.data != null) {
          controller.add(Mapper.fromJson(event.data['findAnonymousChat'])
              .toObject<Conversation>());
        }
      },
    );

    debugPrint('Subscribed findAnonymousChat');
    return controller.stream;
  }

  Stream<Message> callSubscription(ConversationKey key) {
    StreamSubscription<QueryResult> _streamSubscription;
    // ignore: close_sinks
    final controller = StreamController<Message>.broadcast(
      onCancel: () {
        _streamSubscription?.cancel();
      },
    );
    _streamSubscription = subscribe(
      SubscriptionOptions(document: gql('''subscription {
          call(
            ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'receiverId: "${key.targetUserId}"'}
          ) ${Message.graphqlQuery(includeConversation: false)}
        }''')),
    ).listen(
      (event) {
        if (event.hasException && event.exception != null) {
          controller.addError(event.exception.graphqlErrors.first.message);
        }
        if (event.data != null) {
          controller
              .add(Mapper.fromJson(event.data['call']).toObject<Message>());
        }
      },
    );

    debugPrint('Calling $key...');
    return controller.stream;
  }
}
