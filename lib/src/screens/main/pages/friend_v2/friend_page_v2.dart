library friend_page;

import 'dart:math';

import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/widgets/index.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'components/friend_page_v2.controller.dart';
part 'components/friend_page_v2.model.dart';

const _PADDING = 20.0;

class FriendPageV2 extends StatefulWidget {
  @override
  _FriendPageV2State createState() => _FriendPageV2State();
}

class _FriendPageV2State extends MomentumState<FriendPageV2>
    with TickerProviderStateMixin, LoadmoreMixin, KeepScrollOffsetMixin {
  final PageController _pageController = PageController();
  static double lastScrollOffset = 0;
  @override
  double get lastOffset => lastScrollOffset;

  @override
  set lastOffset(double value) {
    lastScrollOffset = value;
  }

  AnimationController animationController;
  bool multiple = true;
  Animation<double> topBarAnimation;

  double topBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Momentum.controller<FriendPageV2Controller>(context)
        ..model.update(animationController: animationController);
      _pageController.animateToPage(
          Momentum.controller<FriendPageV2Controller>(context).model.currentTab,
          duration: Duration(seconds: 1),
          curve: Curves.ease);
      animationController.fling();
    });
  }

  @override
  void onLoadMore() {
    Momentum.controller<FriendPageV2Controller>(context).loadmore();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [FriendPageV2Controller],
        builder: (context, snapshot) {
          final model = snapshot<FriendPageV2Model>();
          return PrimaryScaffold(
            appBar: BackAppBar(title: 'Yêu thích', showBackButton: false),
            body: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, _) {
                return [
                  SliverPersistentHeader(
                    floating: true,
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                        expandedHeight: 80,
                        minHeight: 40,
                        selecteds: [
                          model.currentTab == 0,
                          model.currentTab == 1
                        ],
                        onChanged: (int index) {
                          if (index != model.currentTab) {
                            model.update(currentTab: index);
                            _pageController.animateToPage(index,
                                duration: Duration(seconds: 1),
                                curve: Curves.ease);
                          }
                        }),
                  ),
                ];
              },
              body: PageView(
                controller: _pageController,
                onPageChanged: (i) {
                  model.update(currentTab: i);
                },
                children: [
                  model.allFriends,
                  model.receivedFriends,
                ].map(
                  (e) {
                    final friendsList = [
                      ...e.friends ?? [],
                      ...!e.isLastPage
                          ? List.generate(
                              e.friends.length % 2 == 0 ? 2 : 3, (_) => null)
                          : []
                    ];
                    if (!friendsList.isExistAndNotEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              'Những người đã được ghép đôi, đã thích bạn hay bạn đã thích sẽ xuất hiện ở đây.',
                              style: context.textTheme.subtitle1.copyWith(
                                  color: context.colorScheme.onSurface),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 10),
                          OptionButton(
                            title: 'Cập nhật thông tin',
                            onPressed: () {
                              Router.goto(context, EditProfileScreen);
                            },
                          ),
                        ],
                      );
                    }
                    return GridView(
                      padding: const EdgeInsets.all(12),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: friendsList
                          .asMap()
                          .map((index, value) {
                            final count = friendsList.length;
                            final animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn),
                              ),
                            );
                            return MapEntry(
                              index,
                              _Item(
                                animation: animation,
                                animationController: animationController,
                                simpleUser: value?.friend,
                              ),
                            );
                          })
                          .values
                          .toList(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: multiple ? 2 : 1,
                        mainAxisSpacing: _PADDING,
                        crossAxisSpacing: _PADDING,
                        childAspectRatio: 1,
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          );
        });
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key key,
    this.simpleUser,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final SimpleUser simpleUser;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: UserItem(simpleUser: simpleUser),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double minHeight;
  final List<bool> selecteds;
  final Function(int) onChanged;

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  _SliverAppBarDelegate({
    @required this.selecteds,
    @required this.expandedHeight,
    @required this.minHeight,
    this.onChanged,
    this.snapConfiguration,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scrollRate =
        min(1.0, max<double>(0.0, shrinkOffset / (maxExtent - minExtent)));
    final radius = 5 - 5 * scrollRate;

    return Container(
      height: expandedHeight - scrollRate * (expandedHeight - minHeight),
      child: Center(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width - 60 * (1 - scrollRate),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xffFF3422).withOpacity(0.25),
                blurRadius: 5,
                offset: Offset(0, 4),
              )
            ],
            color: context.colorScheme.background,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              'Đã ghép đôi',
              'Đã thích bạn',
            ]
                .asMap()
                .map(
                  (i, e) => MapEntry(
                    i,
                    Expanded(
                      child: InkWell(
                        onTap: () => onChanged(i),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(i == 0 ? radius : 0),
                              right: Radius.circular(i == 1 ? radius : 0),
                            ),
                            color: selecteds[i]
                                ? context.colorScheme.primary
                                : context.colorScheme.onPrimary,
                          ),
                          child: Center(
                            child: Text(
                              e,
                              style: context.textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: selecteds[i]
                                    ? context.colorScheme.onPrimary
                                    : context.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
