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

  @JsonKey(name: 'to_u_avatar')
  String toUAvatar;

  @JsonKey(name: 'by_u_avatar')
  String byUAvatar;

  MsgList(
    this.id,
    this.touid,
    this.byuid,
    this.type,
    this.isread,
    this.content,
    this.ctime,
    this.rtime,
    this.toUAvatar,
    this.byUAvatar,
  );

  factory MsgList.fromJson(Map<String, dynamic> srcJson) =>
      _$MsgListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MsgListToJson(this);
}
