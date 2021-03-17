import 'package:json_annotation/json_annotation.dart';

part 'message_entity.g.dart';

@JsonSerializable()
class MessageEntity extends Object {
  @JsonKey(name: 'isSender')
  bool isSender;

  @JsonKey(name: 'msg')
  Msg msg;

  MessageEntity(
    this.isSender,
    this.msg,
  );

  factory MessageEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$MessageEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MessageEntityToJson(this);
}

@JsonSerializable()
class Msg extends Object {
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

  @JsonKey(name: 'toUinfo')
  ToUinfo toUinfo;

  @JsonKey(name: 'byUinfo')
  ByUinfo byUinfo;

  @JsonKey(name: 'to_u_avatar')
  String toUAvatar;

  @JsonKey(name: 'by_u_avatar')
  String byUAvatar;

  Msg(
    this.id,
    this.touid,
    this.byuid,
    this.type,
    this.isread,
    this.content,
    this.ctime,
    this.rtime,
    this.toUinfo,
    this.byUinfo,
    this.toUAvatar,
    this.byUAvatar,
  );

  factory Msg.fromJson(Map<String, dynamic> srcJson) => _$MsgFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MsgToJson(this);
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
