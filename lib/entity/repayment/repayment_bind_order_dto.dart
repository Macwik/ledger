import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/repayment_bind_order_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class RepaymentBindOrderDTO {
  int? id;
  int? customCreditId;
  Decimal? creditAmount;
  int? creditType;
  int? salesOrderId;
  Decimal? repaymentAmount;
  List<int>? productIdList;
  List<String>? productNameList;
  DateTime? creditDate;
  int? creator;
  String? creatorName;
  DateTime? gmtCreate;

  RepaymentBindOrderDTO();

  factory RepaymentBindOrderDTO.fromJson(Map<String, dynamic> json) =>
      $RepaymentBindOrderDTOFromJson(json);

  Map<String, dynamic> toJson() => $RepaymentBindOrderDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}