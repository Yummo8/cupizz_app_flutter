library main_screen;

import 'package:badges/badges.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart' hide Router;

import '../../base/base.dart';
import '../../packages/google_nav_bar/google_nav_bar.dart';
import '../../widgets/index.dart';
import 'components/main_screen.controller.dart';
import 'pages/chat/chat_page.dart';
import 'pages/home/home_page.dart';
import 'pages/post/post_page.dart';
import 'pages/profile/profile_page.dart';

export 'pages/profile/edit_profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends MomentumState<MainScreen>
    with SingleTickerProviderStateMixin {
  static final List<Widget> _tabs = <Widget>[
    HomePage(),
    // FriendPageV2(),
    PostPage(),
    ChatPage(),
    ProfilePage(),
  ];

  TabController _tabController;
  MainScreenController _screenController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _screenController = Momentum.controller<MainScreenController>(context);
      setState(() {
        _tabController = TabController(
          length: _tabs.length,
          vsync: this,
          initialIndex: _screenController.model.currentTabIndex,
        );
      });

      _tabController.addListener(() {
        _screenController.changeTab(_tabController.index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Momentum.controller<CurrentUserController>(context).model.currentUser;
    return PrimaryScaffold(
      body: _tabController == null
          ? const SizedBox.shrink()
          : MomentumBuilder(
              controllers: [MainScreenController],
              builder: (context, snapshot) {
                return ExtendedTabBarView(
                  cacheExtent: _tabs.length,
                  physics: [0, 2].contains(_tabController.index)
                      ? NeverScrollableScrollPhysics()
                      : BouncingScrollPhysics(),
                  controller: _tabController,
                  children: _tabs,
                );
              }),
      bottomNavigationBar: Container(
        decoration:
            BoxDecoration(color: context.colorScheme.background, boxShadow: [
          BoxShadow(
              blurRadius: 20,
              color: context.colorScheme.onBackground.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: MomentumBuilder(
                controllers: [MainScreenController, SystemController],
                builder: (context, snapshot) {
                  final model = snapshot<MainScreenModel>();
                  final systemModel = snapshot<SystemModel>();
                  return GNav(
                      gap: 8,
                      activeColor: context.colorScheme.onBackground,
                      iconSize: 24,
                      color: context.colorScheme.onSurface,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      duration: Duration(milliseconds: 500),
                      tabBackgroundColor: context.colorScheme.background,
                      tabs: <_BottomNavButtonData>[
                        _BottomNavButtonData(
                          'Trang chủ',
                          context.colorScheme.primary,
                          icon: CupertinoIcons.house,
                        ),
                        _BottomNavButtonData(
                          'Confession',
                          context.colorScheme.secondary,
                          icon: CupertinoIcons.square_favorites_alt,
                        ),
                        _BottomNavButtonData(
                          'Tin nhắn',
                          context.colorScheme.primaryVariant,
                          number: systemModel.unreadMessageCount,
                          icon: CupertinoIcons.bubble_left_bubble_right,
                        ),
                        _BottomNavButtonData(
                          currentUser?.displayName?.split(' ')?.first ??
                              'Cá nhân',
                          context.colorScheme.secondaryVariant,
                          number: systemModel.unreadAcceptedFriendCount +
                              systemModel.unreadReceiveFriendCount,
                          icon: CupertinoIcons.person,
                          iconWidget: currentUser == null
                              ? null
                              : UserAvatar.fromChatUser(
                                  user: currentUser,
                                  size: 25,
                                  showOnline: false,
                                ),
                        ),
                      ].mapIndexed((e, i) {
                        final icon = e.iconWidget ??
                            Icon(
                              e.icon,
                              color: model.currentTabIndex == i
                                  ? e.color
                                  : context.colorScheme.onSurface,
                            );
                        return GButton(
                          text: e.text,
                          backgroundColor: e.color.withOpacity(0.2),
                          iconActiveColor: e.color,
                          textColor: e.color,
                          leading: e.number != null && e.number > 0
                              ? Badge(
                                  badgeColor: Colors.red.shade100,
                                  elevation: 0,
                                  position:
                                      BadgePosition.topEnd(top: -12, end: -12),
                                  badgeContent: Text(
                                    e.number.toString(),
                                    style:
                                        TextStyle(color: Colors.red.shade900),
                                  ),
                                  child: icon)
                              : icon,
                        );
                      }).toList(),
                      selectedIndex: model.currentTabIndex,
                      onTabChange: (index) {
                        _tabController.animateTo(index);
                      });
                }),
          ),
        ),
      ),
    );
  }
}

class _BottomNavButtonData {
  final IconData icon;
  final Widget iconWidget;
  final String text;
  final Color color;
  final int number;

  _BottomNavButtonData(this.text, this.color,
      {this.icon, this.iconWidget, this.number});
}
