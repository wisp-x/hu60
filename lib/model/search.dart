import 'package:json_annotation/json_annotation.dart';

part 'search.g.dart';


@JsonSerializable()
class Search extends Object {

  @JsonKey(name: 'topicCount')
  int topicCount;

  @JsonKey(name: 'maxPage')
  int maxPage;

  @JsonKey(name: 'topicList')
  List<TopicList> topicList;

  Search(this.topicCount,this.maxPage,this.topicList,);

  factory Search.fromJson(Map<String, dynamic> srcJson) => _$SearchFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchToJson(this);

}


@JsonSerializable()
class TopicList extends Object {

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

  @JsonKey(name: 'forum_name')
  String forumName;

  @JsonKey(name: 'reply_count')
  int replyCount;

  @JsonKey(name: 'uinfo')
  Uinfo uinfo;

  TopicList(this.id,this.contentId,this.title,this.readCount,this.uid,this.ctime,this.mtime,this.level,this.essence,this.forumId,this.locked,this.forumName,this.replyCount,this.uinfo,);

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


