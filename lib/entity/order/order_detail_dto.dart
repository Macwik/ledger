import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/order_detail_dto.g.dart';
import 'package:ledger/entity/order/order_payment_dto.dart';
import 'package:ledger/entity/order/order_product_detail_dto.dart';
import 'package:ledger/entity/statistics/external_order_base_dto.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class  OrderDetailDTO {
  int? id;
  String? orderNo;
  int? ledgerId;
  int? customId;
  String? customName;
  Decimal? totalAmount;
  Decimal? creditAmount;
  Decimal? discountAmount;
  String? batchNo;
  List<OrderProductDetail>? orderProductDetailList;
  List<OrderPaymentDTO>? orderPaymentList;
  DateTime? orderDate;
  int? orderStatus;
  int? invalid;
  int? orderType;
  int? creator;
  String? creatorName;
  String? remark;
  DateTime? gmtCreate;
  List<ExternalOrderBaseDTO>? externalOrderBaseDTOList;

  OrderDetailDTO();

  factory OrderDetailDTO.fromJson(Map<String, dynamic> json) =>
      $OrderDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => $OrderDetailDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
