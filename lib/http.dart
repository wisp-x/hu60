import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' as GetX;

class Http {
  static Dio dio;
  static Http _instance;

  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static const String API_URL = 'https://hu60.cn/q.php';

  static Http getInstance() {
    if (_instance == null) {
      _instance = Http();
    }
    return _instance;
  }

  static getBaseUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String sid = preferences.get("sid");
    String url = API_URL;
    if (sid != null) {
      url += "/$sid";
    } else {
      GetX.Get.put(UserController()).logout();
    }
    return url;
  }

  static request(String url, {data, method}) async {
    dio = Dio(
      BaseOptions(
        baseUrl: await getBaseUrl(),
        connectTimeout: 5000,
        receiveTimeout: 5000,
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          // HttpHeaders.userAgentHeader: 'dio',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
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
      options: Options(method: method),
    );

    // 格式化不规范的json
    if (response.data.runtimeType.toString() == "String") {
      response.data = json.decode(response.data);
    }

    return response;
  }
}
