import 'package:f_net/net/adapter/net_adapter.dart';
import 'package:f_net/net/f_net.dart';

/// 请求方式
enum HttpMethod { post, get, delete, update }

class RequestBuilder {
  //默认 GET 请求
  var method = HttpMethod.get;
  var _baseUrl = "www.baidu.com";
  var path = "";
  var needLogin = false;
  var pathParams;
  bool _isHttps = true;

  RequestBuilder(
      {required this.method,
      required this.path,
      this.needLogin = false,
      this.pathParams});

  final _headers = <String, String>{};
  final _params = <String, String>{};

  RequestBuilder baseUrl(String baseUrl) {
    if (baseUrl.contains("//")) {
      baseUrl = baseUrl.substring(baseUrl.indexOf("//") + 2);
    }
    if (baseUrl.endsWith("/")) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }
    print("baseUrl=$baseUrl");
    _baseUrl = baseUrl;
    return this;
  }

  RequestBuilder addHeaders(Map<String, String> headers) {
    _headers.addAll(headers);
    return this;
  }

  RequestBuilder addHeader(String key, String value) {
    _headers[key] = value;
    return this;
  }

  RequestBuilder param(String key, String value) {
    _params[key] = value;
    return this;
  }

  RequestBuilder params(Map<String, String> params) {
    _params.addAll(params);
    return this;
  }

  RequestBuilder isHttps(bool isHttps) {
    _isHttps = isHttps;
    return this;
  }

  BaseRequest build() => BaseRequest(this);
}

///请求抽象
class BaseRequest {
  late FNet? fNet;

  //默认 GET 请求
  var method = HttpMethod.get;
  var pathParams;

//是否是HTTPS
  bool isHttps = true;

  var baseUrl = "";
  var path = "";

  //https://api.github.com/graphql
  var graphQlService = "";

  var headers = <String, String>{};
  var params = <String, String>{};

  BaseRequest(RequestBuilder builder) {
    method = builder.method;
    path = builder.path;
    pathParams = builder.pathParams;
    baseUrl = builder._baseUrl;
    headers = builder._headers;
    params = builder._params;
    isHttps = builder._isHttps;
  }

  String url() {
    //在这里拼接url
    Uri uri;
    var pathStr = path;

    //参数处理
    if (pathParams != null) {
      if (path.endsWith("/")) {
        pathStr = "$path$pathParams";
      } else {
        pathStr = "$path/$pathParams";
      }
    }
    var param;
    if (params.isNotEmpty && method == HttpMethod.get) {
      param = params;
    }

    if (isHttps) {
      uri = Uri.https(baseUrl, pathStr, param);
    } else {
      uri = Uri.http(baseUrl, pathStr, param);
    }

    return uri.toString();
  }

  Future send<T>() async {
    if (fNet == null) {
      throw Exception("please init request Argument!!!!!");
    }
    return await fNet!.send<T>();
  }

  BaseRequest adapter(NetAdapter adapter) {
    fNet!.adapter = adapter;
    return this;
  }
}
