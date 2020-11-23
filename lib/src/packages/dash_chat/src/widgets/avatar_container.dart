part of dash_chat;

class AvatarContainer extends StatelessWidget {
  final SimpleUser user;
  final Function(SimpleUser user) onPress;
  final Function(SimpleUser user) onLongPress;
  final Widget Function(SimpleUser user) avatarBuilder;
  final Size size;
  final double avatarMaxSize;

  const AvatarContainer({
    @required this.user,
    this.onPress,
    this.onLongPress,
    this.avatarBuilder,
    this.size,
    this.avatarMaxSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? Size.square(40);

    return SizedBox.fromSize(
      size: size,
      child: GestureDetector(
        onTap: () => onPress != null ? onPress(user) : null,
        onLongPress: () => onLongPress != null ? onLongPress(user) : null,
        child: avatarBuilder != null
            ? avatarBuilder(user)
            : SizedBox(child: UserAvatar.fromSimpleUser(simpleUser: user)),
      ),
    );
  }
}
