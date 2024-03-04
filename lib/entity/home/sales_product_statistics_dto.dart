import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/sales_product_statistics_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class SalesProductStatisticsDTO {
  int? ledgerId;
  int? productId;
  String? productName;
  int? unitType;
  int? unitGroupId;
  int? unitId;
  String? unitName;
  int? masterUnitId;
  String? masterUnitName;
  int? slaveUnitId;
  String? slaveUnitName;
  Decimal? number;
  Decimal? masterNumber;
  Decimal? slaveNumber;
  Decimal? totalAmount;
  Decimal? creditAmount;
  Decimal? discountAmount;

  SalesProductStatisticsDTO();

  factory SalesProductStatisticsDTO.fromJson(Map<String, dynamic> json) =>
      $SalesProductStatisticsDTOFromJson(json);

  Map<String, dynamic> toJson() => $SalesProductStatisticsDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}