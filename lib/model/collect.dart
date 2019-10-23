import 'package:json_annotation/json_annotation.dart';

part 'collect.g.dart';


@JsonSerializable()
class Collect extends Object {

  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'notice')
  String notice;

  Collect(this.success,this.notice,);

  factory Collect.fromJson(Map<String, dynamic> srcJson) => _$CollectFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CollectToJson(this);

}


