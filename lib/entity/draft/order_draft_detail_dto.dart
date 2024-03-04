import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/entity/order/order_product_detail_dto.dart';
import 'package:ledger/generated/json/order_draft_detail_dto.g.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class OrderDraftDetailDTO {
  int? id;
  int? ledgerId;
  CustomDTO? customDTO;
  Decimal? totalAmount;
  String? batchNo;
  List<ProductShoppingCarDTO>? shoppingCarList;
  int? orderType;
  DateTime? orderDate;
  int? creator;
  String? creatorName;
  String? remark;
  DateTime? gmtCreate;

  OrderDraftDetailDTO();

  factory OrderDraftDetailDTO.fromJson(Map<String, dynamic> json) =>
      $OrderDraftDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => $OrderDraftDetailDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
