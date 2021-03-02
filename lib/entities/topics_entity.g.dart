// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topics_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicsEntity _$TopicsEntityFromJson(Map<String, dynamic> json) {
  return TopicsEntity(
    json['fName'] as String,
    json['fIndex'] as List,
    json['topicCount'] as int,
    json['currPage'] as int,
    json['maxPage'] as int,
    json['onlyEssence'] as bool,
    (json['childForum'] as List)
        ?.map((e) =>
            e == null ? null : ChildForum.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['topicList'] as List)
        ?.map((e) =>
            e == null ? null : TopicList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TopicsEntityToJson(TopicsEntity instance) =>
    <String, dynamic>{
      'fName': instance.fName,
      'fIndex': instance.fIndex,
      'topicCount': instance.topicCount,
      'currPage': instance.currPage,
      'maxPage': instance.maxPage,
      'onlyEssence': instance.onlyEssence,
      'childForum': instance.childForum,
      'topicList': instance.topicList,
    };

ChildForum _$ChildForumFromJson(Map<String, dynamic> json) {
  return ChildForum(
    json['id'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$ChildForumToJson(ChildForum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

TopicList _$TopicListFromJson(Map<String, dynamic> json) {
  return TopicList(
    json['topic_id'] as int,
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
    json['review'] as int,
    json['forum_name'] as String,
    json['reply_count'] as int,
    json['uinfo'] == null
        ? null
        : Uinfo.fromJson(json['uinfo'] as Map<String, dynamic>),
    json['_u_name'] as String,
    json['_u_avatar'] as String,
  );
}

Map<String, dynamic> _$TopicListToJson(TopicList instance) => <String, dynamic>{
      'topic_id': instance.topicId,
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
      'review': instance.review,
      'forum_name': instance.forumName,
      'reply_count': instance.replyCount,
      'uinfo': instance.uinfo,
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
