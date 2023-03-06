import 'package:f_net/net/adapter/net_adapter.dart';
import 'package:f_net/net/base_request.dart';
import 'package:f_net/net/graphql/graphql_uitl.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlAdapter extends NetAdapter {
  Function(Map<String, dynamic>? data)? onComplete;
  Function(OperationException? error)? onError;
  String gqlStr;
  Map<String, dynamic>? variables;

  GraphQlAdapter(this.gqlStr,
      {this.variables = const {}, this.onComplete, this.onError});

  @override
  Future<NetResponse<T>> send<T>(BaseRequest request) async {
    var client = ClientBuilder.getInstance()
        .httpLink(HttpLink(
          request.url(),
          defaultHeaders: request.headers,
        ))
        .build();
    var res;
    if (request.method == HttpMethod.get) {
      res = await client.queryData(gqlStr,
          onError: onError,
          onComplete: onComplete,
          variables: variables ??= const {});
    } else {
      res = await client.mutationsData(gqlStr,
          onError: onError,
          onComplete: onComplete,
          variables: variables ??= const {});
    }
    print("---------$res");
    return Future.value(NetResponse(code: 200, msg: "ok", data: res));
  }
}
