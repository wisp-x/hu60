// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return UserEntity(
    json['uid'] as int,
    json['name'] as String,
    json['signature'] as String,
    json['contact'] as String,
    json['regtime'] as int,
    json['hasRegPhone'] as bool,
    json['floorReverse'] as bool,
    json['siteAdmin'] as bool,
    json['permissions'] as List,
    json['_myself'] == null
        ? null
        : _myself.fromJson(json['_myself'] as Map<String, dynamic>),
    json['_u_avatar'] as String,
  );
}

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'signature': instance.signature,
      'contact': instance.contact,
      'regtime': instance.regtime,
      'hasRegPhone': instance.hasRegPhone,
      'floorReverse': instance.floorReverse,
      'siteAdmin': instance.siteAdmin,
      'permissions': instance.permissions,
      '_myself': instance.myself,
      '_u_avatar': instance.uAvatar,
    };

_myself _$_myselfFromJson(Map<String, dynamic> json) {
  return _myself(
    json['isLogin'] as bool,
    json['uid'] as int,
    json['newMsg'] as int,
    json['newAtInfo'] as int,
    json['_u_avatar'] as String,
  );
}

Map<String, dynamic> _$_myselfToJson(_myself instance) => <String, dynamic>{
      'isLogin': instance.isLogin,
      'uid': instance.uid,
      'newMsg': instance.newMsg,
      'newAtInfo': instance.newAtInfo,
      '_u_avatar': instance.uAvatar,
    };
