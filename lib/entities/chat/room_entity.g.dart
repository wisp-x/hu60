// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomEntity _$RoomEntityFromJson(Map<String, dynamic> json) {
  return RoomEntity(
    json['chatRomName'] as String,
    json['isLogin'] as bool,
    json['chatCount'] as int,
    json['currPage'] as int,
    json['maxPage'] as int,
    (json['chatList'] as List)
        ?.map((e) =>
            e == null ? null : ChatList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['blockedReply'] as int,
    json['token'] as String,
  );
}

Map<String, dynamic> _$RoomEntityToJson(RoomEntity instance) =>
    <String, dynamic>{
      'chatRomName': instance.chatRomName,
      'isLogin': instance.isLogin,
      'chatCount': instance.chatCount,
      'currPage': instance.currPage,
      'maxPage': instance.maxPage,
      'chatList': instance.chatList,
      'blockedReply': instance.blockedReply,
      'token': instance.token,
    };

ChatList _$ChatListFromJson(Map<String, dynamic> json) {
  return ChatList(
    json['id'] as int,
    json['room'] as String,
    json['lid'] as int,
    json['uid'] as int,
    json['content'] as String,
    json['time'] as int,
    json['hidden'] as int,
    json['review'] as int,
    json['uinfo'] == null
        ? null
        : Uinfo.fromJson(json['uinfo'] as Map<String, dynamic>),
    json['canDel'] as bool,
    json['_u_avatar'] as String,
  );
}

Map<String, dynamic> _$ChatListToJson(ChatList instance) => <String, dynamic>{
      'id': instance.id,
      'room': instance.room,
      'lid': instance.lid,
      'uid': instance.uid,
      'content': instance.content,
      'time': instance.time,
      'hidden': instance.hidden,
      'review': instance.review,
      'uinfo': instance.uinfo,
      'canDel': instance.canDel,
      '_u_avatar': instance.uAvatar,
    };

Uinfo _$UinfoFromJson(Map<String, dynamic> json) {
  return Uinfo(
    json['name'] as String,
  );
}

Map<String, dynamic> _$UinfoToJson(Uinfo instance) => <String, dynamic>{
      'name': instance.name,
    };
