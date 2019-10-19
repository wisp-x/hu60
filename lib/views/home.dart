import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('全部'),
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('熊二哈'),
              accountEmail: Text('i@wispx.cn'),
              currentAccountPicture: GestureDetector(
                onTap: () => print('current user'),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://www.gravatar.com/avatar/7a585313ed855e8d652cbb3154a6056e?s=300&d=mm&r=g',
                  ),
                ),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(
                    'http://pic.netbian.com/uploads/allimg/190510/221228-15574975489aa1.jpg',
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('关于'),
              trailing: Icon(Icons.access_alarm),
              onTap: () => {},
            )
          ],
        ),
      ),
      body: Center(
        child: Text(
          'HomePage',
          style: TextStyle(
            fontSize: 35.0,
          ),
        ),
      ),
    );
  }
}
