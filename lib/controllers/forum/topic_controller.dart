import 'package:get/get.dart';

class TopicController extends GetxController with SingleGetTickerProviderMixin {
  TopicController({this.id});

  final id; // 帖子ID

  @override
  void onInit() {
    super.onInit();
  }
}