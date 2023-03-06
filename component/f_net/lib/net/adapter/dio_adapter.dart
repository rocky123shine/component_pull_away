import 'package:dio/dio.dart';
import 'package:f_net/net/adapter/net_adapter.dart';
import 'package:f_net/net/base_request.dart';
import 'package:f_net/net/net_error.dart';

class DioAdapter extends NetAdapter {
  @override
  Future<NetResponse<T>> send<T>(BaseRequest request) async {
    var response;
    var options = Options(headers: request.headers);
    var error;
    try {
      if (request.method == HttpMethod.get) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.method == HttpMethod.post) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.method == HttpMethod.delete) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      throw NetError(response?.statusCode ?? -1, error.toString(),
          data: await buildResponse(response, request));
    }
    return await buildResponse(response, request);
  }

  Future<NetResponse<T>> buildResponse<T>(
      Response? response, BaseRequest request) {
    return Future.value(NetResponse(
        data: response?.data,
        code: response?.statusCode ?? -1,
        msg: response?.statusMessage));
  }
}
