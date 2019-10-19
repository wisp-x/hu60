import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable()
class Home extends Object {
  @JsonKey(name: 'userInfo')
  UserInfo userInfo;

  @JsonKey(name: 'newTopicList')
  List<NewTopicList> newTopicList;

  Home(
    this.userInfo,
    this.newTopicList,
  );

  factory Home.fromJson(Map<String, dynamic> srcJson) =>
      _$HomeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeToJson(this);
}

@JsonSerializable()
class UserInfo extends Object {
  UserInfo();

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class NewTopicList extends Object {
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

  @JsonKey(name: 'uinfo')
  Uinfo uinfo;

  @JsonKey(name: 'forum_name')
  String forumName;

  @JsonKey(name: 'reply_count')
  int replyCount;

  NewTopicList(
    this.topicId,
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
    this.uinfo,
    this.forumName,
    this.replyCount,
  );

  factory NewTopicList.fromJson(Map<String, dynamic> srcJson) =>
      _$NewTopicListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewTopicListToJson(this);
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
