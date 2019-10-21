import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  Detail(this.id);

  int id;

  _DetailState createState() => _DetailState(id);
}

class _DetailState extends State<Detail> {
  int id;

  _DetailState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('帖子详情'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: _buildBottomSheet,
              );
            },
          ),
        ],
      ),
      body: Text("${id}"),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new ListTile(
          leading: new Icon(Icons.star),
          title: new Text("收藏"),
          onTap: () async {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
