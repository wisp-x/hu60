import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class User {
  // 获取用户头像
  static String _getAvatar(BuildContext context, String avatarUrl) {
    if (avatarUrl == "/upload/default.jpg" || null == avatarUrl) {
      avatarUrl = "https://hu60.cn/upload/default.jpg";
    }
    // TODO 部分头像会出现 404 和 403，使用 precacheImage function 预加载图像
    // 这样操作会影响性能，但是可以通过错误回调设置正常的头像地址，等老虎修复！
    precacheImage(
      CachedNetworkImageProvider(avatarUrl),
      context,
      onError: (e, stackTrace) {
        avatarUrl = "https://hu60.cn/upload/default.jpg";
      },
    );
    return avatarUrl;
  }

  // 展示用户头像
  static Widget getAvatar({
    @required BuildContext context,
    @required String url,
    double size = 40.0, // 头像大小
    double borderRadius = 6.0, // 圆角
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        height: size,
        width: size,
        imageUrl: _getAvatar(context, url),
        placeholder: (context, url) => CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
      ),
    );
  }
}
