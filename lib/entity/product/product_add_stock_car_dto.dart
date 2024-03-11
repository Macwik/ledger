import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/product_add_stock_car_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class ProductAddStockCarDTO {
  int? productId;
  String? productName;
  String? productStandard;
  String? productPlace;
  int? unitType;
  int? unitGroupId;
  int? unitId;
  String? unitName;
  bool? selectMasterUnit;
  int? masterUnitId;
  String? masterUnitName;
  int? slaveUnitId;
  String? slaveUnitName;
  Decimal? number;
  Decimal? masterNumber;
  Decimal? slaveNumber;
  Decimal? conversion;

  ProductAddStockCarDTO(
      {this.productId,
      this.productName,
      this.productPlace,
      this.productStandard,
        this.unitType,
        this.unitGroupId,
        this.unitId,
        this.unitName,
        this.selectMasterUnit,
        this.masterUnitId,
        this.masterUnitName,
        this.slaveUnitId,
        this.slaveUnitName,
        this.number,
        this.masterNumber,
        this.slaveNumber,
        this.conversion});

  factory ProductAddStockCarDTO.fromJson(Map<String, dynamic> json) =>
      $ProductAddStockCarDTOFromJson(json);

  Map<String, dynamic> toJson() => $ProductAddStockCarDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
