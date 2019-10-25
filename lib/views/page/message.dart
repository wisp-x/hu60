import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hu60/api/http.dart';
import 'package:hu60/util/functions.dart';
import 'package:hu60/views/community/detail.dart';
import 'package:hu60/views/page/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/message.dart' as MessageModel;

class Message extends StatefulWidget {
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  ScrollController _scrollController = ScrollController();

  List _list = List();

  /// 加载的页数
  int _page = 1;

  /// 是否正在加载数据
  bool _isLoading = false;

  /// 是否已经没有数据了
  bool _noMore = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('消息'),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _getData,
        onLoading: _getMore,
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
        child: _list.length == 0
            ? SpinKitFadingCircle(
                color: Colors.green,
                size: 50.0,
              )
            : ListView.separated(
                controller: _scrollController,
                itemBuilder: _renderRow,
                itemCount: _list.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 5.0,
                  );
                },
              ),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    return ListTile(
      title: Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Html(
          defaultTextStyle: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(40.0),
            fontWeight: FontWeight.w400,
          ),
          data: _list[index].content,
          useRichText: false,
          onLinkTap: (url) {
            _launchUrl(url);
          },
          onImageTap: (src) {},
        ),
      ),
    );
  }

  _launchUrl(url) async {
    url = parseUrl(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      var page;
      var id;
      if (url.contains('bbs.topic.')) {
        RegExp reg = new RegExp(r"\d+");
        Iterable<Match> matches = reg.allMatches(url);
        for (Match m in matches) {
          id = m.group(0);
        }
        page = Detail(id);
      }
      if (url.contains('user.info.')) {
        RegExp reg = new RegExp(r"\d+");
        Iterable<Match> matches = reg.allMatches(url);
        for (Match m in matches) {
          id = m.group(0);
        }
        page = User(id);
      }

      if (id != null && page != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Future _getData() async {
    if (!_isLoading) {
      setState(() {
        _page = 1;
      });
      var result = await Http.request('msg.index.@.json?p=${_page.toString()}');
      MessageModel.Message data = MessageModel.Message.fromJson(result.data);
      setState(() {
        _list = data.msgList;
        _isLoading = false;
        _noMore = false;
      });
      _refreshController.refreshCompleted();
    }
  }

  Future _getMore() async {
    if (!_isLoading && !_noMore) {
      setState(() {
        _isLoading = true;
        _page++;
      });
      var result = await Http.request('msg.index.@.json?p=${_page.toString()}');
      MessageModel.Message data = MessageModel.Message.fromJson(result.data);
      setState(() {
        _list.addAll(data.msgList);
        _isLoading = false;
        if (_page >= data.maxPage) {
          _noMore = true;
        }
      });
      _refreshController.loadComplete();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }
}
