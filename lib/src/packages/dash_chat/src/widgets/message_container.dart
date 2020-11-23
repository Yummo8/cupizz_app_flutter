part of dash_chat;

class MessageContainer extends StatelessWidget {
  final Message message;
  final DateFormat timeFormat;
  final Widget Function(String, [Message]) messageTextBuilder;
  final Widget Function(String, [Message]) messageImageBuilder;
  final Widget Function(String, [Message]) messageTimeBuilder;
  final BoxDecoration messageContainerDecoration;
  final List<MatchText> parsePatterns;
  final bool isUser;
  final List<Widget> buttons;
  final List<Widget> Function(Message) messageButtonsBuilder;
  final BoxConstraints constraints;
  final EdgeInsets messagePadding;
  final bool textBeforeImage;
  final BoxDecoration Function(Message, bool) messageDecorationBuilder;

  const MessageContainer({
    @required this.message,
    @required this.timeFormat,
    this.constraints,
    this.messageImageBuilder,
    this.messageTextBuilder,
    this.messageTimeBuilder,
    this.messageContainerDecoration,
    this.parsePatterns = const <MatchText>[],
    this.textBeforeImage = true,
    this.isUser,
    this.messageButtonsBuilder,
    this.buttons,
    this.messagePadding = const EdgeInsets.all(8.0),
    this.messageDecorationBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final constraints = this.constraints ??
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth * 0.8,
      ),
      child: Container(
        decoration: messageDecorationBuilder != null
            ? messageDecorationBuilder(message, isUser)
            : messageContainerDecoration != null
                ? messageContainerDecoration.copyWith(
                    color: messageContainerDecoration.color,
                  )
                : BoxDecoration(
                    color: isUser
                        ? Theme.of(context).primaryColor
                        : context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
        margin: EdgeInsets.only(
          bottom: 5.0,
        ),
        padding: messagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            if (this.textBeforeImage)
              _buildMessageText(context)
            else
              _buildMessageImage(),
            if (this.textBeforeImage)
              _buildMessageImage()
            else
              _buildMessageText(context),
            if (buttons != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:
                    isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: buttons,
              )
            else if (messageButtonsBuilder != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:
                    isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: messageButtonsBuilder(message),
                mainAxisSize: MainAxisSize.min,
              ),
            if (messageTimeBuilder != null)
              messageTimeBuilder(
                timeFormat != null
                    ? timeFormat.format(message.createdAt)
                    : DateFormat('HH:mm:ss').format(message.createdAt),
                message,
              )
            else
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  timeFormat != null
                      ? timeFormat.format(message.createdAt)
                      : DateFormat('HH:mm:ss').format(message.createdAt),
                  style: TextStyle(
                    fontSize: 10.0,
                    color: isUser
                        ? context.colorScheme.onPrimary
                        : context.colorScheme.onBackground,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageText(BuildContext context) {
    if (messageTextBuilder != null)
      return messageTextBuilder(message.message, message);
    else
      return ParsedText(
        parse: parsePatterns,
        text: message.message,
        style: TextStyle(
          color: isUser
              ? context.colorScheme.onPrimary
              : context.colorScheme.onBackground,
        ),
      );
  }

  Widget _buildMessageImage() {
    // TODO build multi image
    if (message.attachments != null && message.attachments.isNotEmpty) {
      if (messageImageBuilder != null)
        return messageImageBuilder(message.attachments[0].thumbnail, message);
      else
        return Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: FadeInImage.memoryNetwork(
            height: constraints.maxHeight * 0.3,
            width: constraints.maxWidth * 0.7,
            fit: BoxFit.contain,
            placeholder: kTransparentImage,
            image: message.attachments[0].thumbnail,
          ),
        );
    }
    return Container(width: 0, height: 0);
  }
}
