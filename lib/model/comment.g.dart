// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    json['tMeta'] == null
        ? null
        : TMeta.fromJson(json['tMeta'] as Map<String, dynamic>),
    json['isLogin'] as bool,
    json['token'] as String,
    json['success'] as bool,
    json['notice'] as String,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'tMeta': instance.tMeta,
      'isLogin': instance.isLogin,
      'token': instance.token,
      'success': instance.success,
      'notice': instance.notice,
    };

TMeta _$TMetaFromJson(Map<String, dynamic> json) {
  return TMeta(
    json['title'] as String,
    json['read_count'] as int,
    json['uid'] as int,
    json['ctime'] as int,
    json['mtime'] as int,
    json['locked'] as int,
  );
}

Map<String, dynamic> _$TMetaToJson(TMeta instance) => <String, dynamic>{
      'title': instance.title,
      'read_count': instance.readCount,
      'uid': instance.uid,
      'ctime': instance.ctime,
      'mtime': instance.mtime,
      'locked': instance.locked,
    };
