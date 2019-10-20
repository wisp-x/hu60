// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login(
    json['success'] as bool,
    json['sid'] as String,
    json['page'] as String,
    json['notice'] as String,
  );
}

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'success': instance.success,
      'sid': instance.sid,
      'page': instance.page,
      'notice': instance.notice,
    };
