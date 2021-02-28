import 'package:get/get.dart';
import 'package:hu60/controllers/home_controller.dart';

// 引入你的控制器
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
