import 'package:json_annotation/json_annotation.dart';

part 'topic_entity.g.dart';


@JsonSerializable()
class TopicEntity extends Object {

  @JsonKey(name: 'fName')
  String fName;

  @JsonKey(name: 'fIndex')
  List<FIndex> fIndex;

  @JsonKey(name: 'tMeta')
  TMeta tMeta;

  @JsonKey(name: 'floorCount')
  int floorCount;

  @JsonKey(name: 'currPage')
  int currPage;

  @JsonKey(name: 'maxPage')
  int maxPage;

  @JsonKey(name: 'isLogin')
  bool isLogin;

  @JsonKey(name: 'tContents')
  List<TContents> tContents;

  @JsonKey(name: 'blockedReply')
  int blockedReply;

  @JsonKey(name: 'floorReverse')
  bool floorReverse;

  @JsonKey(name: 'token')
  String token;

  TopicEntity(this.fName,this.fIndex,this.tMeta,this.floorCount,this.currPage,this.maxPage,this.isLogin,this.tContents,this.blockedReply,this.floorReverse,this.token,);

  factory TopicEntity.fromJson(Map<String, dynamic> srcJson) => _$TopicEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicEntityToJson(this);

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

  @JsonKey(name: 'review')
  int review;

  @JsonKey(name: 'level')
  int level;

  @JsonKey(name: '_u_name')
  String uName;

  @JsonKey(name: '_u_avatar')
  String uAvatar;

  TMeta(this.title,this.readCount,this.uid,this.ctime,this.mtime,this.essence,this.locked,this.review,this.level,this.uName,this.uAvatar,);

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

  @JsonKey(name: 'review')
  int review;

  @JsonKey(name: 'locked')
  int locked;

  @JsonKey(name: 'uinfo')
  Uinfo uinfo;

  @JsonKey(name: 'canEdit')
  bool canEdit;

  @JsonKey(name: 'canDel')
  bool canDel;

  @JsonKey(name: 'canSink')
  bool canSink;

  @JsonKey(name: '_u_name')
  String uName;

  @JsonKey(name: '_u_avatar')
  String uAvatar;

  TContents(this.uid,this.ctime,this.mtime,this.content,this.floor,this.id,this.topicId,this.review,this.locked,this.uinfo,this.canEdit,this.canDel,this.canSink,this.uName,this.uAvatar,);

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


