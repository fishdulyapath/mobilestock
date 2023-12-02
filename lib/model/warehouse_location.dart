import 'package:json_annotation/json_annotation.dart';

part 'warehouse_location.g.dart';

@JsonSerializable()
class WarehouseModel {
  final String code;
  final String name;

  WarehouseModel({String? code, String? name})
      : code = code ?? '',
        name = name ?? '';

  factory WarehouseModel.fromJson(Map<String, dynamic> json) => _$WarehouseModelFromJson(json);
  Map<String, dynamic> toJson() => _$WarehouseModelToJson(this);
}

@JsonSerializable()
class LocationModel {
  final String code;
  final String name;

  LocationModel({String? code, String? name})
      : code = code ?? '',
        name = name ?? '';

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
