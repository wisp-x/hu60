import 'package:get/get.dart';
import 'package:hu60/controllers/forum/topics_controller.dart';

class TopicsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopicsController>(() => TopicsController());
  }
}
