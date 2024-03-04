import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/product_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'dart:convert';

@JsonSerializable()
class ProductDTO {
  int? id;
  int? ledgerId;
  String? productName;
  String? productStandard;
  String? productPlace;
  int? productClassify;
  UnitDetailDTO? unitDetailDTO;
  int? supplier;
  String? supplierName;
  int? salesChannel;
  int? productStatus;
  int? invalid;
  int? used;


  ProductDTO();

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      $ProductDTOFromJson(json);

  Map<String, dynamic> toJson() => $ProductDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
