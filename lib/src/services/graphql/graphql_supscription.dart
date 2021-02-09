part of 'index.dart';

class MessageSubscription extends MomentumService {
  StreamSubscription<FetchResult> _streamSubscription;
  final StreamController _controller = StreamController<Message>.broadcast();

  void init(ConversationKey key) {
    _streamSubscription?.cancel();
    _streamSubscription = Get.find<GraphqlService>()
        .subscribe(Operation(documentNode: gql('''subscription {
          newMessage (
            ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'senderId: "${key.targetUserId}"'}
          ) ${Message.graphqlQuery(includeConversation: false)}
        }''')))
        .listen((event) {
      if (event.errors != null && event.errors.isNotEmpty) {
        _controller.addError(event.errors[0].toString());
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
    StreamSubscription<FetchResult> _streamSubscription;
    // ignore: close_sinks
    final controller = StreamController<Message>.broadcast(
      onCancel: () {
        _streamSubscription?.cancel();
      },
    );
    _streamSubscription = subscribe(
      Operation(documentNode: gql('''subscription {
          newMessage (
            ${key.conversationId.isExistAndNotEmpty ? 'conversationId: "${key.conversationId}"' : 'senderId: "${key.targetUserId}"'}
          ) ${Message.graphqlQuery(includeConversation: false)}
        }''')),
    ).listen(
      (event) {
        if (event.errors != null && event.errors.isNotEmpty) {
          controller.addError(event.errors[0].toString());
        }
        if (event.data != null) {
          controller.add(
              Mapper.fromJson(event.data['newMessage']).toObject<Message>());
        }
      },
    );

    return controller.stream;
  }

  Stream<Conversation> conversationChangeSubscription() {
    StreamSubscription<FetchResult> _streamSubscription;
    // ignore: close_sinks
    final controller = StreamController<Conversation>.broadcast(
      onCancel: () {
        _streamSubscription?.cancel();
      },
    );
    _streamSubscription = subscribe(
      Operation(documentNode: gql('''subscription {
          conversationChange ${Conversation.graphqlQuery}
        }''')),
    ).listen(
      (event) {
        if (event.errors != null && event.errors.isNotEmpty) {
          controller.addError(event.errors[0].toString());
        }
        if (event.data != null) {
          controller.add(Mapper.fromJson(event.data['conversationChange'])
              .toObject<Conversation>());
        }
      },
    );

    return controller.stream;
  }
}
