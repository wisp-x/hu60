// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collect _$CollectFromJson(Map<String, dynamic> json) {
  return Collect(
    json['success'] as bool,
    json['notice'] as String,
  );
}

Map<String, dynamic> _$CollectToJson(Collect instance) => <String, dynamic>{
      'success': instance.success,
      'notice': instance.notice,
    };
