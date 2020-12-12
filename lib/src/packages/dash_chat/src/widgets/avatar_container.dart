part of dash_chat;

class AvatarContainer extends StatelessWidget {
  final ChatUser user;
  final Function(SimpleUser user) onPress;
  final Function(SimpleUser user) onLongPress;
  final Widget Function(SimpleUser user) avatarBuilder;
  final Size size;
  final double avatarMaxSize;

  const AvatarContainer({
    Key key,
    @required this.user,
    this.onPress,
    this.onLongPress,
    this.avatarBuilder,
    this.size,
    this.avatarMaxSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? Size.square(40);

    return SizedBox.fromSize(
      size: size,
      child: GestureDetector(
        onTap: () => onPress != null ? onPress(user) : null,
        onLongPress: () => onLongPress != null ? onLongPress(user) : null,
        child: avatarBuilder != null && user != null
            ? avatarBuilder(user)
            : UserAvatar.fromChatUser(user: user),
      ),
    );
  }
}
