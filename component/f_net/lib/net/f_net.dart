import 'package:f_net/net/adapter/dio_adapter.dart';
import 'package:f_net/net/adapter/net_adapter.dart';
import 'package:f_net/net/base_request.dart';

import 'net_error.dart';

/// 单例模式
class FNet {
  //私有化构造
  FNet._();

  // 暴露属性
  static FNet? _instance;

  static FNet getInstance() {
    _instance ??= FNet._();
    return _instance!;
  }

  late BaseRequest _request;
  NetAdapter _adapter = DioAdapter();

  set adapter(NetAdapter adapter) {
    _adapter = adapter;
  }

  /// 在这里初始化request
  BaseRequest initRequest(BaseRequest request) {
    _request = request;
    _request.fNet = _instance;
    return _request;
  }

  ///  发送请求
  ///  需要具体的请求
  ///  创建 并传递具体的请求过来
  Future send<T>() async {
    // 拿到具体的request 之后 需要具体的框架取发起请求
    //这里是使用 adapter模式 适配不同框架 实现插拔
    _adapter ??= DioAdapter();

    NetResponse? response;
    var error;
    try {
      response = await _adapter.send<T>(_request);
    } on NetError catch (e) {
      error = e;
      response = e.data;
      print(e.message);
    } catch (e) {
      //其它异常
      error = e;
      print(e);
    }
    if (response == null) {
      print(error);
    }
    var result = response?.data;
    var status = response?.code;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw NetError(status ?? -1, result.toString(), data: result);
    }
  }
}
