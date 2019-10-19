// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Home _$HomeFromJson(Map<String, dynamic> json) {
  return Home(
    json['userInfo'] == null
        ? null
        : UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
    (json['newTopicList'] as List)
        ?.map((e) =>
            e == null ? null : NewTopicList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'userInfo': instance.userInfo,
      'newTopicList': instance.newTopicList,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo();
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{};

NewTopicList _$NewTopicListFromJson(Map<String, dynamic> json) {
  return NewTopicList(
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
    json['uinfo'] == null
        ? null
        : Uinfo.fromJson(json['uinfo'] as Map<String, dynamic>),
    json['forum_name'] as String,
    json['reply_count'] as int,
  );
}

Map<String, dynamic> _$NewTopicListToJson(NewTopicList instance) =>
    <String, dynamic>{
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
      'uinfo': instance.uinfo,
      'forum_name': instance.forumName,
      'reply_count': instance.replyCount,
    };

Uinfo _$UinfoFromJson(Map<String, dynamic> json) {
  return Uinfo(
    json['name'] as String,
  );
}

Map<String, dynamic> _$UinfoToJson(Uinfo instance) => <String, dynamic>{
      'name': instance.name,
    };
