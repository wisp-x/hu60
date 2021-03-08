import 'package:json_annotation/json_annotation.dart';

part 'plate_entity.g.dart';


@JsonSerializable()
class PlateEntity extends Object {

  @JsonKey(name: 'isLogin')
  bool isLogin;

  @JsonKey(name: 'forums')
  List<Forums> forums;

  PlateEntity(this.isLogin,this.forums,);

  factory PlateEntity.fromJson(Map<String, dynamic> srcJson) => _$PlateEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PlateEntityToJson(this);

}


@JsonSerializable()
class Forums extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'notopic')
  int notopic;

  @JsonKey(name: 'child')
  List<Child> child;

  Forums(this.id,this.name,this.notopic,this.child,);

  factory Forums.fromJson(Map<String, dynamic> srcJson) => _$ForumsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ForumsToJson(this);

}


@JsonSerializable()
class Child extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'notopic')
  int notopic;

  @JsonKey(name: 'child')
  List<dynamic> child;

  Child(this.id,this.name,this.notopic,this.child,);

  factory Child.fromJson(Map<String, dynamic> srcJson) => _$ChildFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChildToJson(this);

}


