import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hu60/api/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../model/search.dart' as SearchModel;
import '../community/detail.dart';

class Search extends StatefulWidget {
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _textController = TextEditingController();

  FocusNode _focusNode;

  List _list = List();

  /// 加载的页数
  int _page = 1;

  /// 最大页数
  int _maxPage = 1;

  /// 是否正在加载数据
  bool _isLoading = false;

  /// 是否正在搜索
  bool _isSearch = false;

  /// 是否没有搜索到数据
  bool _notSearchData = false;

  /// 是否已经没有数据了
  bool _noMore = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('搜索帖子'),
      ),
      body: Column(
        children: <Widget>[
          _buildTextComposer(),
          Expanded(
            child: _isSearch
                ? SpinKitFadingCircle(
                    color: Colors.green,
                    size: 50.0,
                  )
                : _buildList(),
          ),
        ],
      ),
    );
  }

  Future _getData() async {
    setState(() {
      _isLoading = true;
      _page = 1;
      _noMore = false;
      _isSearch = true;
      _notSearchData = false;
    });
    var result = await Http.request(
      'bbs.search.json?keywords=${_textController.text}&username=&p=${_page.toString()}',
    );
    SearchModel.Search data = SearchModel.Search.fromJson(result.data);
    setState(() {
      _list = data.topicList;
      _maxPage = data.maxPage;
      _isSearch = false;
      _isLoading = false;
      if (_list.length == 0) {
        _notSearchData = true;
      }
    });
    _refreshController.refreshCompleted();
  }

  Future _getMore() async {
    if (!_isLoading && !_noMore && _maxPage > 1) {
      setState(() {
        _isLoading = true;
        _page++;
      });
      var result = await Http.request(
          'bbs.search.json?keywords=${_textController.text}&username=&p=${_page.toString()}');
      SearchModel.Search data = SearchModel.Search.fromJson(result.data);
      setState(() {
        _maxPage = data.maxPage;
        _list.addAll(data.topicList);
        _isLoading = false;
        if (_page >= _maxPage) {
          _noMore = true;
        }
      });
      _refreshController.loadComplete();
    }
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index.isOdd) {
      return Divider(
        height: 0.0,
      );
    }
    return ListTile(
      title: Text(
        _list[index].title,
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(_list[index].id),
          ),
        );
      },
    );
  }

  Widget _buildList() {
    if (_notSearchData) {
      return Center(
        child: Text('没有搜索到任何东西呢, 换一个关键字试试?'),
      );
    }

    return GestureDetector(
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
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
        child: ListView.builder(
          itemBuilder: _renderRow,
          itemCount: _list.length,
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        color: Colors.black12,
        padding: EdgeInsets.only(
          top: 2.0,
          left: 5.0,
          right: 5.0,
          bottom: 2.0,
        ),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: TextField(
                  focusNode: _focusNode,
                  keyboardType: TextInputType.text,
                  controller: _textController,
                  minLines: 1,
                  maxLines: 10,
                  showCursor: true,
                  onSubmitted: _handleSubmitted,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    hintText: "输入内容回车搜索...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(0.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    /// _textController.clear();
    _getData();
  }

  @override
  void dispose() {
    _textController.dispose();
    _refreshController.dispose();
    super.dispose();
  }
}
