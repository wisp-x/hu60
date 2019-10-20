import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login extends Object {

  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'sid')
  String sid;

  @JsonKey(name: 'page')
  String page;

  @JsonKey(name: 'notice')
  String notice;

  Login(this.success,this.sid,this.page,this.notice,);

  factory Login.fromJson(Map<String, dynamic> srcJson) => _$LoginFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginToJson(this);

}


