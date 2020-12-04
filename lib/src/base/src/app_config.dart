part of base;

class AppConfig extends InheritedWidget {
  final String appName;
  final AppFlavor flavorName;
  final String apiUrl;
  final String wss;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey _globalKey;
  static GlobalKey get globalKey => _globalKey;

  bool get isDev => flavorName == AppFlavor.DEVELOPMENT;

  AppConfig({
    @required this.appName,
    @required this.flavorName,
    @required this.apiUrl,
    @required this.wss,
    @required Widget child,
  }) : super(child: Material(child: child)) {
    _globalKey = child.key;

    timeago.setLocaleMessages('vi', ViMessages());
  }

  AppConfig copyWith({
    String appName,
    AppFlavor flavorName,
    String apiUrl,
    String wss,
    Widget child,
  }) {
    return AppConfig(
      appName: appName ?? this.appName,
      flavorName: flavorName ?? this.flavorName,
      apiUrl: apiUrl ?? this.apiUrl,
      wss: wss ?? this.wss,
      child: child ?? this.child,
    );
  }

  static AppConfig get instance => _globalKey.currentContext
      .dependOnInheritedWidgetOfExactType(aspect: AppConfig);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

enum AppFlavor { DEVELOPMENT, TEST, PRODUCTION }
