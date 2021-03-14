// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replies_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepliesEntity _$RepliesEntityFromJson(Map<String, dynamic> json) {
  return RepliesEntity(
    json['success'] as bool,
    json['uid'] as int,
    json['replyCount'] as int,
    json['currPage'] as int,
    json['maxPage'] as int,
    (json['replyList'] as List)
        ?.map((e) =>
            e == null ? null : ReplyList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['_u_avatar'] as String,
  );
}

Map<String, dynamic> _$RepliesEntityToJson(RepliesEntity instance) =>
    <String, dynamic>{
      'success': instance.success,
      'uid': instance.uid,
      'replyCount': instance.replyCount,
      'currPage': instance.currPage,
      'maxPage': instance.maxPage,
      'replyList': instance.replyList,
      '_u_avatar': instance.uAvatar,
    };

ReplyList _$ReplyListFromJson(Map<String, dynamic> json) {
  return ReplyList(
    json['id'] as int,
    json['topic_id'] as int,
    json['ctime'] as int,
    json['mtime'] as int,
    json['content'] as String,
    json['uid'] as int,
    json['reply_id'] as int,
    json['floor'] as int,
    json['locked'] as int,
    json['review'] as int,
    json['uinfo'] == null
        ? null
        : Uinfo.fromJson(json['uinfo'] as Map<String, dynamic>),
    json['ubb'] == null
        ? null
        : Ubb.fromJson(json['ubb'] as Map<String, dynamic>),
    json['topic'] == null
        ? null
        : Topic.fromJson(json['topic'] as Map<String, dynamic>),
    json['topicUinfo'] == null
        ? null
        : TopicUinfo.fromJson(json['topicUinfo'] as Map<String, dynamic>),
    json['_u_avatar'] as String,
  );
}

Map<String, dynamic> _$ReplyListToJson(ReplyList instance) => <String, dynamic>{
      'id': instance.id,
      'topic_id': instance.topicId,
      'ctime': instance.ctime,
      'mtime': instance.mtime,
      'content': instance.content,
      'uid': instance.uid,
      'reply_id': instance.replyId,
      'floor': instance.floor,
      'locked': instance.locked,
      'review': instance.review,
      'uinfo': instance.uinfo,
      'ubb': instance.ubb,
      'topic': instance.topic,
      'topicUinfo': instance.topicUinfo,
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

Ubb _$UbbFromJson(Map<String, dynamic> json) {
  return Ubb();
}

Map<String, dynamic> _$UbbToJson(Ubb instance) => <String, dynamic>{};

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic(
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
    json['_u_avatar'] as String,
  );
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
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
      '_u_avatar': instance.uAvatar,
    };

TopicUinfo _$TopicUinfoFromJson(Map<String, dynamic> json) {
  return TopicUinfo();
}

Map<String, dynamic> _$TopicUinfoToJson(TopicUinfo instance) =>
    <String, dynamic>{};
