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
    };
