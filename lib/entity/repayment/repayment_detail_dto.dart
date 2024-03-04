import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/repayment_detail_dto.g.dart';
import 'package:ledger/entity/order/order_payment_dto.dart';
import 'package:ledger/entity/repayment/repayment_bind_order_dto.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class RepaymentDetailDTO {
  int? ledgerId;
  int? customId;
  String? customName;
  DateTime? repaymentDate;
  int? settlementType;
  List<RepaymentBindOrderDTO>? repaymentBindOrderList;
  List<OrderPaymentDTO>? paymentDTOList;
  Decimal? totalAmount;
  Decimal? discountAmount;
  int? creator;
  String? creatorName;
  int? invalid;
  String? remark;


  RepaymentDetailDTO();

  factory RepaymentDetailDTO.fromJson(Map<String, dynamic> json) =>
      $RepaymentDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => $RepaymentDetailDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}