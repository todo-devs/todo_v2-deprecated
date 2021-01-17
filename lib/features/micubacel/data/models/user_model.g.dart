// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as int,
    name: json['name'] as String,
    phone: json['phone'] as String,
    password: json['password'] as String,
    active: UserModel._activeFromJson(json['active']),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'password': instance.password,
      'active': UserModel._activeToJson(instance.active),
    };
