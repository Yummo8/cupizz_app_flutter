part of dash_chat;

class MessageListView extends StatefulWidget {
  final List<Message> messages;
  final SimpleUser user;
  final bool showuserAvatar;
  final DateFormat dateFormat;
  final DateFormat timeFormat;
  final bool showAvatarForEverMessage;
  final Function(SimpleUser user) onPressAvatar;
  final Function(SimpleUser user) onLongPressAvatar;
  final bool renderAvatarOnTop;
  final Function(Message) onLongPressMessage;
  final bool inverted;
  final Widget Function(SimpleUser user) avatarBuilder;
  final Widget Function(Message) messageBuilder;
  final Widget Function(String, [Message]) messageTextBuilder;
  final Widget Function(String, [Message]) messageImageBuilder;
  final Widget Function(String, [Message]) messageTimeBuilder;
  final Widget Function(String) dateBuilder;
  final Widget Function() renderMessageFooter;
  final BoxDecoration messageContainerDecoration;
  final List<MatchText> parsePatterns;
  final ScrollController scrollController;
  final EdgeInsets messageContainerPadding;
  final Function changeVisible;
  final bool visible;
  final bool showLoadMore;
  final bool shouldShowLoadEarlier;
  final Widget Function() showLoadEarlierWidget;
  final Function onLoadEarlier;
  final Function(bool) defaultLoadCallback;
  final BoxConstraints constraints;
  final List<Widget> Function(Message) messageButtonsBuilder;
  final EdgeInsets messagePadding;
  final bool textBeforeImage;
  final double avatarMaxSize;
  final BoxDecoration Function(Message, bool) messageDecorationBuilder;

  MessageListView({
    this.showLoadEarlierWidget,
    this.avatarMaxSize,
    this.shouldShowLoadEarlier,
    this.constraints,
    this.onLoadEarlier,
    this.defaultLoadCallback,
    this.messageContainerPadding =
        const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
    this.scrollController,
    this.parsePatterns = const [],
    this.messageContainerDecoration,
    this.messages,
    this.user,
    this.showuserAvatar,
    this.dateFormat,
    this.timeFormat,
    this.showAvatarForEverMessage,
    this.inverted,
    this.onLongPressAvatar,
    this.onLongPressMessage,
    this.onPressAvatar,
    this.renderAvatarOnTop,
    this.messageBuilder,
    this.renderMessageFooter,
    this.avatarBuilder,
    this.dateBuilder,
    this.messageImageBuilder,
    this.messageTextBuilder,
    this.messageTimeBuilder,
    this.changeVisible,
    this.visible,
    this.showLoadMore,
    this.messageButtonsBuilder,
    this.messagePadding = const EdgeInsets.all(8.0),
    this.textBeforeImage = true,
    this.messageDecorationBuilder,
  });

  @override
  _MessageListViewState createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  double previousPixelPostion = 0.0;

  bool scrollNotificationFunc(ScrollNotification scrollNotification) {
    final bottom =
        widget.inverted ? 0.0 : scrollNotification.metrics.maxScrollExtent;

    if (scrollNotification.metrics.pixels == bottom) {
      if (widget.visible) {
        widget.changeVisible(false);
      }
    } else if ((scrollNotification.metrics.pixels - bottom).abs() > 100) {
      if (!widget.visible) {
        widget.changeVisible(true);
      }
    }
    return true;
  }

  bool shouldShowAvatar(int index) {
    if (widget.showAvatarForEverMessage) {
      return true;
    }
    if (!widget.inverted && index + 1 < widget.messages.length) {
      return widget.messages[index + 1].sender.id !=
          widget.messages[index].sender.id;
    } else if (widget.inverted && index - 1 >= 0) {
      return widget.messages[index - 1].sender.id !=
          widget.messages[index].sender.id;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final constraints = widget.constraints ??
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);

    return Flexible(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Padding(
          padding: widget.messageContainerPadding,
          child: NotificationListener<ScrollNotification>(
            onNotification: scrollNotificationFunc,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                ListView.builder(
                  controller: widget.scrollController,
                  shrinkWrap: true,
                  reverse: widget.inverted,
                  itemCount: widget.messages.length,
                  itemBuilder: (context, i) {
                    var first = false;
                    var last = false;
                    final isUser = widget.messages[i] != null
                        ? widget.messages[i].sender.id == widget.user.id
                        : Random().nextInt(2) == 1;
                    final showAvatar = widget.messages[i] != null
                        ? shouldShowAvatar(i)
                        : !isUser;

                    if (widget.messages.isEmpty) {
                      first = true;
                    } else if (widget.messages.length - 1 == i) {
                      last = true;
                    }

                    return Align(
                      child: Column(
                        children: <Widget>[
                          if (widget.messages[i] != null &&
                                  i >= widget.messages.length - 1 ||
                              widget.messages[i] != null &&
                                  widget.messages[i + 1] != null &&
                                  !widget.messages[i].createdAt.inSameDay(
                                      widget.messages[i + 1].createdAt))
                            DateBuilder(
                              key: UniqueKey(),
                              date: widget.messages[i].createdAt,
                              customDateBuilder: widget.dateBuilder,
                              dateFormat: widget.dateFormat,
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: first ? 10.0 : 0.0,
                              bottom: last ? 10.0 : 0.0,
                            ),
                            child: Row(
                              mainAxisAlignment: isUser
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: constraints.maxWidth * 0.02,
                                    vertical: 5,
                                  ),
                                  child: Opacity(
                                    opacity: (widget.showAvatarForEverMessage ||
                                                showAvatar) &&
                                            (widget.messages[i] == null ||
                                                widget.messages[i].sender.id !=
                                                    widget.user.id)
                                        ? 1
                                        : 0,
                                    child: AvatarContainer(
                                      key: UniqueKey(),
                                      user: widget.messages[i]?.sender,
                                      onPress: widget.onPressAvatar,
                                      onLongPress: widget.onLongPressAvatar,
                                      avatarBuilder: widget.avatarBuilder,
                                      avatarMaxSize: widget.avatarMaxSize,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onLongPress: widget.messages[i] == null
                                        ? null
                                        : () {
                                            if (widget.onLongPressMessage !=
                                                null) {
                                              widget.onLongPressMessage(
                                                  widget.messages[i]);
                                            } else {
                                              showBottomSheet(
                                                  context: context,
                                                  builder: (context) =>
                                                      Container(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            ListTile(
                                                              leading: Icon(Icons
                                                                  .content_copy),
                                                              title:
                                                                  Text('Copy'),
                                                              onTap: () {
                                                                Clipboard.setData(ClipboardData(
                                                                    text: widget
                                                                        .messages[
                                                                            i]
                                                                        .message));
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      ));
                                            }
                                          },
                                    child: widget.messageBuilder != null &&
                                            widget.messages[i] != null
                                        ? widget
                                            .messageBuilder(widget.messages[i])
                                        : Align(
                                            alignment: isUser
                                                ? AlignmentDirectional.centerEnd
                                                : AlignmentDirectional
                                                    .centerStart,
                                            child: MessageContainer(
                                              messagePadding:
                                                  widget.messagePadding,
                                              constraints: constraints,
                                              isUser: isUser,
                                              message: widget.messages[i],
                                              timeFormat: widget.timeFormat,
                                              messageImageBuilder:
                                                  widget.messageImageBuilder,
                                              messageTextBuilder:
                                                  widget.messageTextBuilder,
                                              messageTimeBuilder:
                                                  widget.messageTimeBuilder,
                                              messageContainerDecoration: widget
                                                  .messageContainerDecoration,
                                              parsePatterns:
                                                  widget.parsePatterns,
                                              messageButtonsBuilder:
                                                  widget.messageButtonsBuilder,
                                              textBeforeImage:
                                                  widget.textBeforeImage,
                                              messageDecorationBuilder: widget
                                                  .messageDecorationBuilder,
                                            ),
                                          ),
                                  ),
                                ),
                                if (widget.showuserAvatar)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth * 0.02,
                                    ),
                                    child: Opacity(
                                      opacity:
                                          (widget.showAvatarForEverMessage ||
                                                      showAvatar) &&
                                                  isUser
                                              ? 1
                                              : 0,
                                      child: AvatarContainer(
                                        user: widget.messages[i]?.sender,
                                        onPress: widget.onPressAvatar,
                                        onLongPress: widget.onLongPressAvatar,
                                        avatarBuilder: widget.avatarBuilder,
                                        avatarMaxSize: widget.avatarMaxSize,
                                      ),
                                    ),
                                  )
                                else
                                  SizedBox(
                                    width: 10.0,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 100),
                AnimatedPositioned(
                  top: widget.showLoadMore ? 8.0 : -50.0,
                  duration: Duration(milliseconds: 200),
                  child: widget.showLoadEarlierWidget != null
                      ? widget.showLoadEarlierWidget()
                      : LoadEarlierWidget(
                          onLoadEarlier: widget.onLoadEarlier,
                          defaultLoadCallback: widget.defaultLoadCallback,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
