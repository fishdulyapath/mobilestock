import 'package:json_annotation/json_annotation.dart';

part 'post_select_model.g.dart';

@JsonSerializable()
class PostSelectModel {
  @JsonKey(name: 'provider')
  final String provider;
  @JsonKey(name: 'database')
  final String database;
  @JsonKey(name: 'query')
  final String query;

  PostSelectModel({required this.provider, required this.database, required this.query});

  factory PostSelectModel.fromJson(Map<String, dynamic> json) => _$PostSelectModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostSelectModelToJson(this);
}
