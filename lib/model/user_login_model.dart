import 'package:json_annotation/json_annotation.dart';

part 'user_login_model.g.dart';

@JsonSerializable()
class UserLoginModel {
  final String provider;

  @JsonKey(name: 'database_name')
  final String databasename;
  @JsonKey(name: 'user')
  final String user;
  @JsonKey(name: 'pass')
  final String pass;

  UserLoginModel({required this.databasename, required this.provider, required this.user, required this.pass});

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => _$UserLoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserLoginModelToJson(this);
}
