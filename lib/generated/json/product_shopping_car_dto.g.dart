import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';

import 'package:decimal/decimal.dart';


ProductShoppingCarDTO $ProductShoppingCarDTOFromJson(
    Map<String, dynamic> json) {
  final ProductShoppingCarDTO productShoppingCarDTO = ProductShoppingCarDTO();
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    productShoppingCarDTO.productId = productId;
  }
  final String? productName = jsonConvert.convert<String>(json['productName']);
  if (productName != null) {
    productShoppingCarDTO.productName = productName;
  }
  final String? productStandard = jsonConvert.convert<String>(
      json['productStandard']);
  if (productStandard != null) {
    productShoppingCarDTO.productStandard = productStandard;
  }
  final String? productPlace = jsonConvert.convert<String>(
      json['productPlace']);
  if (productPlace != null) {
    productShoppingCarDTO.productPlace = productPlace;
  }
  final UnitDetailDTO? unitDetailDTO = jsonConvert.convert<UnitDetailDTO>(
      json['unitDetailDTO']);
  if (unitDetailDTO != null) {
    productShoppingCarDTO.unitDetailDTO = unitDetailDTO;
  }
  return productShoppingCarDTO;
}

Map<String, dynamic> $ProductShoppingCarDTOToJson(
    ProductShoppingCarDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['productId'] = entity.productId;
  data['productName'] = entity.productName;
  data['productStandard'] = entity.productStandard;
  data['productPlace'] = entity.productPlace;
  data['unitDetailDTO'] = entity.unitDetailDTO?.toJson();
  return data;
}

extension ProductShoppingCarDTOExtension on ProductShoppingCarDTO {
  ProductShoppingCarDTO copyWith({
    int? productId,
    String? productName,
    String? productStandard,
    String? productPlace,
    UnitDetailDTO? unitDetailDTO,
  }) {
    return ProductShoppingCarDTO()
      ..productId = productId ?? this.productId
      ..productName = productName ?? this.productName
      ..productStandard = productStandard ?? this.productStandard
      ..productPlace = productPlace ?? this.productPlace
      ..unitDetailDTO = unitDetailDTO ?? this.unitDetailDTO;
  }
}