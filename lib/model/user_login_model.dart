import 'package:json_annotation/json_annotation.dart';

part 'user_login_model.g.dart';

@JsonSerializable()
class UserLoginModel {
  final String provider;

  @JsonKey(name: 'database_name')
  final String databasename;
  @JsonKey(name: 'user_code')
  final String usercode;
  @JsonKey(name: 'user_password')
  final String userpassword;

  UserLoginModel({required this.databasename, required this.provider, required this.usercode, required this.userpassword});

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => _$UserLoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserLoginModelToJson(this);
}
