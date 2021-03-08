part of base;

class AppConfig extends InheritedWidget {
  static late AppConfig _instance;

  final String appName;
  final AppFlavor flavorName;
  final String apiUrl;
  final String wss;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  // final SentryClient sentry;

  bool get isDev => flavorName == AppFlavor.DEVELOPMENT;

  factory AppConfig({
    required String appName,
    required AppFlavor flavorName,
    required String apiUrl,
    required String wss,
    required Widget child,
    // required SentryClient sentry,
  }) =>
      _instance = AppConfig._(
        apiUrl: apiUrl,
        appName: appName,
        flavorName: flavorName,
        wss: wss,
        // sentry: sentry,
        child: child,
      );

  AppConfig._({
    required this.appName,
    required this.flavorName,
    required this.apiUrl,
    required this.wss,
    required Widget child,
    // this.sentry,
  }) : super(child: Material(child: child)) {
    // FlutterError.onError = (FlutterErrorDetails details) {
    //   if (isDev || kIsWeb) {
    //     FlutterError.dumpErrorToConsole(details);
    //   } else {
    //     Zone.current.handleUncaughtError(details.exception, details.stack);
    //   }
    // };
    timeago.setLocaleMessages('vi', ViMessages());
  }

  AppConfig copyWith({
    String? appName,
    AppFlavor? flavorName,
    String? apiUrl,
    String? wss,
    Widget? child,
    // SentryClient? sentry,
  }) {
    _instance = AppConfig(
      appName: appName ?? this.appName,
      flavorName: flavorName ?? this.flavorName,
      apiUrl: apiUrl ?? this.apiUrl,
      wss: wss ?? this.wss,
      // sentry: sentry,
      child: child ?? this.child,
    );
    return _instance;
  }

  static AppConfig get instance => _instance;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

enum AppFlavor { DEVELOPMENT, TEST, PRODUCTION }
