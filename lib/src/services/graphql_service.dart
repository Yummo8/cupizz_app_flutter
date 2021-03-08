import 'package:collection/collection.dart' show IterableExtension;
import 'package:cupizz_app/src/base/base.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService extends GetxService {
  GraphQLClient? _client;
  GraphQLClient? get client => _client;
  WebSocketLink? _socketLink;
  final String apiUrl;
  final String wss;

  GraphqlService({required this.apiUrl, required this.wss}) {
    reset();
  }

  void reset() {
    _socketLink?.dispose();

    final httpLink = HttpLink(apiUrl);

    final authLink = AuthLink(
      getToken: () async => (await Get.find<StorageService>().getToken) ?? '',
    );

    _socketLink = WebSocketLink(
      wss,
      config: SocketClientConfig(
        autoReconnect: true,
        initialPayload: () async {
          return {
            'Authorization': await Get.find<StorageService>().getToken,
          };
        },
      ),
    );

    final link = authLink.concat(httpLink).concat(_socketLink!);

    _client = GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link,
    );
  }

  Future<QueryResult> query(QueryOptions options) =>
      _processQueryResult(_client!.query(options));
  Future<QueryResult> mutate(MutationOptions options) =>
      _processQueryResult(_client!.mutate(options));
  Stream<QueryResult> subscribe(SubscriptionOptions operation) =>
      _processFetchResult(_client!.subscribe(operation));

  Future<QueryResult> _processQueryResult(Future<QueryResult> future) async {
    final result = await future;
    debugPrint(result.data?.keys.toString());
    if (result.hasException) {
      if (result.exception!.linkException != null) {
        debugPrint(result.exception!.linkException.toString());
        throw result.exception!.linkException!;
      } else if (result.exception!.graphqlErrors.isNotEmpty) {
        final unauthenticatedError = result.exception!.graphqlErrors
            .firstWhereOrNull(
                (element) => element.extensions!['code'] == 'UNAUTHENTICATED');
        final clientError = result.exception!.graphqlErrors.firstWhereOrNull(
            (element) => element.extensions!['code'] == 'CLIENT_ERROR');
        if (unauthenticatedError != null) {
          await _LogoutHandler.logout();
          throw 'Vui lòng đăng nhập lại!';
        } else if (clientError != null) {
          throw clientError.message;
        } else {
          // unawaited(AppConfig.instance.sentry?.captureException(
          //   result.exception.graphqlErrors[0].message,
          //   stackTrace: result.exception,
          // ));
          debugPrint(result.exception!.graphqlErrors[0].message.toString());
          throw 'Xảy ra lỗi!\nVui lòng liên hệ NPH để được hỗ trợ!';
        }
      } else {
        debugPrint(result.exception.toString());
        throw 'Xảy ra lỗi khi tải dữ liệu:\n${result.exception.toString()}';
      }
    }

    return result;
  }

  Stream<QueryResult> _processFetchResult(Stream<QueryResult> stream) async* {
    await for (final result in stream) {
      yield result;
    }
  }
}

class _LogoutHandler {
  static bool _isLoggingOut = false;

  static Future logout() async {
    if (!_isLoggingOut) {
      _isLoggingOut = true;
      if (AppConfig.navigatorKey.currentContext != null) {
        final controller = Momentum.controller<AuthController>(
            AppConfig.navigatorKey.currentContext!);
        if (await controller.isAuthenticated) {
          await trycatch(controller.logout);
        }
      }
      _isLoggingOut = false;
    }
  }
}
