import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../api/http.dart';
import '../../store/user.dart';
import '../../model/home.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community>
    with AutomaticKeepAliveClientMixin {
  List list = List();
  int _page = 1; // 加载的页数
  bool isLoading = false; // 是否正在加载数据
  bool noMore = false; // 是否已经没有数据了
  ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Consumer<User>(
        builder: (context, User user, _) => Container(
          alignment: Alignment.center,
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: list.length == 0
                ? SpinKitFadingCircle(
                    color: Colors.green,
                    size: 50.0,
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemBuilder: _renderRow,
                    itemCount: list.length + 1,
                  ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Provider.of<User>(context, listen: false).increment();
        },
      ),
    );
  }

  Future getData() async {
    if (!isLoading) {
      var result = await Http.request('index.index.json');
      Home data = Home.fromJson(result.data);
      setState(() {
        list = data.newTopicList;
        isLoading = false;
      });
    }
  }

  Widget _loadMoreDataLoading() {
    if (noMore) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text('已经到底啦~'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index == list.length) {
      return _loadMoreDataLoading();
    } else {
      return ListTile(
        leading: ClipOval(
          child: Image(
            image:
                NetworkImage('http://qiniu.img.hu60.cn/avatar/20048.jpg?t=1'),
          ),
        ),
        trailing: Text('呵呵'),
        isThreeLine: true,
        title: Text(list[index].title),
        subtitle: Text('我擦'),
        onTap: () => {},
      );
    }
  }

  Future<Null> _onRefresh() async {
    await getData();
  }

  Future _getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        _page++;
      });
      var result = await Http.request('index.index.json?p=$_page');
      Home data = Home.fromJson(result.data);
      setState(() {
        list.addAll(data.newTopicList);
        isLoading = false;
        if (data.newTopicList.length == 0) {
          noMore = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
}
