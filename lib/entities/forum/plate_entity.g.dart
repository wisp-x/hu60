// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plate_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlateEntity _$PlateEntityFromJson(Map<String, dynamic> json) {
  return PlateEntity(
    json['isLogin'] as bool,
    (json['forums'] as List)
        ?.map((e) =>
            e == null ? null : Forums.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlateEntityToJson(PlateEntity instance) =>
    <String, dynamic>{
      'isLogin': instance.isLogin,
      'forums': instance.forums,
    };

Forums _$ForumsFromJson(Map<String, dynamic> json) {
  return Forums(
    json['id'] as int,
    json['name'] as String,
    json['notopic'] as int,
    (json['child'] as List)
        ?.map(
            (e) => e == null ? null : Child.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ForumsToJson(Forums instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'notopic': instance.notopic,
      'child': instance.child,
    };

Child _$ChildFromJson(Map<String, dynamic> json) {
  return Child(
    json['id'] as int,
    json['name'] as String,
    json['notopic'] as int,
    json['child'] as List,
  );
}

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'notopic': instance.notopic,
      'child': instance.child,
    };
