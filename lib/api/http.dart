import 'dart:io';
import 'package:dio/dio.dart';

class Http {
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://hu60.cn/q.php/",
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
//      'common-header': 'xx',
      },
    ),
  );

  static request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';
    Response response = await dio.request(url, data: data, options: new Options(method: method));

    return response;
  }
}
