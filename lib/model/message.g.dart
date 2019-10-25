// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['msgCount'] as int,
    json['maxPage'] as int,
    (json['msgList'] as List)
        ?.map((e) =>
            e == null ? null : MsgList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'msgCount': instance.msgCount,
      'maxPage': instance.maxPage,
      'msgList': instance.msgList,
    };

MsgList _$MsgListFromJson(Map<String, dynamic> json) {
  return MsgList(
    json['id'] as int,
    json['touid'] as int,
    json['byuid'] as int,
    json['type'] as int,
    json['isread'] as int,
    json['content'] as String,
    json['ctime'] as int,
    json['rtime'] as int,
  );
}

Map<String, dynamic> _$MsgListToJson(MsgList instance) => <String, dynamic>{
      'id': instance.id,
      'touid': instance.touid,
      'byuid': instance.byuid,
      'type': instance.type,
      'isread': instance.isread,
      'content': instance.content,
      'ctime': instance.ctime,
      'rtime': instance.rtime,
    };
