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
  final SentryClient sentry;

  bool get isDev => flavorName == AppFlavor.DEVELOPMENT;

  AppConfig({
    @required this.appName,
    @required this.flavorName,
    @required this.apiUrl,
    @required this.wss,
    @required Widget child,
    this.sentry,
  }) : super(child: Material(child: child)) {
    _globalKey = child.key;
    FlutterError.onError = (FlutterErrorDetails details) {
      if (isDev) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        Zone.current.handleUncaughtError(details.exception, details.stack);
      }
    };

    timeago.setLocaleMessages('vi', ViMessages());
  }

  AppConfig copyWith({
    String appName,
    AppFlavor flavorName,
    String apiUrl,
    String wss,
    Widget child,
    SentryClient sentry,
  }) {
    return AppConfig(
      appName: appName ?? this.appName,
      flavorName: flavorName ?? this.flavorName,
      apiUrl: apiUrl ?? this.apiUrl,
      wss: wss ?? this.wss,
      child: child ?? this.child,
      sentry: sentry,
    );
  }

  static AppConfig get instance => _globalKey.currentContext
      .dependOnInheritedWidgetOfExactType(aspect: AppConfig);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

enum AppFlavor { DEVELOPMENT, TEST, PRODUCTION }
