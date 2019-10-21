import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hu60/api/http.dart';
import 'package:hu60/model/search.dart';
import 'package:hu60/store/user.dart' as UserState;
import 'package:hu60/model/user.dart' as UserModel;
import 'package:hu60/views/community/detail.dart';
import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  ScrollController _scrollController = ScrollController();

  List list = List();

  /// 加载的页数
  int _page = 1;

  /// 是否正在加载数据
  bool _isLoading = false;

  /// 是否已经没有数据了
  bool _noMore = false;

  /// 默认头像地址
  String _defaultAvatarUrl = 'https://hu60.cn/upload/default.jpg';

  /// 用户名
  String _username;

  @override
  void initState() {
    super.initState();
    _getData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _username = Provider.of<UserState.User>(context).name;
    });
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('帖子'),
      ),
      body: RefreshIndicator(
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
    );
  }

  Future _getData() async {
    if (!_isLoading) {
      setState(() {
        _page = 1;
      });
      await _username;
      var result = await Http.request('bbs.search.json?keywords=&username=${_username}&p=${_page}');
      print(result);
      Search data = Search.fromJson(result.data);
      setState(() {
        list = data.topicList;
        _isLoading = false;
        _noMore = false;
      });
    }
  }

  Widget _loadMoreDataLoading() {
    if (_noMore) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text('已经到底啦~'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Opacity(
          opacity: _isLoading ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index == list.length) {
      return _loadMoreDataLoading();
    } else {
      /// 创建分隔线
      if (index.isOdd) {
        return new Divider(
          height: 0.0,
        );
      }

      return ListTile(
        title: Container(
          margin: EdgeInsets.only(top: index == 0 ? 10.0 : 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildMeta(index),
              buildTitle(index),
              buildFoot(index),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detail(list[index].id),
            ),
          );
        },
      );
    }
  }

  Future<Null> _onRefresh() async {
    await _getData();
  }

  Future _getMore() async {
    if (!_isLoading && !_noMore) {
      setState(() {
        _isLoading = true;
        _page++;
      });
      var result = await Http.request('bbs.search.json?keywords=&username=${_username}&p=${_page}');
      Search data = Search.fromJson(result.data);
      setState(() {
        list.addAll(data.topicList);
        _isLoading = false;
        if (_page == data.maxPage) {
          _noMore = true;
        }
      });
    }
  }

  Widget buildMeta(index) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 20.0,
            height: 20.0,
            margin: EdgeInsets.only(right: 8.0),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl:
                'http://qiniu.img.hu60.cn/avatar/${list[index].uid}.jpg',
                placeholder: (context, url) => Image.network(_defaultAvatarUrl),
                errorWidget: (context, url, error) =>
                    Image.network(_defaultAvatarUrl),
              ),
            ),
          ),
          Text(list[index].uinfo.name),
        ],
      ),
    );
  }

  Widget buildTitle(index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Text(
        list[index].title,
        style: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(45.0),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildFoot(index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.0),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(35.0),
        ),
        child: Row(
          children: <Widget>[
            /// 板块名称
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                list[index].forumName,
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),

            /// 回复数
            Icon(
              Icons.insert_comment,
              color: Colors.black26,
              size: 18.0,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                list[index].replyCount.toString(),
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),

            /// 浏览数
            Icon(
              Icons.visibility,
              color: Colors.black26,
              size: 18.0,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                list[index].readCount.toString(),
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),

            /// 发布时间
            Text(
              TimelineUtil.format(list[index].ctime * 1000),
              style: TextStyle(
                color: Colors.black45,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}