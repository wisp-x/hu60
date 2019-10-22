import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hu60/api/http.dart';
import 'package:hu60/model/post.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  final int id;

  Detail(this.id);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int _page = 1;

  var _data;

  /// 默认头像地址
  String _defaultAvatarUrl = 'https://hu60.cn/upload/default.jpg';

  ScrollController _scrollController = ScrollController();

  bool _noMore = false;

  bool _isLoading = false;

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
      body: _data == null
          ? SpinKitFadingCircle(
              color: Colors.green,
              size: 50.0,
            )
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                controller: _scrollController,
                children: <Widget>[
                  Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      _buildMeta(),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 15.0),
                        padding: EdgeInsets.only(
                            top: 10.0, left: 15.0, bottom: 10.0),
                        child: Text(
                          '评论列表(${_data.floorCount - 1})',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil.getInstance().setSp(35.0),
                          ),
                        ),
                        color: Colors.black12,
                      ),
                      _buildComments()
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildComments() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: _buildCommentsRenderRow,
      itemCount: _data.tContents.length + 1,
    );
  }

  Widget _buildCommentsRenderRow(BuildContext context, int index) {
    if (index == _data.tContents.length) {
      if (_noMore) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Text('已经到底啦~'),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Opacity(
            opacity: _isLoading ? 1.0 : 0.0,
            child: SpinKitHourGlass(
                color: Colors.green,
                size: 20.0,
            ),
          ),
        ),
      );
    } else {
      if (_page == 1 && index == 0) {
        return Divider(
          height: 0.0,
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Container(
                width: 40.0,
                height: 40.0,
                child: CachedNetworkImage(
                  imageUrl:
                      'http://qiniu.img.hu60.cn/avatar/${_data.tContents[index].uid}.jpg?t=${DateTime.now().day}',
                  placeholder: (context, url) =>
                      Image.network(_defaultAvatarUrl),
                  errorWidget: (context, url, error) =>
                      Image.network(_defaultAvatarUrl),
                ),
              ),
            ),
            trailing: Text(
              index == 1 ? '沙发' : '${index}楼',
              style: TextStyle(color: Colors.grey),
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 1.0),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      _data.tContents[index].uinfo.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    _data.tMeta.uid == _data.tContents[index].uid ? '楼主' : '',
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: _buildCommentsFoot(index),
          ),
          Container(
            padding:
                EdgeInsets.only(top: 0, left: 15.0, right: 15.0, bottom: 15.0),
            child: Html(
              defaultTextStyle: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(40.0),
                fontWeight: FontWeight.w400,
              ),
              data: _data.tContents[index].content,
              useRichText: false,
              onLinkTap: (url) {
                _launchURL(url);
              },
              onImageTap: (src) {},
            ),
          ),

          /// 创建分隔线
          Divider(
            height: 0.0,
          ),
        ],
      );
    }
  }

  Widget _buildCommentsFoot(index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.0),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(35.0),
        ),
        child: Row(
          children: <Widget>[
            /// 评论时间
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                TimelineUtil.format(_data.tContents[index].ctime * 1000),
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoot() {
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
                _data.fName,
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),

            /// 发布时间
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                "${TimelineUtil.format(_data.tMeta.ctime * 1000)} 发布",
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),

            /// 浏览数
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                "${_data.tMeta.readCount.toString()} 次点击",
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeta() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Container(
                width: 50.0,
                height: 50.0,
                child: CachedNetworkImage(
                  imageUrl:
                      'http://qiniu.img.hu60.cn/avatar/${_data.tMeta.uid}.jpg?t=${DateTime.now().day}',
                  placeholder: (context, url) =>
                      Image.network(_defaultAvatarUrl),
                  errorWidget: (context, url, error) =>
                      Image.network(_defaultAvatarUrl),
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                _data.tContents[0].uinfo.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: _buildFoot(),
          ),
          _buildTitle(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.0,
        left: 15.0,
        right: 15.0,
        bottom: 15.0,
      ),
      child: Html(
        defaultTextStyle: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(45.0),
          fontWeight: FontWeight.w400,
        ),
        data: _data.tContents[0].content,
        useRichText: false,
        onLinkTap: (url) {
          _launchURL(url);
        },
        onImageTap: (src) {},
      ),
    );
  }

  Widget _buildTitle() {
    return ListTile(
      title: Text(
        _data.tMeta.title,
        style: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(45.0),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future _getMore() async {
    if (!_isLoading && !_noMore && _data.maxPage > 1) {
      setState(() {
        _isLoading = true;
        _page++;
      });
      var result = await Http.request('bbs.topic.${widget.id}.${_page}.json');
      Post data = Post.fromJson(result.data);
      setState(() {
        _data.tContents.addAll(data.tContents);
        _isLoading = false;
        if (_page >= data.maxPage) {
          _noMore = true;
        }
      });
    }
  }

  Future<Null> _onRefresh() async {
    await _getData();
  }

  Future _getData() async {
    setState(() {
      _page = 1;
      _noMore = false;
    });
    var result = await Http.request('bbs.topic.${widget.id}.${_page}.json');
    Post data = Post.fromJson(result.data);
    setState(() {
      _data = data;
    });
  }

  Widget _buildBottomSheet(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: new Icon(Icons.star),
          title: new Text("收藏"),
          onTap: () async {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: new Icon(Icons.public),
          title: new Text("WebView"),
          onTap: () async {
            Navigator.pop(context);
            _launchURL("https://hu60.cn/q.php/bbs.topic.${widget.id}.html");
          },
        ),
      ],
    );
  }

  _launchURL(url) async {
    var url64 = Uri.parse(url).queryParameters['url64'];
    if (url64 != null) {
      List<int> bytes = base64Decode(url64.replaceAll('..', '=='));
      url = utf8.decode(bytes);
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
