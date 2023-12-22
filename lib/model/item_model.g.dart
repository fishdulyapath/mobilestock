// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      barcode: json['barcode'] as String,
      itemcode: json['item_code'] as String,
      itemname: json['item_name'] as String,
      unitcode: json['unit_code'] as String,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'barcode': instance.barcode,
      'item_code': instance.itemcode,
      'item_name': instance.itemname,
      'unit_code': instance.unitcode,
    };

ItemScanModel _$ItemScanModelFromJson(Map<String, dynamic> json) =>
    ItemScanModel(
      barcode: json['barcode'] as String,
      itemcode: json['item_code'] as String,
      itemname: json['item_name'] as String,
      unitcode: json['unit_code'] as String,
      qty: json['qty'] as int?,
      balanceqty: json['balance_qty'] as int?,
      diff: json['diff_qty'] as int?,
      isapprove: json['is_approve'] as int?,
    );

Map<String, dynamic> _$ItemScanModelToJson(ItemScanModel instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'item_code': instance.itemcode,
      'item_name': instance.itemname,
      'unit_code': instance.unitcode,
      'qty': instance.qty,
      'balance_qty': instance.balanceqty,
      'diff_qty': instance.diff,
      'is_approve': instance.isapprove,
    };
