import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common_utils/common_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/http.dart';
import '../../store/user.dart';
import '../../model/home.dart';
import './detail.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List list = List();

  /// 加载的页数
  int _page = 1;

  /// 是否正在加载数据
  bool _isLoading = false;

  /// 是否已经没有数据了
  bool _noMore = false;

  /// 默认头像地址
  String _defaultAvatarUrl = 'https://hu60.cn/upload/default.jpg';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Scaffold(
      body: Consumer<User>(
        builder: (context, User user, _) => Container(
          alignment: Alignment.center,
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropMaterialHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("上拉加载");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("加载失败！点击重试！");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("松手加载更多");
                }
                if (_noMore) {
                  body = Text("我也是有底线的~");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            onRefresh: _getData,
            onLoading: _getMore,
            child: list.length == 0
                ? SpinKitFadingCircle(
                    color: Colors.green,
                    size: 50.0,
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemBuilder: _renderRow,
                    itemCount: list.length,
                  ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String sid = prefs.get('sid');
          _launchUrl(
            "https://hu60.cn/q.php/${sid != null ? sid + '/' : ''}bbs.newtopic.0.html",
          );
        },
      ),
    );
  }

  _launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // throw 'Could not launch $url';
    }
  }

  Future _getData() async {
    if (!_isLoading) {
      setState(() {
        _page = 1;
      });
      var result = await Http.request('index.index.json');
      Home data = Home.fromJson(result.data);
      setState(() {
        list = data.newTopicList;
        _isLoading = false;
        _noMore = false;
      });
      _refreshController.refreshCompleted();
    }
  }

  Widget _renderRow(BuildContext context, int index) {
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
            _buildMeta(index),
            _buildTitle(index),
            _buildFoot(index),
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

  Future _getMore() async {
    if (!_isLoading && !_noMore) {
      setState(() {
        _isLoading = true;
        _page++;
      });
      var result = await Http.request('index.index.json?p=${_page.toString()}');
      Home data = Home.fromJson(result.data);
      setState(() {
        list.addAll(data.newTopicList);
        _isLoading = false;
        if (data.newTopicList.length == 0) {
          _noMore = true;
        }
      });
      _refreshController.loadComplete();
    }
  }

  Widget _buildMeta(index) {
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

  Widget _buildTitle(index) {
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

  Widget _buildFoot(index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.0),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(35.0),
        ),
        child: Row(
          children: <Widget>[
            /// 是否加精
            list[index].essence == 1 ? Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                '[精]',
                style: TextStyle(
                  color: Colors.red[400],
                ),
              ),
            ) : Text(''),

            /// 是否锁定
            list[index].locked == 1 ? Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                '[锁]',
                style: TextStyle(
                  color: Colors.red[400],
                ),
              ),
            ) : Text(''),

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
    _refreshController.dispose();
    super.dispose();
  }
}
