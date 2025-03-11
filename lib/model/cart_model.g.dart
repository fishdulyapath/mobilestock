// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      docno: json['doc_no'] as String?,
      docdate: json['doc_date'] as String?,
      doctime: json['doc_time'] as String?,
      whcode: json['wh_code'] as String?,
      whname: json['wh_name'] as String?,
      locationcode: json['location_code'] as String?,
      locationname: json['location_name'] as String?,
      creatorcode: json['creator_code'] as String?,
      creatorname: json['creator_name'] as String?,
      remark: json['remark'] as String?,
      status: (json['status'] as num?)?.toInt(),
      ismerge: (json['is_merge'] as num?)?.toInt(),
      isapprove: (json['is_approve'] as num?)?.toInt(),
      itemcount: (json['item_count'] as num?)?.toInt(),
      approvecode: json['approve_code'] as String?,
      approvedatetime: json['approve_date_time'] as String?,
      createdatetime: json['create_datetime'] as String?,
      carts: json['carts'] as String?,
      docref: json['doc_ref'] as String?,
      isnostock: (json['is_no_stock'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'doc_no': instance.docno,
      'doc_date': instance.docdate,
      'doc_time': instance.doctime,
      'wh_code': instance.whcode,
      'wh_name': instance.whname,
      'location_code': instance.locationcode,
      'location_name': instance.locationname,
      'creator_code': instance.creatorcode,
      'creator_name': instance.creatorname,
      'remark': instance.remark,
      'status': instance.status,
      'is_merge': instance.ismerge,
      'is_approve': instance.isapprove,
      'item_count': instance.itemcount,
      'approve_code': instance.approvecode,
      'approve_date_time': instance.approvedatetime,
      'create_datetime': instance.createdatetime,
      'carts': instance.carts,
      'doc_ref': instance.docref,
      'is_no_stock': instance.isnostock,
    };

CartDetailModel _$CartDetailModelFromJson(Map<String, dynamic> json) =>
    CartDetailModel(
      docno: json['doc_no'] as String?,
      barcode: json['barcode'] as String?,
      itemcode: json['item_code'] as String?,
      itemname: json['item_name'] as String?,
      unitcode: json['unit_code'] as String?,
      whcode: json['wh_code'] as String?,
      locationcode: json['location_code'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      balanceqty: (json['balance_qty'] as num?)?.toInt(),
      diffqty: (json['diff_qty'] as num?)?.toInt(),
      isapprove: (json['is_approve'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartDetailModelToJson(CartDetailModel instance) =>
    <String, dynamic>{
      'doc_no': instance.docno,
      'barcode': instance.barcode,
      'item_code': instance.itemcode,
      'item_name': instance.itemname,
      'unit_code': instance.unitcode,
      'wh_code': instance.whcode,
      'location_code': instance.locationcode,
      'qty': instance.qty,
      'balance_qty': instance.balanceqty,
      'diff_qty': instance.diffqty,
      'is_approve': instance.isapprove,
    };
