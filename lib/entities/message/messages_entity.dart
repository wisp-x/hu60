import 'package:json_annotation/json_annotation.dart';

part 'messages_entity.g.dart';

@JsonSerializable()
class MessagesEntity extends Object {
  @JsonKey(name: 'msgCount')
  int msgCount;

  @JsonKey(name: 'currPage')
  int currPage;

  @JsonKey(name: 'maxPage')
  int maxPage;

  @JsonKey(name: 'msgList')
  List<MsgList> msgList;

  MessagesEntity(
    this.msgCount,
    this.currPage,
    this.maxPage,
    this.msgList,
  );

  factory MessagesEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$MessagesEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MessagesEntityToJson(this);
}

@JsonSerializable()
class MsgList extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'touid')
  int touid;

  @JsonKey(name: 'byuid')
  int byuid;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'isread')
  int isread;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'ctime')
  int ctime;

  @JsonKey(name: 'rtime')
  int rtime;

  @JsonKey(name: 'byUinfo')
  ByUinfo byUinfo;

  @JsonKey(name: 'toUinfo')
  ToUinfo toUinfo;

  MsgList(
    this.id,
    this.touid,
    this.byuid,
    this.type,
    this.isread,
    this.content,
    this.ctime,
    this.rtime,
    this.byUinfo,
    this.toUinfo,
  );

  factory MsgList.fromJson(Map<String, dynamic> srcJson) =>
      _$MsgListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MsgListToJson(this);
}

@JsonSerializable()
class ByUinfo extends Object {
  @JsonKey(name: 'name')
  String name;

  ByUinfo(
    this.name,
  );

  factory ByUinfo.fromJson(Map<String, dynamic> srcJson) =>
      _$ByUinfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ByUinfoToJson(this);
}

@JsonSerializable()
class ToUinfo extends Object {
  @JsonKey(name: 'name')
  String name;

  ToUinfo(
    this.name,
  );

  factory ToUinfo.fromJson(Map<String, dynamic> srcJson) =>
      _$ToUinfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ToUinfoToJson(this);
}
