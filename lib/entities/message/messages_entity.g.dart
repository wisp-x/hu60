// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesEntity _$MessagesEntityFromJson(Map<String, dynamic> json) {
  return MessagesEntity(
    json['msgCount'] as int,
    json['currPage'] as int,
    json['maxPage'] as int,
    (json['msgList'] as List)
        ?.map((e) =>
            e == null ? null : MsgList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MessagesEntityToJson(MessagesEntity instance) =>
    <String, dynamic>{
      'msgCount': instance.msgCount,
      'currPage': instance.currPage,
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
    json['to_u_avatar'] as String,
    json['by_u_avatar'] as String,
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
      'to_u_avatar': instance.toUAvatar,
      'by_u_avatar': instance.byUAvatar,
    };
