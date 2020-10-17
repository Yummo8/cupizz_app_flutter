part of base;

class AppConfig extends InheritedWidget {
  final String appName;
  final AppFlavor flavorName;
  final String apiUrl;
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  static GlobalKey _globalKey;
  static GlobalKey get globalKey => _globalKey;

  AppConfig({
    @required this.appName,
    @required this.flavorName,
    @required this.apiUrl,
    @required Widget child,
  }) : super(child: Material(child: child)) {
    _globalKey = child.key;
  }

  static AppConfig get instance => _globalKey.currentContext
      .dependOnInheritedWidgetOfExactType(aspect: AppConfig);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

enum AppFlavor { DEVELOPMENT, TEST, PRODUCTION }
