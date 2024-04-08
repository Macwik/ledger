import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/product_sales_statistics_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class ProductSalesStatisticsDTO {

  int? id;
  int? ledgerId;
  int? unitType;
  int? unitId;
  String? unitName;
  int? masterUnitId;
  String? masterUnitName;
  int? slaveUnitId;
  String? slaveUnitName;
  Decimal? salesNumber;
  Decimal? salesMasterNumber;
  Decimal? salesSlaveNumber;
  Decimal? purchaseNumber;
  Decimal? purchaseMasterNumber;
  Decimal? purchaseSlaveNumber;
  Decimal? addStoreNumber;
  Decimal? addStoreMasterNumber;
  Decimal? addStoreSlaveNumber;
  Decimal? salesTotalAmount;
  Decimal? salesDiscountAmount;
  Decimal? salesRepaymentDiscountAmount;
  Decimal? salesCreditAmount;
  Decimal? purchaseTotalAmount;
  Decimal? purchaseDiscountAmount;
  Decimal? purchaseRepaymentDiscountAmount;
  Decimal? purchaseCreditAmount;
  Decimal? costTotalAmount;


  ProductSalesStatisticsDTO();

  factory ProductSalesStatisticsDTO.fromJson(Map<String, dynamic> json) =>
      $ProductSalesStatisticsDTOFromJson(json);

  Map<String, dynamic> toJson() => $ProductSalesStatisticsDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}