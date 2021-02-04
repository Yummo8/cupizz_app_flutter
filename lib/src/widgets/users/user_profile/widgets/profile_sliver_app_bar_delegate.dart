part of '../user_profile.dart';

class _ProfileSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  static const _AVATAR_MAX_SIZE = 100.0;
  static const _AVATAR_MIN_SIZE = 50.0;
  static const _HEADER_MIN_HEIGHT = 100.0;
  final double expandedHeight;
  final PreferredSizeWidget bottom;
  final ChatUser user;
  final bool showBackButton;

  bool get isCurrentUser => user.isCurrentUser;

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  _ProfileSliverAppBarDelegate(
    this.user, {
    @required this.expandedHeight,
    this.bottom,
    this.snapConfiguration,
    this.showBackButton = false,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scrollRate =
        min(1.0, max<double>(0.0, shrinkOffset / (maxExtent - minExtent)));
    final opacity = 0.3 - 0.3 * scrollRate;

    return Container(
      height: expandedHeight,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          _buildCover(context, scrollRate),
          ClipPath(
            clipper: PinkOneClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withOpacity(opacity),
              ),
            ),
          ),
          ClipPath(
            clipper: PinkTwoClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withOpacity(opacity),
              ),
            ),
          ),
          if (showBackButton) _buildBackButton(context, scrollRate),
          _buildAvatar(context, scrollRate),
          _buildUpdateCoverButton(context, scrollRate),
          _buildSettingOrMessageButton(context, scrollRate),
        ],
      ),
    );
  }

  Widget _buildCover(BuildContext context, double scrollRate) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0 - 30 * scrollRate,
      child: ClipPath(
        clipper: BackgroudClipper(),
        child: Stack(
          children: [
            Positioned.fill(
                child: user?.cover?.url != null
                    ? CustomNetworkImage(user.cover.url)
                    : Container(
                        color: context.colorScheme.surface,
                      )),
            Container(
              width: context.width,
              height: expandedHeight,
              color:
                  context.colorScheme.primary.withOpacity(0 + 0.3 * scrollRate),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, double scrollRate) {
    final size =
        _AVATAR_MAX_SIZE - (_AVATAR_MAX_SIZE - _AVATAR_MIN_SIZE) * scrollRate;
    return Positioned(
      bottom: 0,
      left: context.width / 12 - (context.width / 12 - 20) * scrollRate,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          border: Border.all(
            color: context.colorScheme.background,
            width: 5,
          ),
          color: context.colorScheme.background,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
            border: Border.all(color: context.colorScheme.primary),
          ),
          child: MomentumBuilder(
              controllers: [CurrentUserController],
              builder: (context, snapshot) {
                final model = snapshot<CurrentUserModel>();
                return CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Menu(
                    [
                      ViewImageMenuItem(context, [user.avatar]),
                      if (!model.isUpdatingAvatar && isCurrentUser)
                        ...getPickImagesMenuItem(
                          context,
                          (images) {
                            if (images.isExistAndNotEmpty) {
                              Momentum.controller<CurrentUserController>(
                                      context)
                                  .updateAvatar(images[0]);
                            }
                          },
                          maxSelected: 1,
                          cropAspectRatio: const CropAspectRatio(
                            ratioX: 1,
                            ratioY: 1,
                          ),
                        )
                    ],
                    showCancel: true,
                  ).show(context),
                  child: model.isUpdatingAvatar && isCurrentUser
                      ? Align(child: LoadingIndicator(size: size * 0.5))
                      : UserAvatar.fromChatUser(
                          user: user,
                          size: size,
                          showOnline: false,
                        ),
                );
              }),
        ),
      ),
    );
  }

  Widget _buildUpdateCoverButton(BuildContext context, double scrollRate) {
    final topPosition = 10 + MediaQuery.of(context).padding.top;
    return Positioned(
      right: 10,
      top: topPosition * (1 - scrollRate),
      child: Transform.scale(
        scale: 1 - scrollRate,
        child: MomentumBuilder(
            controllers: [CurrentUserController],
            builder: (context, snapshot) {
              final model = snapshot<CurrentUserModel>();
              return OpacityIconButton(
                icon: !model.isUpdatingCover ? Icons.camera : null,
                iconWidget: model.isUpdatingCover
                    ? LoadingIndicator(
                        color: context.colorScheme.onPrimary,
                        size: 22,
                      )
                    : null,
                onPressed: () {
                  Menu(
                    [
                      ViewImageMenuItem(context, [user.cover]),
                      if (!model.isUpdatingAvatar && isCurrentUser)
                        ...getPickImagesMenuItem(context, (images) {
                          if (images.isExistAndNotEmpty) {
                            model.controller.updateCover(images[0]);
                          }
                        },
                            maxSelected: 1,
                            cropAspectRatio:
                                CropAspectRatio(ratioX: 3, ratioY: 5))
                    ],
                    showCancel: true,
                  ).show(context);
                },
              );
            }),
      ),
    );
  }

  Widget _buildSettingOrMessageButton(BuildContext context, double scrollRate) {
    IconData icon;
    Function onPressed;
    if (user.friendType == FriendType.me) {
      icon = Icons.settings;
      onPressed = () {
        Router.goto(context, UserSettingScreen);
      };
    } else if (user.friendType == FriendType.friend) {
      icon = Icons.message_outlined;
      onPressed = () {
        Router.goto(
          context,
          MessagesScreen,
          params: MessagesScreenParams(ConversationKey(targetUserId: user.id)),
        );
      };
    } else if (user.friendType == FriendType.received) {
      icon = Icons.done;
      onPressed = () {
        Momentum.controller<UserScreenController>(context).addFriend();
      };
    }

    return Positioned(
      right: 10,
      bottom: 10 - 30 * scrollRate,
      child: Transform.scale(
        scale: 1,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: context.colorScheme.background,
            shape: CircleBorder(),
          ),
          child: Icon(icon, size: 18),
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context, double scrollRate) {
    return Positioned(
      left: 10,
      top: 10 + MediaQuery.of(context).padding.top,
      child: Opacity(
        opacity: 1 - scrollRate,
        child: InkWell(
          child: Icon(
            Icons.chevron_left,
            color: context.colorScheme.onPrimary,
            size: 40,
          ),
          onTap: () {
            Router.pop(context);
          },
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + (bottom?.preferredSize?.height ?? 0);

  @override
  double get minExtent =>
      _HEADER_MIN_HEIGHT + (bottom?.preferredSize?.height ?? 0);

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
