import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/product/product_detail_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';


ProductDetailDTO $ProductDetailDTOFromJson(Map<String, dynamic> json) {
  final ProductDetailDTO productDetailDTO = ProductDetailDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    productDetailDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    productDetailDTO.ledgerId = ledgerId;
  }
  final int? productType = jsonConvert.convert<int>(json['productType']);
  if (productType != null) {
    productDetailDTO.productType = productType;
  }
  final String? productTypeDesc = jsonConvert.convert<String>(
      json['productTypeDesc']);
  if (productTypeDesc != null) {
    productDetailDTO.productTypeDesc = productTypeDesc;
  }
  final String? productName = jsonConvert.convert<String>(json['productName']);
  if (productName != null) {
    productDetailDTO.productName = productName;
  }
  final String? productStandard = jsonConvert.convert<String>(
      json['productStandard']);
  if (productStandard != null) {
    productDetailDTO.productStandard = productStandard;
  }
  final String? productPlace = jsonConvert.convert<String>(
      json['productPlace']);
  if (productPlace != null) {
    productDetailDTO.productPlace = productPlace;
  }
  final int? productClassify = jsonConvert.convert<int>(
      json['productClassify']);
  if (productClassify != null) {
    productDetailDTO.productClassify = productClassify;
  }
  final String? productClassifyName = jsonConvert.convert<String>(
      json['productClassifyName']);
  if (productClassifyName != null) {
    productDetailDTO.productClassifyName = productClassifyName;
  }
  final UnitDetailDTO? unitDetailDTO = jsonConvert.convert<UnitDetailDTO>(
      json['unitDetailDTO']);
  if (unitDetailDTO != null) {
    productDetailDTO.unitDetailDTO = unitDetailDTO;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    productDetailDTO.invalid = invalid;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    productDetailDTO.remark = remark;
  }
  final int? supplier = jsonConvert.convert<int>(json['supplier']);
  if (supplier != null) {
    productDetailDTO.supplier = supplier;
  }
  final String? supplierName = jsonConvert.convert<String>(
      json['supplierName']);
  if (supplierName != null) {
    productDetailDTO.supplierName = supplierName;
  }
  final int? salesChannel = jsonConvert.convert<int>(json['salesChannel']);
  if (salesChannel != null) {
    productDetailDTO.salesChannel = salesChannel;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    productDetailDTO.creator = creator;
  }
  return productDetailDTO;
}

Map<String, dynamic> $ProductDetailDTOToJson(ProductDetailDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['productType'] = entity.productType;
  data['productTypeDesc'] = entity.productTypeDesc;
  data['productName'] = entity.productName;
  data['productStandard'] = entity.productStandard;
  data['productPlace'] = entity.productPlace;
  data['productClassify'] = entity.productClassify;
  data['productClassifyName'] = entity.productClassifyName;
  data['unitDetailDTO'] = entity.unitDetailDTO?.toJson();
  data['invalid'] = entity.invalid;
  data['remark'] = entity.remark;
  data['supplier'] = entity.supplier;
  data['supplierName'] = entity.supplierName;
  data['salesChannel'] = entity.salesChannel;
  data['creator'] = entity.creator;
  return data;
}

extension ProductDetailDTOExtension on ProductDetailDTO {
  ProductDetailDTO copyWith({
    int? id,
    int? ledgerId,
    int? productType,
    String? productTypeDesc,
    String? productName,
    String? productStandard,
    String? productPlace,
    int? productClassify,
    String? productClassifyName,
    UnitDetailDTO? unitDetailDTO,
    int? invalid,
    String? remark,
    int? supplier,
    String? supplierName,
    int? salesChannel,
    int? creator,
  }) {
    return ProductDetailDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..productType = productType ?? this.productType
      ..productTypeDesc = productTypeDesc ?? this.productTypeDesc
      ..productName = productName ?? this.productName
      ..productStandard = productStandard ?? this.productStandard
      ..productPlace = productPlace ?? this.productPlace
      ..productClassify = productClassify ?? this.productClassify
      ..productClassifyName = productClassifyName ?? this.productClassifyName
      ..unitDetailDTO = unitDetailDTO ?? this.unitDetailDTO
      ..invalid = invalid ?? this.invalid
      ..remark = remark ?? this.remark
      ..supplier = supplier ?? this.supplier
      ..supplierName = supplierName ?? this.supplierName
      ..salesChannel = salesChannel ?? this.salesChannel
      ..creator = creator ?? this.creator;
  }
}