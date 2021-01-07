// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ussd_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UssdCodeModel _$UssdCodeModelFromJson(Map<String, dynamic> json) {
  return UssdCodeModel(
    name: json['name'] as String,
    description: json['description'] as String,
    icon: json['icon'] as String,
    type: json['type'] as String,
    code: json['code'] as String,
    fields: UssdCodeModel._fieldsFromJson(json['fields'] as List),
  );
}

Map<String, dynamic> _$UssdCodeModelToJson(UssdCodeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'type': instance.type,
      'code': instance.code,
      'fields': UssdCodeModel._fieldsToJson(instance.fields),
    };
