import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  @JsonKey(name: 'doc_no')
  String docno;
  @JsonKey(name: 'doc_date')
  String docdate;
  @JsonKey(name: 'doc_time')
  String doctime;
  @JsonKey(name: 'wh_code')
  String whcode;
  @JsonKey(name: 'wh_name')
  String whname;
  @JsonKey(name: 'location_code')
  String locationcode;
  @JsonKey(name: 'location_name')
  String locationname;
  @JsonKey(name: 'creator_code')
  String creatorcode;
  @JsonKey(name: 'creator_name')
  String creatorname;
  @JsonKey(name: 'remark')
  String remark;
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'is_merge')
  int ismerge;
  @JsonKey(name: 'is_approve')
  int isapprove;
  @JsonKey(name: 'item_count')
  int itemcount;
  @JsonKey(name: 'approve_code')
  String approvecode;
  @JsonKey(name: 'approve_date_time')
  String approvedatetime;
  @JsonKey(name: 'create_datetime')
  String createdatetime;
  @JsonKey(name: 'carts')
  String carts;
  @JsonKey(name: 'doc_ref')
  String docref;

  CartModel({
    String? docno,
    String? docdate,
    String? doctime,
    String? whcode,
    String? whname,
    String? locationcode,
    String? locationname,
    String? creatorcode,
    String? creatorname,
    String? remark,
    int? status,
    int? ismerge,
    int? isapprove,
    int? itemcount,
    String? approvecode,
    String? approvedatetime,
    String? createdatetime,
    String? carts,
    String? docref,
  })  : docno = docno ?? '',
        docdate = docdate ?? '',
        doctime = doctime ?? '',
        whcode = whcode ?? '',
        whname = whname ?? '',
        locationcode = locationcode ?? '',
        locationname = locationname ?? '',
        creatorcode = creatorcode ?? '',
        creatorname = creatorname ?? '',
        remark = remark ?? '',
        status = status ?? 0,
        ismerge = ismerge ?? 0,
        isapprove = isapprove ?? 0,
        itemcount = itemcount ?? 0,
        approvecode = approvecode ?? '',
        approvedatetime = approvedatetime ?? '',
        createdatetime = createdatetime ?? '',
        carts = carts ?? '',
        docref = docref ?? '';

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}

@JsonSerializable()
class CartDetailModel {
  @JsonKey(name: 'doc_no')
  String docno;
  @JsonKey(name: 'barcode')
  String barcode;
  @JsonKey(name: 'item_code')
  String itemcode;
  @JsonKey(name: 'item_name')
  String itemname;
  @JsonKey(name: 'unit_code')
  String unitcode;
  @JsonKey(name: 'wh_code')
  String whcode;
  @JsonKey(name: 'location_code')
  String locationcode;
  @JsonKey(name: 'qty')
  int qty;
  @JsonKey(name: 'balance_qty')
  int balanceqty;
  @JsonKey(name: 'diff_qty')
  int diffqty;
  @JsonKey(name: 'is_approve')
  int isapprove;

  CartDetailModel({
    String? docno,
    String? barcode,
    String? itemcode,
    String? itemname,
    String? unitcode,
    String? whcode,
    String? locationcode,
    int? qty,
    int? balanceqty,
    int? diffqty,
    int? isapprove,
  })  : docno = docno ?? '',
        barcode = barcode ?? '',
        itemcode = itemcode ?? '',
        itemname = itemname ?? '',
        unitcode = unitcode ?? '',
        whcode = whcode ?? '',
        locationcode = locationcode ?? '',
        qty = qty ?? 0,
        balanceqty = balanceqty ?? 0,
        diffqty = diffqty ?? 0,
        isapprove = isapprove ?? 0;

  factory CartDetailModel.fromJson(Map<String, dynamic> json) => _$CartDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartDetailModelToJson(this);
}
