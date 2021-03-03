import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as flutterHtml;
import 'package:flutter_html/html_parser.dart';
import 'package:hu60/utils/utils.dart';
import 'dart:ui' as ui;
import 'package:html/dom.dart' as dom;
import 'package:hu60/views/common/photo_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class Html {
  static decode(String content) {
    return flutterHtml.Html(
      data: content,
      onImageError: (dynamic exception, StackTrace stackTrace) {
        print(exception);
      },
      customRender: {
        "img": (
          RenderContext context,
          Widget child,
          Map<String, String> attrs,
          dom.Element element,
        ) {
          print(attrs);
          switch (attrs["class"]) {
            case "userimg":
              return GestureDetector(
                child: Image.network(attrs["src"]),
                onTap: () {
                  Get.to(
                    () => PhotoViewScreen(
                      imageProvider: NetworkImage(attrs["src"]),
                      heroTag: "simple",
                    ),
                  );
                },
              );
              break;
            default:
              return null;
          }
        },
        "a": (
          RenderContext context,
          Widget child,
          Map<String, String> attrs,
          dom.Element element,
        ) {
          switch (attrs["class"]) {
            case "userlink": // 链接
              return _buildOpenUrlWidget(attrs, element);
              break;
            case "userat": // @ 符号
              return Text(
                element.text,
                style: TextStyle(color: Colors.blue[400]),
              );
              break;
            case "userinfo": // @ 符号后面的文字
              return Text(
                element.text,
                style: TextStyle(color: Colors.blue[400]),
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
    );
  }

  static _buildOpenUrlWidget(Map<String, String> attrs, dom.Element element) {
    return GestureDetector(
      onTap: () => Utils.openUrl(attrs["href"]),
      child: Text.rich(
        TextSpan(
          children: <InlineSpan>[
            WidgetSpan(
              alignment: ui.PlaceholderAlignment.middle,
              child: Text(
                element.text,
                style: TextStyle(color: Colors.blue[400]),
              ),
            ),
            WidgetSpan(
              alignment: ui.PlaceholderAlignment.middle,
              child: Icon(
                Icons.open_in_new_rounded,
                size: 17,
                color: Colors.blue[400],
              ),
            )
          ],
        ),
      ),
    );
  }
}
