import 'package:get/get.dart';
import 'package:hu60/entities/forum/topic_entity.dart';
import 'package:hu60/http.dart';

class TopicController extends GetxController {
  TopicController({this.id});

  final id; // 帖子ID
  TopicEntity topic;
  bool loading = false; // 是否正在获取

  @override
  void onInit() async {
    super.onInit();
    topic = await getData(id);
  }

  // 获取数据
  Future<TopicEntity> getData(int id) async {
    loading = true;
    var response = await Http.request(
      "/bbs.topic.$id.json?_uinfo=name,avatar",
      method: Http.POST,
    );
    loading = false;
    update();
    return TopicEntity.fromJson(response.data);
  }
}
