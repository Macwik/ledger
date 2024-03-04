import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/home_statistics_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class HomeStatisticsDTO {
  Decimal? totalSalesAmount;
  Decimal? totalCostAmount;
  Decimal? totalIncomeAmount;
  Decimal? totalCreditAmount;
  Decimal? totalRepaymentAmount;

  HomeStatisticsDTO();

  factory HomeStatisticsDTO.fromJson(Map<String, dynamic> json) =>
      $HomeStatisticsDTOFromJson(json);

  Map<String, dynamic> toJson() => $HomeStatisticsDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}