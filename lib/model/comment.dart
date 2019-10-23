import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';


@JsonSerializable()
class Comment extends Object {

  @JsonKey(name: 'tMeta')
  TMeta tMeta;

  @JsonKey(name: 'isLogin')
  bool isLogin;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'notice')
  String notice;

  Comment(this.tMeta,this.isLogin,this.token,this.success,this.notice,);

  factory Comment.fromJson(Map<String, dynamic> srcJson) => _$CommentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

}


@JsonSerializable()
class TMeta extends Object {

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'read_count')
  int readCount;

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'ctime')
  int ctime;

  @JsonKey(name: 'mtime')
  int mtime;

  @JsonKey(name: 'locked')
  int locked;

  TMeta(this.title,this.readCount,this.uid,this.ctime,this.mtime,this.locked,);

  factory TMeta.fromJson(Map<String, dynamic> srcJson) => _$TMetaFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TMetaToJson(this);

}


