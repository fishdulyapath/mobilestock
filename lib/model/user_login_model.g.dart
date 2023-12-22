// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginModel _$UserLoginModelFromJson(Map<String, dynamic> json) =>
    UserLoginModel(
      databasename: json['database_name'] as String,
      provider: json['provider'] as String,
      user: json['user'] as String,
      pass: json['pass'] as String,
    );

Map<String, dynamic> _$UserLoginModelToJson(UserLoginModel instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'database_name': instance.databasename,
      'user': instance.user,
      'pass': instance.pass,
    };
