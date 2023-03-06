import 'package:f_net/net/adapter/net_adapter.dart';
import 'package:f_net/net/base_request.dart';

///测试适配器，mock数据
class MockAdapter extends NetAdapter {
  @override
  Future<NetResponse<T>> send<T>(BaseRequest request) async {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return NetResponse(
          msg: "ok", data: {"code": 0, "message": 'success'} as T, code: 200);
    });
  }
}
