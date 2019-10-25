import 'dart:convert';

parseUrl(url) {
  var url64 = Uri.parse(url).queryParameters['url64'];
  if (url64 != null) {
    List<int> bytes = base64Decode(url64.replaceAll('.', '='));
    url = utf8.decode(bytes);
  }
  return url;
}