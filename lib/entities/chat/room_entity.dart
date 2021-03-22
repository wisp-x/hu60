import 'package:json_annotation/json_annotation.dart';

part 'room_entity.g.dart';

@JsonSerializable()
class RoomEntity extends Object {
  @JsonKey(name: 'chatRomName')
  String chatRomName;

  @JsonKey(name: 'isLogin')
  bool isLogin;

  @JsonKey(name: 'chatCount')
  int chatCount;

  @JsonKey(name: 'currPage')
  int currPage;

  @JsonKey(name: 'maxPage')
  int maxPage;

  @JsonKey(name: 'chatList')
  List<ChatList> chatList;

  @JsonKey(name: 'blockedReply')
  int blockedReply;

  @JsonKey(name: 'token')
  String token;

  RoomEntity(
    this.chatRomName,
    this.isLogin,
    this.chatCount,
    this.currPage,
    this.maxPage,
    this.chatList,
    this.blockedReply,
    this.token,
  );

  factory RoomEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$RoomEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RoomEntityToJson(this);
}

@JsonSerializable()
class ChatList extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'room')
  String room;

  @JsonKey(name: 'lid')
  int lid;

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'time')
  int time;

  @JsonKey(name: 'hidden')
  int hidden;

  @JsonKey(name: 'review')
  int review;

  @JsonKey(name: 'uinfo')
  Uinfo uinfo;

  @JsonKey(name: 'canDel')
  bool canDel;

  @JsonKey(name: '_u_avatar')
  String uAvatar;

  ChatList(
    this.id,
    this.room,
    this.lid,
    this.uid,
    this.content,
    this.time,
    this.hidden,
    this.review,
    this.uinfo,
    this.canDel,
    this.uAvatar,
  );

  factory ChatList.fromJson(Map<String, dynamic> srcJson) =>
      _$ChatListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChatListToJson(this);
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
