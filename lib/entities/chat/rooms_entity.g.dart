// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomsEntity _$RoomsEntityFromJson(Map<String, dynamic> json) {
  return RoomsEntity(
    (json['chatRomList'] as List)
        ?.map((e) =>
            e == null ? null : ChatRomList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RoomsEntityToJson(RoomsEntity instance) =>
    <String, dynamic>{
      'chatRomList': instance.chatRomList,
    };

ChatRomList _$ChatRomListFromJson(Map<String, dynamic> json) {
  return ChatRomList(
    json['id'] as int,
    json['name'] as String,
    json['ztime'] as int,
  );
}

Map<String, dynamic> _$ChatRomListToJson(ChatRomList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ztime': instance.ztime,
    };
