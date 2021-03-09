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

  UserEntity(
    this.uid,
    this.name,
    this.signature,
    this.contact,
    this.regtime,
    this.hasRegPhone,
    this.floorReverse,
    this.siteAdmin,
  );

  factory UserEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$UserEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
