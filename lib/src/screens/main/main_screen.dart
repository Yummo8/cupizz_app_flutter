import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../base/base.dart';
import '../../widgets/index.dart';
import 'pages/chat/chat_page.dart';
import 'pages/home/home_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _tabs = <Widget>[
    HomePage(),
    Text(
      'Index 1: Likes',
      style: optionStyle,
    ),
    ChatPage(),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: ExtendedTabBarView(
        cacheExtent: 4,
        physics: [0, 2].contains(_tabController.index)
            ? NeverScrollableScrollPhysics()
            : BouncingScrollPhysics(),
        controller: _tabController,
        children: _tabs,
      ),
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
            child: GNav(
                gap: 8,
                activeColor: context.colorScheme.onBackground,
                iconSize: 24,
                color: context.colorScheme.onSurface,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 500),
                tabBackgroundColor: context.colorScheme.background,
                tabs: <_BottomNavButtonData>[
                  _BottomNavButtonData(Icons.home_outlined, 'Trang chủ',
                      context.colorScheme.primary),
                  _BottomNavButtonData(Icons.favorite_outline_sharp,
                      'Yêu thích', context.colorScheme.secondary),
                  _BottomNavButtonData(Icons.chat_bubble_outline_rounded,
                      'Tin nhắn', context.colorScheme.primaryVariant),
                  _BottomNavButtonData(Icons.person_outline_rounded, 'Cá nhân',
                      context.colorScheme.secondaryVariant),
                ]
                    .map((e) => GButton(
                          icon: e.icon,
                          text: e.text,
                          backgroundColor: e.color.withOpacity(0.2),
                          iconActiveColor: e.color,
                          textColor: e.color,
                        ))
                    .toList(),
                selectedIndex: _tabController.index,
                onTabChange: (index) {
                  _tabController.animateTo(index);
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
