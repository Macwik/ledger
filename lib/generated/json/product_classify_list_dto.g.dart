import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';

import 'package:ledger/entity/product/product_dto.dart';


ProductClassifyListDTO $ProductClassifyListDTOFromJson(
    Map<String, dynamic> json) {
  final ProductClassifyListDTO productClassifyListDTO = ProductClassifyListDTO();
  final List<
      ProductClassifyDTO>? productClassifyList = (json['productClassifyList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ProductClassifyDTO>(e) as ProductClassifyDTO)
      .toList();
  if (productClassifyList != null) {
    productClassifyListDTO.productClassifyList = productClassifyList;
  }
  final List<ProductDTO>? productList = (json['productList'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ProductDTO>(e) as ProductDTO)
      .toList();
  if (productList != null) {
    productClassifyListDTO.productList = productList;
  }
  return productClassifyListDTO;
}

Map<String, dynamic> $ProductClassifyListDTOToJson(
    ProductClassifyListDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['productClassifyList'] =
      entity.productClassifyList?.map((v) => v.toJson()).toList();
  data['productList'] = entity.productList?.map((v) => v.toJson()).toList();
  return data;
}

extension ProductClassifyListDTOExtension on ProductClassifyListDTO {
  ProductClassifyListDTO copyWith({
    List<ProductClassifyDTO>? productClassifyList,
    List<ProductDTO>? productList,
  }) {
    return ProductClassifyListDTO()
      ..productClassifyList = productClassifyList ?? this.productClassifyList
      ..productList = productList ?? this.productList;
  }
}