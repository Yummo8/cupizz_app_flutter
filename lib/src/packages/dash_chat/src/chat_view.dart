part of dash_chat;

class DashChat extends StatefulWidget {
  final int messageContainerFlex;
  final bool readOnly;
  final double height;
  final double width;
  final List<Message> messages;
  final TextEditingController textController;
  final FocusNode focusNode;
  final TextDirection inputTextDirection;
  final String text;
  final Function(String) onTextChange;
  final bool inputDisabled;
  final InputDecoration inputDecoration;
  final TextCapitalization textCapitalization;
  final String Function() messageIdGenerator;
  final SimpleUser user;
  final Function(Message) onSend;
  final bool alwaysShowSend;
  final bool sendOnEnter;
  final TextInputAction textInputAction;
  final DateFormat dateFormat;
  final DateFormat timeFormat;
  final bool showUserAvatar;
  final Widget Function(SimpleUser) avatarBuilder;
  final bool showAvatarForEveryMessage;
  final Function(SimpleUser) onPressAvatar;
  final Function(SimpleUser) onLongPressAvatar;
  final Function(Message) onLongPressMessage;
  final bool inverted;
  final Widget Function(Message) messageBuilder;
  final Widget Function(String, [Message]) messageTextBuilder;
  final Widget Function(String url, [Message]) messageImageBuilder;
  final Widget Function(String url, [Message]) messageTimeBuilder;
  final Widget Function(String) dateBuilder;
  final Widget Function() chatFooterBuilder;
  final int maxInputLength;
  final List<MatchText> parsePatterns;
  final BoxDecoration messageContainerDecoration;
  final List<Widget> leading;
  final List<Widget> trailing;
  final Widget Function(Function) sendButtonBuilder;
  final TextStyle inputTextStyle;
  final BoxDecoration inputContainerStyle;
  final int inputMaxLines;
  final bool showInputCursor;
  final double inputCursorWidth;
  final Color inputCursorColor;
  final ScrollController scrollController;
  final Widget Function() inputFooterBuilder;
  final EdgeInsetsGeometry messageContainerPadding;
  final Function(Reply) onQuickReply;
  final EdgeInsetsGeometry quickReplyPadding;
  final BoxDecoration quickReplyStyle;
  final TextStyle quickReplyTextStyle;
  final Widget Function(Reply) quickReplyBuilder;
  final bool quickReplyScroll;
  final bool showTraillingBeforeSend;
  final bool scrollToBottom;
  final bool shouldStartMessagesFromTop;
  final Widget Function() scrollToBottomWidget;
  final Function onScrollToBottomPress;
  final bool shouldShowLoadEarlier;
  final Widget Function() showLoadEarlierWidget;
  final Function onLoadEarlier;
  final EdgeInsets inputToolbarPadding;
  final EdgeInsets inputToolbarMargin;
  final List<Widget> Function(Message) messageButtonsBuilder;
  final EdgeInsets messagePadding;
  final bool textBeforeImage;
  final double avatarMaxSize;
  final BoxDecoration Function(Message, bool) messageDecorationBuilder;
  final ScrollToBottomStyle scrollToBottomStyle;

  DashChat({
    Key key,
    ScrollToBottomStyle scrollToBottomStyle,
    this.avatarMaxSize = 30.0,
    this.inputTextDirection = TextDirection.ltr,
    this.inputToolbarMargin = const EdgeInsets.all(0.0),
    this.inputToolbarPadding = const EdgeInsets.all(0.0),
    this.shouldShowLoadEarlier = false,
    this.showLoadEarlierWidget,
    this.onLoadEarlier,
    this.sendOnEnter = false,
    this.textInputAction,
    this.scrollToBottom = true,
    this.scrollToBottomWidget,
    this.onScrollToBottomPress,
    this.onQuickReply,
    this.quickReplyPadding = const EdgeInsets.all(0.0),
    this.quickReplyStyle,
    this.quickReplyTextStyle,
    this.quickReplyBuilder,
    this.quickReplyScroll = false,
    this.messageContainerPadding = const EdgeInsets.only(
      left: 2.0,
      right: 2.0,
    ),
    this.scrollController,
    this.inputCursorColor,
    this.inputCursorWidth = 2.0,
    this.showInputCursor = true,
    this.inputMaxLines = 1,
    this.inputContainerStyle,
    this.inputTextStyle,
    this.leading = const <Widget>[],
    this.trailing = const <Widget>[],
    this.messageContainerDecoration,
    this.messageContainerFlex = 1,
    this.height,
    this.width,
    this.readOnly = false,
    @required this.messages,
    this.onTextChange,
    this.text,
    this.inputDisabled = false,
    this.textController,
    this.focusNode,
    this.inputDecoration,
    this.textCapitalization = TextCapitalization.none,
    this.alwaysShowSend = false,
    this.messageIdGenerator,
    this.dateFormat,
    this.timeFormat,
    @required this.user,
    @required this.onSend,
    this.onLongPressAvatar,
    this.onLongPressMessage,
    this.onPressAvatar,
    this.avatarBuilder,
    this.showAvatarForEveryMessage = false,
    this.showUserAvatar = false,
    this.inverted = false,
    this.maxInputLength,
    this.parsePatterns = const <MatchText>[],
    this.chatFooterBuilder,
    this.messageBuilder,
    this.inputFooterBuilder,
    this.sendButtonBuilder,
    this.dateBuilder,
    this.messageImageBuilder,
    this.messageTextBuilder,
    this.messageTimeBuilder,
    this.showTraillingBeforeSend = true,
    this.shouldStartMessagesFromTop = false,
    this.messageButtonsBuilder,
    this.messagePadding = const EdgeInsets.all(8.0),
    this.textBeforeImage = true,
    this.messageDecorationBuilder,
  })  : scrollToBottomStyle = scrollToBottomStyle ?? ScrollToBottomStyle(),
        super(key: key);

  String getVal() {
    return text;
  }

  @override
  DashChatState createState() => DashChatState();
}

class DashChatState extends State<DashChat> {
  FocusNode inputFocusNode;
  TextEditingController textController;
  ScrollController scrollController;
  String _text = '';
  bool visible = false;
  GlobalKey inputKey = GlobalKey();
  double height = 48.0;
  bool showLoadMore = false;
  String get messageInput => _text;
  bool _initialLoad = true;
  Timer _timer;

  void onTextChange(String text) {
    if (visible) {
      changeVisible(false);
    }
    setState(() {
      _text = text;
    });
  }

  void changeVisible(bool value) {
    if (widget.scrollToBottom) {
      setState(() {
        visible = value;
      });
    }
  }

  void changeDefaultLoadMore(bool value) {
    setState(() {
      showLoadMore = value;
    });
  }

  @override
  void initState() {
    scrollController = widget.scrollController ?? ScrollController();
    textController = widget.textController ?? TextEditingController();
    inputFocusNode = widget.focusNode ?? FocusNode();
    WidgetsBinding.instance.addPostFrameCallback(widgetBuilt);
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void widgetBuilt(Duration d) {
    final initPos = widget.inverted
        ? 0.0
        : scrollController.position.maxScrollExtent + 25.0;

    scrollController
        .animateTo(
      initPos,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    )
        .whenComplete(() {
      _timer = Timer(Duration(milliseconds: 1000), () {
        if (mounted) {
          setState(() {
            _initialLoad = false;
          });
        }
      });
    });

    scrollController.addListener(() {
      final topReached = widget.inverted
          ? scrollController.offset >=
                  scrollController.position.maxScrollExtent &&
              !scrollController.position.outOfRange
          : scrollController.offset <=
                  scrollController.position.minScrollExtent &&
              !scrollController.position.outOfRange;

      if (widget.shouldShowLoadEarlier) {
        if (topReached) {
          setState(() {
            showLoadMore = true;
          });
        } else {
          setState(() {
            showLoadMore = false;
          });
        }
      } else if (topReached) {
        widget.onLoadEarlier();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth == double.infinity
            ? MediaQuery.of(context).size.width
            : constraints.maxWidth;
        final maxHeight = constraints.maxWidth == double.infinity
            ? MediaQuery.of(context).size.height
            : constraints.maxHeight;
        return Container(
          height: widget.height ?? maxHeight,
          width: widget.width ?? maxWidth,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: widget.shouldStartMessagesFromTop
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: <Widget>[
                  MessageListView(
                      avatarMaxSize: widget.avatarMaxSize,
                      messagePadding: widget.messagePadding,
                      constraints: constraints,
                      shouldShowLoadEarlier: widget.shouldShowLoadEarlier,
                      showLoadEarlierWidget: widget.showLoadEarlierWidget,
                      onLoadEarlier: widget.onLoadEarlier,
                      defaultLoadCallback: changeDefaultLoadMore,
                      messageContainerPadding: widget.messageContainerPadding,
                      scrollController:
                          widget.scrollController ?? scrollController,
                      user: widget.user,
                      messages: widget.messages,
                      showuserAvatar: widget.showUserAvatar,
                      dateFormat: widget.dateFormat,
                      timeFormat: widget.timeFormat,
                      inverted: widget.inverted,
                      showAvatarForEverMessage:
                          widget.showAvatarForEveryMessage,
                      onLongPressAvatar: widget.onLongPressAvatar,
                      onPressAvatar: widget.onPressAvatar,
                      onLongPressMessage: widget.onLongPressMessage,
                      avatarBuilder: widget.avatarBuilder,
                      messageBuilder: widget.messageBuilder,
                      messageTextBuilder: widget.messageTextBuilder,
                      messageImageBuilder: widget.messageImageBuilder,
                      messageTimeBuilder: widget.messageTimeBuilder,
                      dateBuilder: widget.dateBuilder,
                      messageContainerDecoration:
                          widget.messageContainerDecoration,
                      parsePatterns: widget.parsePatterns,
                      changeVisible: changeVisible,
                      visible: visible,
                      showLoadMore: showLoadMore,
                      messageButtonsBuilder: widget.messageButtonsBuilder,
                      messageDecorationBuilder:
                          widget.messageDecorationBuilder),
                  if (widget.chatFooterBuilder != null)
                    widget.chatFooterBuilder(),
                  if (!widget.readOnly)
                    ChatInputToolbar(
                        key: inputKey,
                        sendOnEnter: widget.sendOnEnter,
                        textInputAction: widget.textInputAction,
                        inputToolbarPadding: widget.inputToolbarPadding,
                        textDirection: widget.inputTextDirection,
                        inputToolbarMargin: widget.inputToolbarMargin,
                        showTraillingBeforeSend: widget.showTraillingBeforeSend,
                        inputMaxLines: widget.inputMaxLines,
                        controller: textController,
                        inputDecoration: widget.inputDecoration,
                        textCapitalization: widget.textCapitalization,
                        onSend: widget.onSend,
                        user: widget.user,
                        messageIdGenerator: widget.messageIdGenerator,
                        maxInputLength: widget.maxInputLength,
                        sendButtonBuilder: widget.sendButtonBuilder,
                        text: widget.text ?? _text,
                        onTextChange: widget.onTextChange ?? onTextChange,
                        inputDisabled: widget.inputDisabled,
                        leading: widget.leading,
                        trailling: widget.trailing,
                        inputContainerStyle: widget.inputContainerStyle,
                        inputTextStyle: widget.inputTextStyle,
                        inputFooterBuilder: widget.inputFooterBuilder,
                        inputCursorColor: widget.inputCursorColor,
                        inputCursorWidth: widget.inputCursorWidth,
                        showInputCursor: widget.showInputCursor,
                        alwaysShowSend: widget.alwaysShowSend,
                        scrollController:
                            widget.scrollController ?? scrollController,
                        focusNode: inputFocusNode,
                        reverse: widget.inverted)
                ],
              ),
              if (visible && !_initialLoad)
                Positioned(
                  right: widget.scrollToBottomStyle.right,
                  left: widget.scrollToBottomStyle.left,
                  bottom: widget.scrollToBottomStyle.bottom,
                  top: widget.scrollToBottomStyle.top,
                  child: widget.scrollToBottomWidget != null
                      ? widget.scrollToBottomWidget()
                      : ScrollToBottom(
                          onScrollToBottomPress: widget.onScrollToBottomPress,
                          scrollToBottomStyle: widget.scrollToBottomStyle,
                          scrollController: scrollController,
                          inverted: widget.inverted,
                        ),
                ),
            ],
          ),
        );
      },
    );
  }

  QuickReply mapReply(Reply reply) => QuickReply(
        reply: reply,
        onReply: widget.onQuickReply,
        quickReplyBuilder: widget.quickReplyBuilder,
        quickReplyStyle: widget.quickReplyStyle,
        quickReplyTextStyle: widget.quickReplyTextStyle,
      );
}
