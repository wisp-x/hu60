import 'dart:io';
import 'package:dio/dio.dart';

class Http {
  static Dio dio;
  static Http _instance;

  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static Http getInstance() {
    if (_instance == null) {
      _instance = Http();
    }
    return _instance;
  }

  static request(String url, {data, method}) async {
    dio = Dio(
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

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          return options;
        },
        onResponse: (Response response) async {
          return response;
        },
        onError: (DioError e) async {
          return e;
        },
      ),
    );

    data = data ?? {};
    method = method ?? 'GET';
    Response response = await dio.request(
      url,
      data: data,
      options: new Options(method: method),
    );

    return response;
  }
}
