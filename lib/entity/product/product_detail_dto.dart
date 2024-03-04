import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/generated/json/product_detail_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class ProductDetailDTO {
  int? id;
  int? ledgerId;
  int? productType;
  String? productTypeDesc;
  String? productName;
  String? productStandard;
  String? productPlace;
  int? productClassify;//分类的ID
  String? productClassifyName;
  UnitDetailDTO? unitDetailDTO;
  int? invalid;
  String? remark;
  int? supplier;
  String? supplierName;
  int? salesChannel;
  int? creator;

  ProductDetailDTO();

  factory ProductDetailDTO.fromJson(Map<String, dynamic> json) =>
      $ProductDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => $ProductDetailDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}