part of '../profile_screen.dart';

class ProfileSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  static const _AVATAR_MAX_SIZE = 100.0;
  static const _AVATAR_MIN_SIZE = 50.0;
  static const _HEADER_MIN_HEIGHT = 100.0;
  final double expandedHeight;
  final PreferredSizeWidget bottom;
  final SimpleUser user;

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  ProfileSliverAppBarDelegate(
    this.user, {
    @required this.expandedHeight,
    this.bottom,
    this.snapConfiguration,
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
        overflow: Overflow.visible,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0 - 30 * scrollRate,
            child: ClipPath(
              clipper: BackgroudClipper(),
              child: Stack(
                children: [
                  Positioned.fill(
                      child: CustomNetworkImage(user?.cover?.url ?? '')),
                  Container(
                    width: context.width,
                    height: expandedHeight,
                    color: context.colorScheme.primary
                        .withOpacity(0 + 0.3 * scrollRate),
                  )
                ],
              ),
            ),
          ),
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
          Positioned(
            bottom: 0,
            left: context.width / 12 - (context.width / 12 - 20) * scrollRate,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(90.0)),
                border: Border.all(
                  color: context.colorScheme.background,
                  width: 5,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  border: Border.all(color: context.colorScheme.primary),
                ),
                child: UserAvatar.fromSimpleUser(
                  simpleUser: user,
                  size: _AVATAR_MAX_SIZE -
                      (_AVATAR_MAX_SIZE - _AVATAR_MIN_SIZE) * scrollRate,
                  showOnline: false,
                ),
              ),
            ),
          ),
        ],
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
