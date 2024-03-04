import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:decimal/decimal.dart';

import 'package:ledger/entity/unit/unit_detail_dto.dart';


ProductDTO $ProductDTOFromJson(Map<String, dynamic> json) {
  final ProductDTO productDTO = ProductDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    productDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    productDTO.ledgerId = ledgerId;
  }
  final String? productName = jsonConvert.convert<String>(json['productName']);
  if (productName != null) {
    productDTO.productName = productName;
  }
  final String? productStandard = jsonConvert.convert<String>(
      json['productStandard']);
  if (productStandard != null) {
    productDTO.productStandard = productStandard;
  }
  final String? productPlace = jsonConvert.convert<String>(
      json['productPlace']);
  if (productPlace != null) {
    productDTO.productPlace = productPlace;
  }
  final int? productClassify = jsonConvert.convert<int>(
      json['productClassify']);
  if (productClassify != null) {
    productDTO.productClassify = productClassify;
  }
  final UnitDetailDTO? unitDetailDTO = jsonConvert.convert<UnitDetailDTO>(
      json['unitDetailDTO']);
  if (unitDetailDTO != null) {
    productDTO.unitDetailDTO = unitDetailDTO;
  }
  final int? supplier = jsonConvert.convert<int>(json['supplier']);
  if (supplier != null) {
    productDTO.supplier = supplier;
  }
  final String? supplierName = jsonConvert.convert<String>(
      json['supplierName']);
  if (supplierName != null) {
    productDTO.supplierName = supplierName;
  }
  final int? salesChannel = jsonConvert.convert<int>(json['salesChannel']);
  if (salesChannel != null) {
    productDTO.salesChannel = salesChannel;
  }
  final int? productStatus = jsonConvert.convert<int>(json['productStatus']);
  if (productStatus != null) {
    productDTO.productStatus = productStatus;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    productDTO.invalid = invalid;
  }
  final int? used = jsonConvert.convert<int>(json['used']);
  if (used != null) {
    productDTO.used = used;
  }
  return productDTO;
}

Map<String, dynamic> $ProductDTOToJson(ProductDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['productName'] = entity.productName;
  data['productStandard'] = entity.productStandard;
  data['productPlace'] = entity.productPlace;
  data['productClassify'] = entity.productClassify;
  data['unitDetailDTO'] = entity.unitDetailDTO?.toJson();
  data['supplier'] = entity.supplier;
  data['supplierName'] = entity.supplierName;
  data['salesChannel'] = entity.salesChannel;
  data['productStatus'] = entity.productStatus;
  data['invalid'] = entity.invalid;
  data['used'] = entity.used;
  return data;
}

extension ProductDTOExtension on ProductDTO {
  ProductDTO copyWith({
    int? id,
    int? ledgerId,
    String? productName,
    String? productStandard,
    String? productPlace,
    int? productClassify,
    UnitDetailDTO? unitDetailDTO,
    int? supplier,
    String? supplierName,
    int? salesChannel,
    int? productStatus,
    int? invalid,
    int? used,
  }) {
    return ProductDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..productName = productName ?? this.productName
      ..productStandard = productStandard ?? this.productStandard
      ..productPlace = productPlace ?? this.productPlace
      ..productClassify = productClassify ?? this.productClassify
      ..unitDetailDTO = unitDetailDTO ?? this.unitDetailDTO
      ..supplier = supplier ?? this.supplier
      ..supplierName = supplierName ?? this.supplierName
      ..salesChannel = salesChannel ?? this.salesChannel
      ..productStatus = productStatus ?? this.productStatus
      ..invalid = invalid ?? this.invalid
      ..used = used ?? this.used;
  }
}