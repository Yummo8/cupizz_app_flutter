part of 'index.dart';

class GraphqlService extends MomentumService {
  GraphQLClient _client;
  GraphQLClient get client => _client;
  final String apiUrl;

  GraphqlService(this.apiUrl) {
    reset();
  }

  void reset() {
    final HttpLink httpLink = HttpLink(
      uri: apiUrl,
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => await getService<StorageService>().getToken,
    );

    final Link link = authLink.concat(httpLink);

    _client = GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    );
  }

  Future<QueryResult> query(QueryOptions options) =>
      _processQueryResult(_client.query(options));
  Future<QueryResult> mutate(MutationOptions options) =>
      _processQueryResult(_client.mutate(options));
  Stream<FetchResult> subscribe(Operation operation) =>
      _processFetchResult(_client.subscribe(operation));

  Future<QueryResult> _processQueryResult(Future<QueryResult> future) async {
    final result = await future;
    if (result.hasException) {
      if (result.exception.clientException != null &&
          result.exception.clientException.message.isExistAndNotEmpty) {
        debugPrint(result.exception.clientException.message);
        throw result.exception.clientException.message;
      } else if (result.exception.graphqlErrors != null &&
          result.exception.graphqlErrors.isNotEmpty) {
        final unauthenticatedError = result.exception.graphqlErrors.firstWhere(
            (element) => element.extensions['code'] == 'UNAUTHENTICATED',
            orElse: () => null);
        final clientError = result.exception.graphqlErrors.firstWhere(
            (element) => element.extensions['code'] == 'CLIENT_ERROR',
            orElse: () => null);
        if (unauthenticatedError != null) {
          await getService<AuthService>().logout();
          throw 'UNAUTHENTICATED';
        } else if (clientError != null) {
          throw clientError.message;
        } else {
          inspect(result.exception);
          throw 'Lỗi server: ${result.exception.graphqlErrors[0].message}';
        }
      } else {
        debugPrint(result.exception.toString());
        throw 'Lỗi không xác định';
      }
    }

    return result;
  }

  Stream<FetchResult> _processFetchResult(Stream<FetchResult> stream) async* {
    await for (final result in stream) {
      // TODO handle realtime exception
      yield result;
    }
  }
}
