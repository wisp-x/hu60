import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';


@JsonSerializable()
class Post extends Object {

  @JsonKey(name: 'fName')
  String fName;

  @JsonKey(name: 'fIndex')
  List<FIndex> fIndex;

  @JsonKey(name: 'tMeta')
  TMeta tMeta;

  @JsonKey(name: 'floorCount')
  int floorCount;

  @JsonKey(name: 'maxPage')
  int maxPage;

  @JsonKey(name: 'isLogin')
  bool isLogin;

  @JsonKey(name: 'tContents')
  List<TContents> tContents;

  @JsonKey(name: 'token')
  String token;

  Post(this.fName,this.fIndex,this.tMeta,this.floorCount,this.maxPage,this.isLogin,this.tContents,this.token,);

  factory Post.fromJson(Map<String, dynamic> srcJson) => _$PostFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PostToJson(this);

}


@JsonSerializable()
class FIndex extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  FIndex(this.id,this.name,);

  factory FIndex.fromJson(Map<String, dynamic> srcJson) => _$FIndexFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FIndexToJson(this);

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

  @JsonKey(name: 'essence')
  int essence;

  @JsonKey(name: 'locked')
  int locked;

  TMeta(this.title,this.readCount,this.uid,this.ctime,this.mtime,this.essence,this.locked,);

  factory TMeta.fromJson(Map<String, dynamic> srcJson) => _$TMetaFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TMetaToJson(this);

}


@JsonSerializable()
class TContents extends Object {

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'ctime')
  int ctime;

  @JsonKey(name: 'mtime')
  int mtime;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'floor')
  int floor;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'topic_id')
  int topicId;

  @JsonKey(name: 'uinfo')
  Uinfo uinfo;

  @JsonKey(name: 'canEdit')
  bool canEdit;

  @JsonKey(name: 'canDel')
  bool canDel;

  @JsonKey(name: 'canSink')
  bool canSink;

  TContents(this.uid,this.ctime,this.mtime,this.content,this.floor,this.id,this.topicId,this.uinfo,this.canEdit,this.canDel,this.canSink,);

  factory TContents.fromJson(Map<String, dynamic> srcJson) => _$TContentsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TContentsToJson(this);

}


@JsonSerializable()
class Uinfo extends Object {

  @JsonKey(name: 'name')
  String name;

  Uinfo(this.name,);

  factory Uinfo.fromJson(Map<String, dynamic> srcJson) => _$UinfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UinfoToJson(this);

}


