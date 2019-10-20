// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['uid'] as int,
    json['name'] as String,
    json['mail'] as String,
    json['signature'] as String,
    json['contact'] as String,
    json['regtime'] as int,
    json['hasRegPhone'] as bool,
    json['floorReverse'] as bool,
    json['siteAdmin'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'mail': instance.mail,
      'signature': instance.signature,
      'contact': instance.contact,
      'regtime': instance.regtime,
      'hasRegPhone': instance.hasRegPhone,
      'floorReverse': instance.floorReverse,
      'siteAdmin': instance.siteAdmin,
    };
