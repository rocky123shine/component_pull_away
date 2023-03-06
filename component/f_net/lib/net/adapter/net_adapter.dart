import 'dart:convert';

import 'package:f_net/net/base_request.dart';

abstract class NetAdapter {
  //此时 是具体的网络请求
  // 返回响应体
  Future<NetResponse<T>> send<T>(BaseRequest request);
}

class NetResponse<T> {
  T? data;
  int code;
  String? msg;

  NetResponse({this.data, required this.code, this.msg});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return super.toString();
  }
}
