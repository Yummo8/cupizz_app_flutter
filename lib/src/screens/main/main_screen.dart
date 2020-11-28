library main_screen;

import 'package:cupizz_app/src/screens/main/pages/friend/friend_page.dart';
import 'package:cupizz_app/src/screens/main/pages/profile/profile_screen.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../base/base.dart';
import '../../widgets/index.dart';
import 'components/main_screen.controller.dart';
import 'pages/chat/chat_page.dart';
import 'pages/home/home_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends MomentumState<MainScreen>
    with SingleTickerProviderStateMixin {
  static final List<Widget> _tabs = <Widget>[
    HomePage(),
    FriendPage(),
    ChatPage(),
    ProfileScreen(),
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
    return PrimaryScaffold(
      body: _tabController == null
          ? const SizedBox.shrink()
          : MomentumBuilder(
              controllers: [MainScreenController],
              builder: (context, snapshot) {
                return ExtendedTabBarView(
                  cacheExtent: 4,
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
                controllers: [MainScreenController],
                builder: (context, snapshot) {
                  final model = snapshot<MainScreenModel>();
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
                        _BottomNavButtonData(Icons.home_outlined, 'Trang chủ',
                            context.colorScheme.primary),
                        _BottomNavButtonData(Icons.favorite_outline_sharp,
                            'Yêu thích', context.colorScheme.secondary),
                        _BottomNavButtonData(Icons.chat_bubble_outline_rounded,
                            'Tin nhắn', context.colorScheme.primaryVariant),
                        _BottomNavButtonData(Icons.person_outline_rounded,
                            'Cá nhân', context.colorScheme.secondaryVariant),
                      ]
                          .map((e) => GButton(
                                icon: e.icon,
                                text: e.text,
                                backgroundColor: e.color.withOpacity(0.2),
                                iconActiveColor: e.color,
                                textColor: e.color,
                              ))
                          .toList(),
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
  final String text;
  final Color color;

  _BottomNavButtonData(this.icon, this.text, this.color);
}
