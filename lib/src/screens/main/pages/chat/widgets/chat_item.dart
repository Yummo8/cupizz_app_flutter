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
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed?.call();
        } else {
          // TODO navigate
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffD1D1D1),
            ),
          ),
        ),
        child: SafeArea(
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              widget.conversation?.avatar ?? ''),
                        ),
                      ),
                    ),
                    if (widget.conversation?.isOnline != null)
                      Positioned(
                        bottom: 0,
                        right: 3,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(widget.conversation.isOnline
                                ? 0xff20FF6C
                                : 0xff7D7D7D),
                          ),
                        ),
                      )
                  ],
                ),
                const SizedBox(width: 17),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.conversation?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyText2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.conversation?.message ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        widget.conversation?.time != null
                            ? TimeAgo.format(widget.conversation.time)
                            : '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: context.colorScheme.onBackground,
                        ),
                      ),
                      if ((widget.conversation?.unreadMessages ?? 0) > 0)
                        Container(
                          padding: EdgeInsets.all(7),
                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                            color: Color(0xFFFF5555),
                            shape: BoxShape.circle,
                          ),
                          constraints:
                              BoxConstraints(minWidth: 25, minHeight: 25),
                          child: new Text(
                            widget.conversation.unreadMessages.toString(),
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
