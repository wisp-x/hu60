import 'package:json_annotation/json_annotation.dart';

part 'user_info_entity.g.dart';

@JsonSerializable()
class UserInfoEntity extends Object {
  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'signature', defaultValue: "-")
  String signature;

  @JsonKey(name: 'contact', defaultValue: "-")
  String contact;

  @JsonKey(name: 'regtime')
  int regtime;

  @JsonKey(name: 'blockPostStat')
  bool blockPostStat;

  @JsonKey(name: 'isFollow')
  bool isFollow;

  @JsonKey(name: 'isBlock')
  bool isBlock;

  @JsonKey(name: 'hideUserCSS')
  bool hideUserCSS;

  @JsonKey(name: 'permissions')
  List<String> permissions;

  @JsonKey(name: '_u_avatar')
  String uAvatar;

  UserInfoEntity(
    this.uid,
    this.name,
    this.signature,
    this.contact,
    this.regtime,
    this.blockPostStat,
    this.isFollow,
    this.isBlock,
    this.hideUserCSS,
    this.permissions,
    this.uAvatar,
  );

  factory UserInfoEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoEntityToJson(this);
}
