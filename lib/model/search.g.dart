// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) {
  return Search(
    json['topicCount'] as int,
    json['maxPage'] as int,
    (json['topicList'] as List)
        ?.map((e) =>
            e == null ? null : TopicList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'topicCount': instance.topicCount,
      'maxPage': instance.maxPage,
      'topicList': instance.topicList,
    };

TopicList _$TopicListFromJson(Map<String, dynamic> json) {
  return TopicList(
    json['id'] as int,
    json['content_id'] as int,
    json['title'] as String,
    json['read_count'] as int,
    json['uid'] as int,
    json['ctime'] as int,
    json['mtime'] as int,
    json['level'] as int,
    json['essence'] as int,
    json['forum_id'] as int,
    json['locked'] as int,
    json['forum_name'] as String,
    json['reply_count'] as int,
    json['uinfo'] == null
        ? null
        : Uinfo.fromJson(json['uinfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TopicListToJson(TopicList instance) => <String, dynamic>{
      'id': instance.id,
      'content_id': instance.contentId,
      'title': instance.title,
      'read_count': instance.readCount,
      'uid': instance.uid,
      'ctime': instance.ctime,
      'mtime': instance.mtime,
      'level': instance.level,
      'essence': instance.essence,
      'forum_id': instance.forumId,
      'locked': instance.locked,
      'forum_name': instance.forumName,
      'reply_count': instance.replyCount,
      'uinfo': instance.uinfo,
    };

Uinfo _$UinfoFromJson(Map<String, dynamic> json) {
  return Uinfo(
    json['name'] as String,
  );
}

Map<String, dynamic> _$UinfoToJson(Uinfo instance) => <String, dynamic>{
      'name': instance.name,
    };
