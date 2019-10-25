import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';


@JsonSerializable()
class Message extends Object {

  @JsonKey(name: 'msgCount')
  int msgCount;

  @JsonKey(name: 'maxPage')
  int maxPage;

  @JsonKey(name: 'msgList')
  List<MsgList> msgList;

  Message(this.msgCount,this.maxPage,this.msgList,);

  factory Message.fromJson(Map<String, dynamic> srcJson) => _$MessageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

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

  MsgList(this.id,this.touid,this.byuid,this.type,this.isread,this.content,this.ctime,this.rtime,);

  factory MsgList.fromJson(Map<String, dynamic> srcJson) => _$MsgListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MsgListToJson(this);

}


