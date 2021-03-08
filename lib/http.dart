import 'package:dio/dio.dart';
import 'package:hu60/controllers/home_controller.dart';
import 'package:hu60/views/user/login_view.dart';
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
    }
    return url;
  }

  static request(String url, {data, method}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    dio = Dio(
      BaseOptions(
        baseUrl: API_URL,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          // HttpHeaders.userAgentHeader: 'dio',
        },
        followRedirects: false,
        validateStatus: (status) {
          // 302 则表示未登录
          if (status == 302) {
            preferences.remove("sid");
            HomeController controller = GetX.Get.put(HomeController());
            controller.logout();
            GetX.Get.off(() => LoginView(), fullscreenDialog: true);
          }
          return status < 500;
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          String sid = preferences.get("sid");
          if (sid != null) {
            options.baseUrl += "/$sid";
          }
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
