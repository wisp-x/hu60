import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as flutterHtml;
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:hu60/services/utils.dart';
import 'dart:ui' as ui;
import 'package:html/dom.dart' as dom;
import 'package:hu60/views/common/photo_gallery.dart';
import 'package:hu60/views/forum/topic_view.dart';
import 'package:hu60/views/user/user_info_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Html {
  static decode(String content) {
    // 去除小尾巴
    RegExp regExp1 = RegExp(
      r"""<span(.*?)class=("|')usercss uid-\d+("|').*?style=\".*?\">.*?</span>""",
    );
    content = content.replaceAll(regExp1, "");
    // 内联样式标签不规范会引起的崩溃问题, 直接正则替换掉内联样式
    RegExp regExp2 = RegExp(r"""style\s*=\s*('[^']*'|"[^"]*")""");
    content = content.replaceAll(regExp2, "");
    return Padding(
      padding: EdgeInsets.only(right: 5),
      child: flutterHtml.Html(
        data: content,
        onImageError: (dynamic exception, StackTrace stackTrace) {
          print("加载错误 $exception");
        },
        style: {
          "*": Style.fromTextStyle(
            TextStyle(
              fontSize: 17.5,
              inherit: false,
              wordSpacing: 0.0,
              letterSpacing: 1.0,
            ),
          ),
        },
        customRender: {
          "div": (
            RenderContext context,
            Widget child,
          ) {
            final attrs = context.tree.element?.attributes;
            final element = context.tree.element;
            if (element == null) return null;
            switch (attrs["class"]) {
              case "tp info-box":
                return Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF7474),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    element.text,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
                break;
              default:
                return null;
            }
          },
          "img": (
            RenderContext context,
            Widget child,
          ) {
            final attrs = context.tree.element?.attributes;
            final element = context.tree.element;
            if (element == null) return null;
            if (attrs["src"] == null || attrs["src"] == "") {
              return Text(element.text);
            }
            switch (attrs["class"]) {
              case "userimg":
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: CachedNetworkImage(
                        imageUrl: attrs["src"],
                        placeholder: (context, url) => Center(
                          child: CupertinoActivityIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(
                      () => PhotoGallery(
                        index: 0,
                        images: [attrs["src"]],
                        heroTag: attrs["src"],
                      ),
                    );
                  },
                );
                break;
              case "hu60_face":
                return WidgetSpan(
                  alignment: ui.PlaceholderAlignment.middle,
                  child: Container(
                    margin: EdgeInsets.only(left: 2, right: 2),
                    width: 30,
                    height: 30,
                    child: Image.network(attrs["src"]),
                  ),
                );
                break;
              default:
                return GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: attrs["src"],
                    placeholder: (context, url) => CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) => Text(
                      "图片加载失败",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  onTap: () {
                    Get.to(
                      () => PhotoGallery(
                        index: 0,
                        images: [attrs["src"]],
                        heroTag: attrs["src"],
                      ),
                    );
                  },
                );
            }
          },
          "a": (
            RenderContext context,
            Widget child,
          ) {
            final attrs = context.tree.element?.attributes;
            final element = context.tree.element;
            if (element == null) return null;
            switch (attrs["class"]) {
              case "userlink": // 链接
                return _buildOpenUrlWidget(attrs, element);
                break;
              case "userat": // @ 符号
                return Text(
                  element.text,
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: ScreenUtil().setSp(42),
                  ),
                );
                break;
              case "hu60_pos":
                var id = 0;
                if (attrs["href"] != null &&
                    RegExp(r"bbs\.topic\.\d+\.json").hasMatch(attrs["href"])) {
                  id = int.parse(RegExp(r"\d+", multiLine: true)
                      .allMatches(attrs["href"])
                      .map((e) => e.group(0))
                      .first);
                }
                return GestureDetector(
                  child: Text(
                    element.text,
                    style: TextStyle(
                      color: Colors.blue[400],
                      fontSize: ScreenUtil().setSp(34),
                    ),
                  ),
                  onTap: () {
                    if (id != 0) Get.to(() => TopicView(id: id));
                  },
                );
                break;
              case "userinfo": // @ 符号后面的文字
                var id = 0;
                if (attrs["href"] != null &&
                    RegExp(r"user\.info\.\d+\.json").hasMatch(attrs["href"])) {
                  id = int.parse(RegExp(r"\d+", multiLine: true)
                      .allMatches(attrs["href"])
                      .map((e) => e.group(0))
                      .first);
                }
                return GestureDetector(
                  child: Text(
                    element.text,
                    style: TextStyle(
                      color: Colors.blue[400],
                      fontSize: ScreenUtil().setSp(34),
                    ),
                  ),
                  onTap: () {
                    if (id != 0) Get.to(() => UserInfoView(id: id));
                  },
                );
                break;
              default:
                if (attrs["class"] == null && attrs["href"] != null) {
                  if (canLaunch(attrs["href"]) != null) {
                    return _buildOpenUrlWidget(attrs, element);
                  }
                }
                return null;
            }
          }
        },
      ),
    );
  }

  static _buildOpenUrlWidget(Map<Object, String> attrs, dom.Element element) {
    return GestureDetector(
      onTap: () => Utils.openUrl(attrs["href"]),
      child: Text.rich(
        TextSpan(
          children: <InlineSpan>[
            WidgetSpan(
              alignment: ui.PlaceholderAlignment.middle,
              child: Text(
                element.text,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(36),
                  color: Colors.blue[400],
                ),
              ),
            ),
            WidgetSpan(
              alignment: ui.PlaceholderAlignment.middle,
              child: Icon(
                Icons.open_in_new_rounded,
                size: ScreenUtil().setWidth(38),
                color: Colors.blue[400],
              ),
            )
          ],
        ),
      ),
    );
  }
}
