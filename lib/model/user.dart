import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';


@JsonSerializable()
class User extends Object {

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'mail')
  String mail;

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

  User(this.uid,this.name,this.mail,this.signature,this.contact,this.regtime,this.hasRegPhone,this.floorReverse,this.siteAdmin,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}
