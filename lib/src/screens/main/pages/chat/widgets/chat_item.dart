part of '../chat_page.dart';

class ChatItem extends StatefulWidget {
  final Conversation conversation;
  final Function onPressed;
  final Function onHided;
  final Function onDeleted;

  const ChatItem(
      {Key key,
      @required this.conversation,
      this.onPressed,
      this.onHided,
      this.onDeleted})
      : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    final unreadMessageCount = widget.conversation?.unreadMessageCount ?? 0;
    return Skeleton(
      enabled: widget.conversation == null,
      child: InkWell(
        onTap: widget.conversation == null
            ? null
            : () {
                if (widget.onPressed != null) {
                  widget.onPressed?.call();
                } else {
                  Get.toNamed(Routes.messages,
                      arguments: MessagesScreenParams(
                          conversation: widget.conversation));
                }
              },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                UserAvatar.fromConversation(conversation: widget.conversation),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SkeletonItem(
                        child: Text(
                          widget.conversation?.name ?? 'Loading name',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodyText2
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SkeletonItem(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              flex: 1,
                              child: Text(
                                widget.conversation?.newestMessage?.message ??
                                    (widget.conversation?.newestMessage !=
                                                null &&
                                            widget.conversation.newestMessage
                                                .attachments.isExistAndNotEmpty
                                        ? '[${Strings.common.image}]'
                                        : 'Loading last message'),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodyText1.copyWith(
                                  fontWeight: unreadMessageCount > 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                            Text(
                              ' ‧ ' +
                                  (widget.conversation?.newestMessage != null
                                      ? TimeAgo.format(widget
                                          .conversation.newestMessage.createdAt)
                                      : 'Loading time'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.caption.copyWith(
                                color: context.colorScheme.onBackground,
                                fontWeight: unreadMessageCount > 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (unreadMessageCount > 0) ...[
                  const SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF5555),
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(minWidth: 20, minHeight: 20),
                    child: Text(
                      widget.conversation.unreadMessageCount.toString(),
                      style: TextStyle(
                        color: context.colorScheme.onError,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
