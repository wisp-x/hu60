import 'package:json_annotation/json_annotation.dart';

part 'rooms_entity.g.dart';

@JsonSerializable()
class RoomsEntity extends Object {
  @JsonKey(name: 'chatRomList')
  List<ChatRomList> chatRomList;

  RoomsEntity(
    this.chatRomList,
  );

  factory RoomsEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$RoomsEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RoomsEntityToJson(this);
}

@JsonSerializable()
class ChatRomList extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'ztime')
  int ztime;

  ChatRomList(
    this.id,
    this.name,
    this.ztime,
  );

  factory ChatRomList.fromJson(Map<String, dynamic> srcJson) =>
      _$ChatRomListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChatRomListToJson(this);
}
