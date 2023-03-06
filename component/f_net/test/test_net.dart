import 'package:f_net/net/adapter/dio_adapter.dart';
import 'package:f_net/net/adapter/grapgql_adapter.dart';
import 'package:f_net/net/base_request.dart';
import 'package:f_net/net/f_net.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:f_net/net/graphql/operations/queries/read_repositories.dart'
    as queries;

void main() {
  test("description", () => testNet());
}

testNet() async {
  var res = await FNet.getInstance()
      .initRequest(RequestBuilder(method: HttpMethod.get, path: "banner/json")
          // RequestBuilder(method: HttpMethod.get, path: "graphql/noauth/")
          //.baseUrl("stage.api.riselinkedu.com")
          .baseUrl("www.wanandroid.com")
          .addHeader("key", "value")
          .param("key", "value")
          .isHttps(false)
          .build())
      .adapter(DioAdapter())
      //.adapter(GraphQlAdapter(queries.riseUrlConfig))
      .send();

  print("😁😁😁😁😁😁😁😁😁😁😁😁😁==》结果 ${res.toString()}");
}
