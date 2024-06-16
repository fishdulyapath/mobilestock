import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  @JsonKey(name: 'barcode')
  final String barcode;
  @JsonKey(name: 'item_code')
  final String itemcode;
  @JsonKey(name: 'item_name')
  final String itemname;
  @JsonKey(name: 'unit_code')
  final String unitcode;
  @JsonKey(name: 'balance_qty')
  String balanceqty;

  ItemModel({required this.barcode, required this.itemcode, required this.itemname, required this.unitcode, String? balanceqty}) : balanceqty = balanceqty ?? "0";

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}

@JsonSerializable()
class ItemScanModel {
  @JsonKey(name: 'barcode')
  String barcode;
  @JsonKey(name: 'item_code')
  String itemcode;
  @JsonKey(name: 'item_name')
  String itemname;
  @JsonKey(name: 'unit_code')
  String unitcode;
  @JsonKey(name: 'qty')
  int qty;
  @JsonKey(name: 'balance_qty')
  double balanceqty;
  @JsonKey(name: 'diff_qty')
  int diff;
  @JsonKey(name: 'is_approve')
  int isapprove;

  ItemScanModel({required this.barcode, required this.itemcode, required this.itemname, required this.unitcode, int? qty, double? balanceqty, int? diff, int? isapprove})
      : qty = qty ?? 0,
        balanceqty = balanceqty ?? 0,
        diff = diff ?? 0,
        isapprove = isapprove ?? 0;

  factory ItemScanModel.fromJson(Map<String, dynamic> json) => _$ItemScanModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemScanModelToJson(this);
}
