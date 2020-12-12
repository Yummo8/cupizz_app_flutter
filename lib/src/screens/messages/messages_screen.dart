library messages_screen;

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart' hide Router;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pedantic/pedantic.dart';

import '../../base/base.dart';

part 'components/messages_screen.controller.dart';
part 'components/messages_screen.model.dart';

class MessagesScreenParams extends RouterParam {
  final ConversationKey conversationKey;

  MessagesScreenParams(this.conversationKey);
}

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Momentum.controller<MessagesScreenController>(context);
    controller.reset();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final params = Router.getParam<MessagesScreenParams>(context);
      if (params != null) {
        controller.loadData(params?.conversationKey);
      }
    });
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
              Router.pop(context);
            }),
        title: MomentumBuilder(
            controllers: [MessagesScreenController],
            builder: (context, snapshot) {
              final model = snapshot<MessagesScreenModel>();
              return Skeleton(
                enabled: model.isLoading,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        child: UserAvatar.fromConversation(
                          size: 30,
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
                            if (model.conversation?.lastOnline != null)
                              SkeletonItem(
                                child: Text(
                                  Strings.messageScreen.lastOnlineAt(
                                      TimeAgo.format(
                                          model.conversation.lastOnline)),
                                  style: context.textTheme.caption,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
              timeFormat: DateFormat('HH:mm'),
              user: Momentum.controller<CurrentUserController>(context)
                  .model
                  .currentUser,
              messages: <Message>[
                ...model.isLoading ? [] : model.messages,
                ...!model.isLastPage || model.isLoading
                    ? List.generate(model.isLoading ? 10 : 2, (_) => null)
                    : [],
              ].toList(),
              onSend: (Message message) {
                controller?.sendMessage(message: message.message);
              },
              inputContainerStyle: BoxDecoration(
                border: Border(
                  top: BorderSide(color: context.colorScheme.onSurface),
                ),
              ),
              inputDecoration: InputDecoration(
                hintText: Strings.messageScreen.hint,
              ),
              trailing: [
                IconButton(
                    icon: Icon(Icons.camera_alt_outlined),
                    onPressed: model.isSendingMessage
                        ? null
                        : () => pickImage(context, (images) {
                              controller?.sendMessage(attachments: images);
                            }))
              ],
              sendButtonBuilder: (onSend) {
                return IconButton(
                    icon: model.isSendingMessage
                        ? LoadingIndicator(size: 20)
                        : Icon(Icons.send),
                    onPressed: model.isSendingMessage ? null : onSend);
              },
            );
          }),
    );
  }
}
