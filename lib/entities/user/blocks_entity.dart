import 'package:json_annotation/json_annotation.dart';

part 'blocks_entity.g.dart';

@JsonSerializable()
class BlocksEntity extends Object {
  @JsonKey(name: 'currPage')
  int currPage;

  @JsonKey(name: 'maxPage')
  int maxPage;

  @JsonKey(name: 'userList')
  List<UserList> userList;

  BlocksEntity(
    this.currPage,
    this.maxPage,
    this.userList,
  );

  factory BlocksEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$BlocksEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlocksEntityToJson(this);
}

@JsonSerializable()
class UserList extends Object {
  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: '_u_signature')
  String uSignature;

  UserList(
    this.uid,
    this.name,
    this.avatar,
    this.uSignature,
  );

  factory UserList.fromJson(Map<String, dynamic> srcJson) =>
      _$UserListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserListToJson(this);
}
