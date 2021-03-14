import 'package:json_annotation/json_annotation.dart';

part 'replies_entity.g.dart';

@JsonSerializable()
class RepliesEntity extends Object {
  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'replyCount')
  int replyCount;

  @JsonKey(name: 'currPage')
  int currPage;

  @JsonKey(name: 'maxPage')
  int maxPage;

  @JsonKey(name: 'replyList')
  List<ReplyList> replyList;

  @JsonKey(name: '_u_avatar')
  String uAvatar;

  RepliesEntity(
    this.success,
    this.uid,
    this.replyCount,
    this.currPage,
    this.maxPage,
    this.replyList,
    this.uAvatar,
  );

  factory RepliesEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$RepliesEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RepliesEntityToJson(this);
}

@JsonSerializable()
class ReplyList extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'topic_id')
  int topicId;

  @JsonKey(name: 'ctime')
  int ctime;

  @JsonKey(name: 'mtime')
  int mtime;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'reply_id')
  int replyId;

  @JsonKey(name: 'floor')
  int floor;

  @JsonKey(name: 'locked')
  int locked;

  @JsonKey(name: 'review')
  int review;

  @JsonKey(name: 'uinfo')
  Uinfo uinfo;

  @JsonKey(name: 'ubb')
  Ubb ubb;

  @JsonKey(name: 'topic')
  Topic topic;

  @JsonKey(name: 'topicUinfo')
  TopicUinfo topicUinfo;

  @JsonKey(name: '_u_avatar')
  String uAvatar;

  ReplyList(
    this.id,
    this.topicId,
    this.ctime,
    this.mtime,
    this.content,
    this.uid,
    this.replyId,
    this.floor,
    this.locked,
    this.review,
    this.uinfo,
    this.ubb,
    this.topic,
    this.topicUinfo,
    this.uAvatar,
  );

  factory ReplyList.fromJson(Map<String, dynamic> srcJson) =>
      _$ReplyListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ReplyListToJson(this);
}

@JsonSerializable()
class Uinfo extends Object {
  @JsonKey(name: 'name')
  String name;

  Uinfo(
    this.name,
  );

  factory Uinfo.fromJson(Map<String, dynamic> srcJson) =>
      _$UinfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UinfoToJson(this);
}

@JsonSerializable()
class Ubb extends Object {
  Ubb();

  factory Ubb.fromJson(Map<String, dynamic> srcJson) => _$UbbFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UbbToJson(this);
}

@JsonSerializable()
class Topic extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'content_id')
  int contentId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'read_count')
  int readCount;

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'ctime')
  int ctime;

  @JsonKey(name: 'mtime')
  int mtime;

  @JsonKey(name: 'level')
  int level;

  @JsonKey(name: 'essence')
  int essence;

  @JsonKey(name: 'forum_id')
  int forumId;

  @JsonKey(name: 'locked')
  int locked;

  @JsonKey(name: 'review')
  int review;

  @JsonKey(name: '_u_avatar')
  String uAvatar;

  Topic(
    this.id,
    this.contentId,
    this.title,
    this.readCount,
    this.uid,
    this.ctime,
    this.mtime,
    this.level,
    this.essence,
    this.forumId,
    this.locked,
    this.review,
    this.uAvatar,
  );

  factory Topic.fromJson(Map<String, dynamic> srcJson) =>
      _$TopicFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable()
class TopicUinfo extends Object {
  TopicUinfo();

  factory TopicUinfo.fromJson(Map<String, dynamic> srcJson) =>
      _$TopicUinfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicUinfoToJson(this);
}
