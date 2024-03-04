import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/product/product_create_dto.dart';

ProductCreateDTO $ProductCreateDTOFromJson(Map<String, dynamic> json) {
  final ProductCreateDTO productCreateDTO = ProductCreateDTO();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    productCreateDTO.ledgerId = ledgerId;
  }
  final int? productType = jsonConvert.convert<int>(json['productType']);
  if (productType != null) {
    productCreateDTO.productType = productType;
  }
  final String? productName = jsonConvert.convert<String>(json['productName']);
  if (productName != null) {
    productCreateDTO.productName = productName;
  }
  final String? productStandard = jsonConvert.convert<String>(
      json['productStandard']);
  if (productStandard != null) {
    productCreateDTO.productStandard = productStandard;
  }
  final String? productPlace = jsonConvert.convert<String>(
      json['productPlace']);
  if (productPlace != null) {
    productCreateDTO.productPlace = productPlace;
  }
  final bool? multiUnit = jsonConvert.convert<bool>(json['multiUnit']);
  if (multiUnit != null) {
    productCreateDTO.multiUnit = multiUnit;
  }
  final int? unitGroup = jsonConvert.convert<int>(json['unitGroup']);
  if (unitGroup != null) {
    productCreateDTO.unitGroup = unitGroup;
  }
  final int? unit = jsonConvert.convert<int>(json['unit']);
  if (unit != null) {
    productCreateDTO.unit = unit;
  }
  final int? price = jsonConvert.convert<int>(json['price']);
  if (price != null) {
    productCreateDTO.price = price;
  }
  final String? unitName = jsonConvert.convert<String>(json['unitName']);
  if (unitName != null) {
    productCreateDTO.unitName = unitName;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    productCreateDTO.remark = remark;
  }
  final int? supplier = jsonConvert.convert<int>(json['supplier']);
  if (supplier != null) {
    productCreateDTO.supplier = supplier;
  }
  final int? productSource = jsonConvert.convert<int>(json['productSource']);
  if (productSource != null) {
    productCreateDTO.productSource = productSource;
  }
  return productCreateDTO;
}

Map<String, dynamic> $ProductCreateDTOToJson(ProductCreateDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['productType'] = entity.productType;
  data['productName'] = entity.productName;
  data['productStandard'] = entity.productStandard;
  data['productPlace'] = entity.productPlace;
  data['multiUnit'] = entity.multiUnit;
  data['unitGroup'] = entity.unitGroup;
  data['unit'] = entity.unit;
  data['price'] = entity.price;
  data['unitName'] = entity.unitName;
  data['remark'] = entity.remark;
  data['supplier'] = entity.supplier;
  data['productSource'] = entity.productSource;
  return data;
}

extension ProductCreateDTOExtension on ProductCreateDTO {
  ProductCreateDTO copyWith({
    int? ledgerId,
    int? productType,
    String? productName,
    String? productStandard,
    String? productPlace,
    bool? multiUnit,
    int? unitGroup,
    int? unit,
    int? price,
    String? unitName,
    String? remark,
    int? supplier,
    int? productSource,
  }) {
    return ProductCreateDTO()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..productType = productType ?? this.productType
      ..productName = productName ?? this.productName
      ..productStandard = productStandard ?? this.productStandard
      ..productPlace = productPlace ?? this.productPlace
      ..multiUnit = multiUnit ?? this.multiUnit
      ..unitGroup = unitGroup ?? this.unitGroup
      ..unit = unit ?? this.unit
      ..price = price ?? this.price
      ..unitName = unitName ?? this.unitName
      ..remark = remark ?? this.remark
      ..supplier = supplier ?? this.supplier
      ..productSource = productSource ?? this.productSource;
  }
}