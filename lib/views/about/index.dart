import 'package:flutter/material.dart';
import 'package:hu60/views/about/packages.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('关于'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0),
              color: Colors.white,
              child: ListTile(
                title: Text(
                  '提出 BUG 或改进',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
                onTap: () async {
                  String url = 'https://github.com/wisp-x/hu60';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.grey[200],
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                title: Text(
                  '开源库',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Packages(),
                    ),
                  );
                },
              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.grey[200],
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                title: Text(
                  '版本号',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                trailing: Text('Version 1.0.0 (Build 1)'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
