import 'package:cupizz_app/src/base/base.dart';

class UserAvatar extends StatelessWidget {
  final FileModel image;
  final OnlineStatus onlineStatus;
  final double size;
  final bool showOnline;

  const UserAvatar({
    Key key,
    this.image,
    this.onlineStatus,
    this.size = 50.0,
    this.showOnline = true,
  }) : super(key: key);

  factory UserAvatar.fromChatUser({
    Key key,
    @required ChatUser user,
    double size = 50,
    bool showOnline = true,
  }) {
    return UserAvatar(
      key: key,
      image: user?.avatar,
      onlineStatus: user?.onlineStatus,
      size: size,
      showOnline: showOnline,
    );
  }

  factory UserAvatar.fromConversation(
      {Key key,
      @required Conversation conversation,
      double size = 50,
      bool showOnline = true}) {
    return UserAvatar(
      key: key,
      image: (conversation?.images ?? []).isExistAndNotEmpty
          ? conversation.images[0]
          : null,
      onlineStatus: conversation?.onlineStatus,
      size: size,
      showOnline: showOnline,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          width: size,
          height: size,
          child: CustomNetworkImage(
            image?.thumbnail ?? image?.url ?? '',
            isAvatar: true,
          ),
        ),
        if (showOnline && onlineStatus == OnlineStatus.online)
          Positioned(
            bottom: size * 0.05,
            right: size * 0.05,
            child: Container(
              width: 14 * size / 50,
              height: 14 * size / 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colorScheme.background,
                  width: 2,
                ),
                color: Color(onlineStatus == OnlineStatus.online
                    ? 0xff20FF6C
                    : 0xff7D7D7D),
              ),
            ),
          )
      ],
    );
  }
}
