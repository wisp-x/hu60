import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends Object {
  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'signature')
  String signature;

  @JsonKey(name: 'contact')
  String contact;

  @JsonKey(name: 'regtime')
  int regtime;

  @JsonKey(name: 'hasRegPhone')
  bool hasRegPhone;

  @JsonKey(name: 'floorReverse')
  bool floorReverse;

  @JsonKey(name: 'siteAdmin')
  bool siteAdmin;

  @JsonKey(name: 'permissions')
  List<dynamic> permissions;

  @JsonKey(name: '_myself')
  _myself myself;

  @JsonKey(name: '_u_avatar')
  String uAvatar;

  UserEntity(
    this.uid,
    this.name,
    this.signature,
    this.contact,
    this.regtime,
    this.hasRegPhone,
    this.floorReverse,
    this.siteAdmin,
    this.permissions,
    this.myself,
    this.uAvatar,
  );

  factory UserEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$UserEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

@JsonSerializable()
class _myself extends Object {
  @JsonKey(name: 'isLogin')
  bool isLogin;

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'newMsg')
  int newMsg;

  @JsonKey(name: 'newAtInfo')
  int newAtInfo;

  @JsonKey(name: '_u_avatar')
  String uAvatar;

  _myself(
    this.isLogin,
    this.uid,
    this.newMsg,
    this.newAtInfo,
    this.uAvatar,
  );

  factory _myself.fromJson(Map<String, dynamic> srcJson) =>
      _$_myselfFromJson(srcJson);

  Map<String, dynamic> toJson() => _$_myselfToJson(this);
}
