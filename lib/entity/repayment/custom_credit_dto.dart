import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/custom_credit_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()//也是欠款情况统计
class CustomCreditDTO {
  int? id;
  int? ledgerId;
  int? customId;
  int? customType;
  int? creditType;
  DateTime? creditDate;
  String? customName;
  int? orderId;
  List<String>? productNameList;
  Decimal? creditAmount;
  Decimal? repaymentAmount;
  int? creator;
  String? creatorName;
  DateTime? gmtCreate;

  CustomCreditDTO();

  factory CustomCreditDTO.fromJson(Map<String, dynamic> json) =>
      $CustomCreditDTOFromJson(json);

  Map<String, dynamic> toJson() => $CustomCreditDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

}