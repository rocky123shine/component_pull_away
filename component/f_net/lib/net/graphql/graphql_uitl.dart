import 'package:f_net/net/adapter/net_adapter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ClientBuilder {
  late HttpLink _httpLink;

  ClientBuilder._();

  static ClientBuilder? _clientBuilder;

  static ClientBuilder getInstance() {
    _clientBuilder ??= ClientBuilder._();
    return _clientBuilder!;
  }

  ClientBuilder httpLink(HttpLink httpLink) {
    _httpLink = httpLink;

    return this;
  }

  FGraphQLClient build() {
    return FGraphQLClient(_httpLink, GraphQLCache());
  }
}

class FGraphQLClient extends GraphQLClient {
  FGraphQLClient(Link link, GraphQLCache cache)
      : super(link: link, cache: cache);

  ///gql 格式如下
  ///const String readRepositories = r'''
  ///   query ReadRepositories($nRepositories: Int!) {
  ///     viewer {
  ///       repositories(last: $nRepositories) {
  ///         nodes {
  ///           __typename
  ///           id
  ///           name
  ///           viewerHasStarred
  ///         }
  ///       }
  ///     }
  ///   }
  /// ''';
  ///
  /// FutureOr<void> Function(Map<String, dynamic> data)
  Future<Map<String, dynamic>>? queryData(String gqlStr,
      {Map<String, dynamic> variables = const {},
      Function(Map<String, dynamic> data)? onComplete,
      Function(OperationException? error)? onError}) async {
    var res = await query(QueryOptions(
        document: gql(gqlStr),
        variables: variables,
        onComplete: onComplete,
        onError: onError));
    if (res.hasException) throw res.exception!;
    return Future.value(res.data);
  }

  Future<Map<String, dynamic>>? mutationsData(String gqlStr,
      {Map<String, dynamic> variables = const {},
      Function(Map<String, dynamic>? data)? onComplete,
      Function(OperationException? error)? onError}) async {
    var res = await mutate(MutationOptions(
        document: gql(gqlStr),
        variables: variables,
        onCompleted: onComplete,
        onError: onError));
    if (res.hasException) throw res.exception!;
    return Future.value(res.data);
  }
}
