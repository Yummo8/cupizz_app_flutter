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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final params = RouterService.getParam<MessagesScreenParams>(context);
      Momentum.controller<MessagesScreenController>(context)
          ._reload(key: params.conversationKey);
    });
  }

  @override
  void dispose() {
    Momentum.controller<MessagesScreenController>(context).reset();
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
              return Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: UserAvatar.fromConversation(
                        conversation: model.conversation),
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
                            style: context.textTheme.bodyText2,
                          ),
                        ),
                        // TODO add lastOnline to conversation server side
                        if (false)
                          SkeletonItem(
                            child: Text(
                              model.conversation?.name ?? 'Loading',
                              style: context.textTheme.caption,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
      body: DashChat(
        user: ChatUser(
          name: "Hien",
          uid: "001",
          avatar:
              "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
        ),
        messages: [
          ChatMessage(
              text: 'Welcome', user: ChatUser(uid: '002', name: 'Cupid')),
          ChatMessage(
              text: 'Welcome', user: ChatUser(uid: '002', name: 'Cupid')),
          ChatMessage(
              text: 'Welcome', user: ChatUser(uid: '003', name: '2Cupid')),
          ChatMessage(
              text: 'Welcome', user: ChatUser(uid: '001', name: 'Cupid')),
          ChatMessage(
              text: 'Welcome2', user: ChatUser(uid: '001', name: 'Cupid')),
        ],
        onSend: (ChatMessage message) {},
      ),
    );
  }
}
