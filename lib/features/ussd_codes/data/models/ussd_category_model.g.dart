// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ussd_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UssdCategoryModel _$UssdCategoryModelFromJson(Map<String, dynamic> json) {
  return UssdCategoryModel(
    name: json['name'] as String,
    description: json['description'] as String,
    icon: json['icon'] as String,
    type: json['type'] as String,
    items: UssdCategoryModel._fieldsFromJson(json['items'] as List),
  );
}

Map<String, dynamic> _$UssdCategoryModelToJson(UssdCategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'type': instance.type,
      'items': UssdCategoryModel._fieldsToJson(instance.items),
    };
