// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_select_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSelectModel _$PostSelectModelFromJson(Map<String, dynamic> json) =>
    PostSelectModel(
      provider: json['provider'] as String,
      database: json['database'] as String,
      query: json['query'] as String,
    );

Map<String, dynamic> _$PostSelectModelToJson(PostSelectModel instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'database': instance.database,
      'query': instance.query,
    };
