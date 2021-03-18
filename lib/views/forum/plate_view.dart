import 'dart:collection';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/forum/plate_entity.dart';
import 'package:hu60/http.dart';
import 'dart:ui' as ui;

import 'package:hu60/utils/utils.dart';

class PlateView extends StatefulWidget {
  @override
  _PlateView createState() => _PlateView();
}

class _PlateView extends State<PlateView> {
  bool _loading = false;
  List<Forums> _plates = [];
  List<Widget> _widgets = [];

  @override
  void initState() {
    super.initState();
    _getPlates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("选择板块"),
        centerTitle: true,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _loading
          ? Utils.loading(context)
          : Container(
              margin: EdgeInsets.all(15),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return _widgets[index];
                },
                itemCount: _widgets.length,
              ),
            ),
    );
  }

  void _getPlates() async {
    setState(() {
      _loading = true;
    });
    dio.Response response = await Http.request("/bbs.newtopic.0.json");
    PlateEntity entity = PlateEntity.fromJson(response.data);
    setState(() {
      _plates = entity.forums;
    });
    _makeTree(_plates, null, 0);
    setState(() {
      _loading = false;
    });
  }

  void _makeTree(List plates, parent, int layer) {
    plates.forEach((element) {
      if (element is LinkedHashMap<String, dynamic>) {
        element = Child.fromJson(element);
      }

      setState(() {
        Widget widget = Text.rich(
          TextSpan(
            children: <InlineSpan>[
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: element is Forums ? 0 : layer.toDouble() * 20,
                  ),
                  child: Text(element is Forums ? "" : "└─ "),
                ),
              ),
              WidgetSpan(
                alignment: ui.PlaceholderAlignment.middle,
                child: Container(
                  margin: EdgeInsets.only(bottom: 6),
                  padding: EdgeInsets.only(
                    left: 15,
                    top: 6,
                    right: 15,
                    bottom: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        element.notopic == 1 ? Colors.grey : Color(0xd2158fc4),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    element.name,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(38),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

        _widgets.add(
          GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[widget],
            ),
            onTap: () {
              if (element.notopic == 0) {
                Get.back(result: {"id": element.id, "name": element.name});
              }
            },
          ),
        );
      });
      if (element.child.length > 0) {
        return _makeTree(element.child, parent, layer + 1);
      }
    });
  }
}
