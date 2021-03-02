import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/forum/topic_controller.dart';

class TopicView extends StatelessWidget {
  TopicView({@required this.id});
  final id;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicController>(
      init: TopicController(id: id),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text("主题详情"),
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Text("hh"),
      ),
    );
  }
}
