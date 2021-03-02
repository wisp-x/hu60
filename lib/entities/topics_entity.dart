import 'package:json_annotation/json_annotation.dart';

part 'topics_entity.g.dart';


@JsonSerializable()
class TopicsEntity extends Object {

  @JsonKey(name: 'fName')
  String fName;

  @JsonKey(name: 'fIndex')
  List<dynamic> fIndex;

  @JsonKey(name: 'topicCount')
  int topicCount;

  @JsonKey(name: 'currPage')
  int currPage;

  @JsonKey(name: 'maxPage')
  int maxPage;

  @JsonKey(name: 'onlyEssence')
  bool onlyEssence;

  @JsonKey(name: 'childForum')
  List<ChildForum> childForum;

  @JsonKey(name: 'topicList')
  List<TopicList> topicList;

  TopicsEntity(this.fName,this.fIndex,this.topicCount,this.currPage,this.maxPage,this.onlyEssence,this.childForum,this.topicList,);

  factory TopicsEntity.fromJson(Map<String, dynamic> srcJson) => _$TopicsEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicsEntityToJson(this);

}


@JsonSerializable()
class ChildForum extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  ChildForum(this.id,this.name,);

  factory ChildForum.fromJson(Map<String, dynamic> srcJson) => _$ChildForumFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChildForumToJson(this);

}


@JsonSerializable()
class TopicList extends Object {

  @JsonKey(name: 'topic_id')
  int topicId;

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

  @JsonKey(name: 'ctime', defaultValue: 0)
  int ctime;

  @JsonKey(name: 'mtime', defaultValue: 0)
  int mtime;

  @JsonKey(name: 'level')
  int level;

  @JsonKey(name: 'essence', defaultValue: 0)
  int essence;

  @JsonKey(name: 'forum_id')
  int forumId;

  @JsonKey(name: 'locked', defaultValue: 0)
  int locked;

  @JsonKey(name: 'review')
  int review;

  @JsonKey(name: 'forum_name')
  String forumName;

  @JsonKey(name: 'reply_count')
  int replyCount;

  @JsonKey(name: 'uinfo')
  Uinfo uinfo;

  @JsonKey(name: '_u_name', defaultValue: "-")
  String uName;

  @JsonKey(name: '_u_avatar', defaultValue: "https://hu60.cn/upload/default.jpg")
  String uAvatar;

  TopicList(this.topicId,this.id,this.contentId,this.title,this.readCount,this.uid,this.ctime,this.mtime,this.level,this.essence,this.forumId,this.locked,this.review,this.forumName,this.replyCount,this.uinfo,this.uName,this.uAvatar,);

  factory TopicList.fromJson(Map<String, dynamic> srcJson) => _$TopicListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicListToJson(this);

}


@JsonSerializable()
class Uinfo extends Object {

  @JsonKey(name: 'name')
  String name;

  Uinfo(this.name,);

  factory Uinfo.fromJson(Map<String, dynamic> srcJson) => _$UinfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UinfoToJson(this);

}


