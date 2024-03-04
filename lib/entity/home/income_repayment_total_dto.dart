import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/income_repayment_total_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class IncomeRepaymentTotalDTO {
  Decimal? totalIncomeAmount;
  Decimal? totalCreditAmount;
  Decimal? totalRepaymentAmount;

  IncomeRepaymentTotalDTO();

  factory IncomeRepaymentTotalDTO.fromJson(Map<String, dynamic> json) =>
      $IncomeRepaymentTotalDTOFromJson(json);

  Map<String, dynamic> toJson() => $IncomeRepaymentTotalDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}