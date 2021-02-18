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
  final Conversation conversation;

  MessagesScreenParams({this.conversationKey, this.conversation})
      : assert(conversation != null || conversationKey != null);
}

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  MessagesScreenController controller;

  @override
  void dispose() {
    controller?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller ??= Momentum.controller<MessagesScreenController>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final args = Get.arguments as MessagesScreenParams;
      if (args != null) {
        controller.loadData(args);
      }
    });
    return MomentumBuilder(
        controllers: [MessagesScreenController],
        builder: (context, snapshot) {
          final model = snapshot<MessagesScreenModel>();
          return PrimaryScaffold(
            appBar: model.conversation == null ||
                    model.conversation.isAnonymousChat
                ? null
                : AppBar(
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
                          Get.back();
                        }),
                    title: Skeleton(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SkeletonItem(
                                    child: Text(
                                      model.conversation?.name ?? 'Loading',
                                      style: context.textTheme.bodyText1
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  if (model.conversation?.onlineStatus !=
                                              null &&
                                          model.conversation.onlineStatus ==
                                              OnlineStatus.online ||
                                      model.conversation?.lastOnline != null)
                                    SkeletonItem(
                                      child: Text(
                                        model.conversation.onlineStatus ==
                                                OnlineStatus.online
                                            ? 'Đang online'
                                            : Strings.messageScreen
                                                .lastOnlineAt(TimeAgo.format(
                                                    model.conversation
                                                        .lastOnline)),
                                        style: context.textTheme.caption,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            body: MessagesScreenWidget(model: model),
          );
        });
  }
}

class MessagesScreenWidget extends StatelessWidget {
  const MessagesScreenWidget({
    Key key,
    @required this.model,
  }) : super(key: key);

  final MessagesScreenModel model;

  @override
  Widget build(BuildContext context) {
    return DashChat(
      inverted: true,
      shouldShowLoadEarlier:
          !(model.conversation?.messages?.isLastPage ?? false),
      dateFormat: DateFormat('dd/MM/yyyy'),
      timeFormat: DateFormat('HH:mm'),
      user:
          Momentum.controller<CurrentUserController>(context).model.currentUser,
      messages: model.isLoading ? [] : model.conversation?.messages?.data ?? [],
      inputContainerStyle: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colorScheme.surface),
        ),
      ),
      inputDecoration: InputDecoration(hintText: Strings.messageScreen.hint),
      trailing: [
        IconButton(
            icon: Icon(CupertinoIcons.camera),
            onPressed: model.isSendingMessage
                ? null
                : () => pickImage(context, (images) {
                      model.controller.sendMessage(attachments: images);
                    }))
      ],
      sendButtonBuilder: (onSend) {
        return IconButton(
            icon: model.isSendingMessage
                ? LoadingIndicator(size: 20)
                : Icon(CupertinoIcons.paperplane),
            onPressed: model.isSendingMessage ? null : onSend);
      },
      onSend: (Message message) {
        model.controller.sendMessage(message: message.message);
      },
      onLoadEarlier: () {
        model.controller.loadmore();
      },
    );
  }
}
