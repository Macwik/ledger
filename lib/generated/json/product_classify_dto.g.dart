import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';

ProductClassifyDTO $ProductClassifyDTOFromJson(Map<String, dynamic> json) {
  final ProductClassifyDTO productClassifyDTO = ProductClassifyDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    productClassifyDTO.id = id;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    productClassifyDTO.remark = remark;
  }
  final int? ordinal = jsonConvert.convert<int>(json['ordinal']);
  if (ordinal != null) {
    productClassifyDTO.ordinal = ordinal;
  }
  final String? productClassify = jsonConvert.convert<String>(
      json['productClassify']);
  if (productClassify != null) {
    productClassifyDTO.productClassify = productClassify;
  }
  return productClassifyDTO;
}

Map<String, dynamic> $ProductClassifyDTOToJson(ProductClassifyDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['remark'] = entity.remark;
  data['ordinal'] = entity.ordinal;
  data['productClassify'] = entity.productClassify;
  return data;
}

extension ProductClassifyDTOExtension on ProductClassifyDTO {
  ProductClassifyDTO copyWith({
    int? id,
    String? remark,
    int? ordinal,
    String? productClassify,
  }) {
    return ProductClassifyDTO()
      ..id = id ?? this.id
      ..remark = remark ?? this.remark
      ..ordinal = ordinal ?? this.ordinal
      ..productClassify = productClassify ?? this.productClassify;
  }
}