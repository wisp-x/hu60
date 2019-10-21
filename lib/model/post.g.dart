// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['fName'] as String,
    (json['fIndex'] as List)
        ?.map((e) =>
            e == null ? null : FIndex.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['tMeta'] == null
        ? null
        : TMeta.fromJson(json['tMeta'] as Map<String, dynamic>),
    json['floorCount'] as int,
    json['maxPage'] as int,
    json['isLogin'] as bool,
    (json['tContents'] as List)
        ?.map((e) =>
            e == null ? null : TContents.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['token'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'fName': instance.fName,
      'fIndex': instance.fIndex,
      'tMeta': instance.tMeta,
      'floorCount': instance.floorCount,
      'maxPage': instance.maxPage,
      'isLogin': instance.isLogin,
      'tContents': instance.tContents,
      'token': instance.token,
    };

FIndex _$FIndexFromJson(Map<String, dynamic> json) {
  return FIndex(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$FIndexToJson(FIndex instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

TMeta _$TMetaFromJson(Map<String, dynamic> json) {
  return TMeta(
    json['title'] as String,
    json['read_count'] as int,
    json['uid'] as int,
    json['ctime'] as int,
    json['mtime'] as int,
    json['essence'] as int,
    json['locked'] as int,
  );
}

Map<String, dynamic> _$TMetaToJson(TMeta instance) => <String, dynamic>{
      'title': instance.title,
      'read_count': instance.readCount,
      'uid': instance.uid,
      'ctime': instance.ctime,
      'mtime': instance.mtime,
      'essence': instance.essence,
      'locked': instance.locked,
    };

TContents _$TContentsFromJson(Map<String, dynamic> json) {
  return TContents(
    json['uid'] as int,
    json['ctime'] as int,
    json['mtime'] as int,
    json['content'] as String,
    json['floor'] as int,
    json['id'] as int,
    json['topic_id'] as int,
    json['uinfo'] == null
        ? null
        : Uinfo.fromJson(json['uinfo'] as Map<String, dynamic>),
    json['canEdit'] as bool,
    json['canDel'] as bool,
    json['canSink'] as bool,
  );
}

Map<String, dynamic> _$TContentsToJson(TContents instance) => <String, dynamic>{
      'uid': instance.uid,
      'ctime': instance.ctime,
      'mtime': instance.mtime,
      'content': instance.content,
      'floor': instance.floor,
      'id': instance.id,
      'topic_id': instance.topicId,
      'uinfo': instance.uinfo,
      'canEdit': instance.canEdit,
      'canDel': instance.canDel,
      'canSink': instance.canSink,
    };

Uinfo _$UinfoFromJson(Map<String, dynamic> json) {
  return Uinfo(
    json['name'] as String,
  );
}

Map<String, dynamic> _$UinfoToJson(Uinfo instance) => <String, dynamic>{
      'name': instance.name,
    };
