import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/sales_repayment_statistics_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class SalesRepaymentStatisticsDTO {
  int? ledgerId;
  int? customId;
  String? customName;
  int? customType;
  Decimal? totalAmount;
  Decimal? discountAmount;

  SalesRepaymentStatisticsDTO();

  factory SalesRepaymentStatisticsDTO.fromJson(Map<String, dynamic> json) =>
      $SalesRepaymentStatisticsDTOFromJson(json);

  Map<String, dynamic> toJson() => $SalesRepaymentStatisticsDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}