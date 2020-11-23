library messages_screen;

import 'package:flutter/material.dart' hide Router;

import '../../base/base.dart';

part 'components/messages_screen.controller.dart';
part 'components/messages_screen.model.dart';

class MessagesScreenParams extends RouterParam {
  final ConversationKey conversationKey;

  MessagesScreenParams(this.conversationKey);
}

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  MessagesScreenController controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller = Momentum.controller<MessagesScreenController>(context);
      final params = RouterService.getParam<MessagesScreenParams>(context);
      if (params != null) {
        controller.loadData(params?.conversationKey);
      }
    });
  }

  @override
  void dispose() {
    controller?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: context.colorScheme.background,
        shadowColor: context.colorScheme.onBackground,
        elevation: 1,
        leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.chevron_left,
              color: context.colorScheme.onBackground,
              size: 40,
            ),
            onPressed: () {
              RouterService.pop(context);
            }),
        title: MomentumBuilder(
            controllers: [MessagesScreenController],
            builder: (context, snapshot) {
              final model = snapshot<MessagesScreenModel>();
              return Skeleton(
                enabled: model.isLoading,
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: UserAvatar.fromConversation(
                        conversation: model.conversation,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SkeletonItem(
                            child: Text(
                              model.conversation?.name ?? 'Loading',
                              style: context.textTheme.bodyText1
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          // TODO add lastOnline to conversation server side
                          if (false)
                            SkeletonItem(
                              height: 26,
                              child: Text(
                                model.conversation?.name ?? '',
                                style: context.textTheme.caption,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
      body: MomentumBuilder(
          controllers: [MessagesScreenController],
          builder: (context, snapshot) {
            final model = snapshot<MessagesScreenModel>();
            return DashChat(
              onLoadEarlier: () {
                model.controller.loadmore();
              },
              inverted: true,
              dateFormat: DateFormat('dd/MM/yyyy'),
              timeFormat: DateFormat('hh:mm'),
              user: Momentum.controller<CurrentUserController>(context)
                  .model
                  .currentUser,
              messages: <Message>[
                ...model.messages,
                ...!model.isLastPage || model.isLoading
                    ? List.generate(10, (_) => null)
                    : [],
              ].toList(),
              onSend: (Message message) {},
            );
          }),
    );
  }
}
