import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/sales_credit_statistics_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class SalesCreditStatisticsDTO {
  int? ledgerId;
  int? customId;
  String? customName;
  int? customType;
  int? creditType;
  int? orderId;
  Decimal? creditAmount;

  SalesCreditStatisticsDTO();

  factory SalesCreditStatisticsDTO.fromJson(Map<String, dynamic> json) =>
      $SalesCreditStatisticsDTOFromJson(json);

  Map<String, dynamic> toJson() => $SalesCreditStatisticsDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}