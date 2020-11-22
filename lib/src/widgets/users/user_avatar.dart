part of '../index.dart';

class UserAvatar extends StatelessWidget {
  final File image;
  final OnlineStatus onlineStatus;

  const UserAvatar({Key key, this.image, this.onlineStatus}) : super(key: key);

  factory UserAvatar.fromSimpleUser(
      {Key key, @required SimpleUser simpleUser}) {
    return UserAvatar(
      key: key,
      image: simpleUser?.avatar,
      onlineStatus: simpleUser?.onlineStatus,
    );
  }

  factory UserAvatar.fromConversation(
      {Key key, @required Conversation conversation}) {
    return UserAvatar(
      key: key,
      image: (conversation?.images ?? []).isExistAndNotEmpty
          ? conversation.images[0]
          : null,
      onlineStatus: conversation?.onlineStatus,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          width: 50,
          height: 50,
          child: CustomNetworkImage(
            image?.thumbnail ?? '',
            isAvatar: true,
          ),
        ),
        if (onlineStatus == OnlineStatus.online)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 14,
              height: 14,
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
