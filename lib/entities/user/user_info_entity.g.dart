// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoEntity _$UserInfoEntityFromJson(Map<String, dynamic> json) {
  return UserInfoEntity(
    json['uid'] as int,
    json['name'] as String,
    json['signature'] as String ?? '-',
    json['contact'] as String ?? '-',
    json['regtime'] as int,
    json['blockPostStat'] as bool,
    json['isFollow'] as bool,
    json['isBlock'] as bool,
    json['hideUserCSS'] as bool,
    (json['permissions'] as List)?.map((e) => e as String)?.toList(),
    json['_u_avatar'] as String,
  );
}

Map<String, dynamic> _$UserInfoEntityToJson(UserInfoEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'signature': instance.signature,
      'contact': instance.contact,
      'regtime': instance.regtime,
      'blockPostStat': instance.blockPostStat,
      'isFollow': instance.isFollow,
      'isBlock': instance.isBlock,
      'hideUserCSS': instance.hideUserCSS,
      'permissions': instance.permissions,
      '_u_avatar': instance.uAvatar,
    };
