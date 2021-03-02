// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicEntity _$TopicEntityFromJson(Map<String, dynamic> json) {
  return TopicEntity(
    json['fName'] as String,
    (json['fIndex'] as List)
        ?.map((e) =>
            e == null ? null : FIndex.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['tMeta'] == null
        ? null
        : TMeta.fromJson(json['tMeta'] as Map<String, dynamic>),
    json['floorCount'] as int,
    json['currPage'] as int,
    json['maxPage'] as int,
    json['isLogin'] as bool,
    (json['tContents'] as List)
        ?.map((e) =>
            e == null ? null : TContents.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['blockedReply'] as int,
    json['floorReverse'] as bool,
    json['token'] as String,
  );
}

Map<String, dynamic> _$TopicEntityToJson(TopicEntity instance) =>
    <String, dynamic>{
      'fName': instance.fName,
      'fIndex': instance.fIndex,
      'tMeta': instance.tMeta,
      'floorCount': instance.floorCount,
      'currPage': instance.currPage,
      'maxPage': instance.maxPage,
      'isLogin': instance.isLogin,
      'tContents': instance.tContents,
      'blockedReply': instance.blockedReply,
      'floorReverse': instance.floorReverse,
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
    json['review'] as int,
    json['level'] as int,
    json['_u_name'] as String,
    json['_u_avatar'] as String,
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
      'review': instance.review,
      'level': instance.level,
      '_u_name': instance.uName,
      '_u_avatar': instance.uAvatar,
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
    json['review'] as int,
    json['locked'] as int,
    json['uinfo'] == null
        ? null
        : Uinfo.fromJson(json['uinfo'] as Map<String, dynamic>),
    json['canEdit'] as bool,
    json['canDel'] as bool,
    json['canSink'] as bool,
    json['_u_name'] as String,
    json['_u_avatar'] as String,
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
      'review': instance.review,
      'locked': instance.locked,
      'uinfo': instance.uinfo,
      'canEdit': instance.canEdit,
      'canDel': instance.canDel,
      'canSink': instance.canSink,
      '_u_name': instance.uName,
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
