import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/stock_change_record_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class StockChangeRecordDTO {
  int? ledgerId;
  int? userId;
  int? productId;
  String? productName;
  int? supplier;
  String? supplierName;
  String? productStandard;
  String? productPlace;
  int? salesChannel;
  String? adjustDate;
  int? unitType;
  int? unitId;
  String? unitName;
  int? masterUnitId;
  String? masterUnitName;
  int? slaveUnitId;
  String? slaveUnitName;
  Decimal? beforeStock;
  Decimal? beforeMasterStock;
  Decimal? beforeSlaveStock;
  Decimal? afterStock;
  Decimal? afterMasterStock;
  Decimal? afterSlaveStock;
  int? creator;
  String? creatorName;


  StockChangeRecordDTO();

  factory StockChangeRecordDTO.fromJson(Map<String, dynamic> json) =>
      $StockChangeRecordDTOFromJson(json);

  Map<String, dynamic> toJson() => $StockChangeRecordDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

}