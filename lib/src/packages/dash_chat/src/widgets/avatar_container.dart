part of dash_chat;

class AvatarContainer extends StatelessWidget {
  final ChatUser user;
  final void Function(ChatUser user) onPress;
  final void Function(ChatUser user) onLongPress;
  final Widget Function(ChatUser user) avatarBuilder;
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
        onTap: () {
          if (onPress != null) {
            onPress(user);
          } else {
            if (user != null && !user.isCurrentUser) {
              Get.toNamed(
                Routes.user,
                arguments: UserScreenParams(user: user),
              );
            }
          }
        },
        onLongPress: () => onLongPress != null ? onLongPress(user) : null,
        child: avatarBuilder != null && user != null
            ? avatarBuilder(user)
            : user != null
                ? UserAvatar.fromChatUser(user: user)
                : UserAvatar(showOnline: false),
      ),
    );
  }
}
