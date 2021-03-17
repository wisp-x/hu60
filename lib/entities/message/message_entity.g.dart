// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) {
  return MessageEntity(
    json['isSender'] as bool,
    json['msg'] == null
        ? null
        : Msg.fromJson(json['msg'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MessageEntityToJson(MessageEntity instance) =>
    <String, dynamic>{
      'isSender': instance.isSender,
      'msg': instance.msg,
    };

Msg _$MsgFromJson(Map<String, dynamic> json) {
  return Msg(
    json['id'] as int,
    json['touid'] as int,
    json['byuid'] as int,
    json['type'] as int,
    json['isread'] as int,
    json['content'] as String,
    json['ctime'] as int,
    json['rtime'] as int,
    json['toUinfo'] == null
        ? null
        : ToUinfo.fromJson(json['toUinfo'] as Map<String, dynamic>),
    json['byUinfo'] == null
        ? null
        : ByUinfo.fromJson(json['byUinfo'] as Map<String, dynamic>),
    json['to_u_avatar'] as String,
    json['by_u_avatar'] as String,
  );
}

Map<String, dynamic> _$MsgToJson(Msg instance) => <String, dynamic>{
      'id': instance.id,
      'touid': instance.touid,
      'byuid': instance.byuid,
      'type': instance.type,
      'isread': instance.isread,
      'content': instance.content,
      'ctime': instance.ctime,
      'rtime': instance.rtime,
      'toUinfo': instance.toUinfo,
      'byUinfo': instance.byUinfo,
      'to_u_avatar': instance.toUAvatar,
      'by_u_avatar': instance.byUAvatar,
    };

ToUinfo _$ToUinfoFromJson(Map<String, dynamic> json) {
  return ToUinfo(
    json['name'] as String,
  );
}

Map<String, dynamic> _$ToUinfoToJson(ToUinfo instance) => <String, dynamic>{
      'name': instance.name,
    };

ByUinfo _$ByUinfoFromJson(Map<String, dynamic> json) {
  return ByUinfo(
    json['name'] as String,
  );
}

Map<String, dynamic> _$ByUinfoToJson(ByUinfo instance) => <String, dynamic>{
      'name': instance.name,
    };
