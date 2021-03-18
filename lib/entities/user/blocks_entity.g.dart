// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocks_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlocksEntity _$BlocksEntityFromJson(Map<String, dynamic> json) {
  return BlocksEntity(
    json['currPage'] as int,
    json['maxPage'] as int,
    (json['userList'] as List)
        ?.map((e) =>
            e == null ? null : UserList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BlocksEntityToJson(BlocksEntity instance) =>
    <String, dynamic>{
      'currPage': instance.currPage,
      'maxPage': instance.maxPage,
      'userList': instance.userList,
    };

UserList _$UserListFromJson(Map<String, dynamic> json) {
  return UserList(
    json['uid'] as int,
    json['name'] as String,
    json['avatar'] as String,
    json['_u_signature'] as String,
  );
}

Map<String, dynamic> _$UserListToJson(UserList instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'avatar': instance.avatar,
      '_u_signature': instance.uSignature,
    };
