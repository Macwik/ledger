import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/generated/json/product_classify_list_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class ProductClassifyListDTO {

 List<ProductClassifyDTO>? productClassifyList;
 List<ProductDTO>? productList;

 ProductClassifyListDTO();

  factory ProductClassifyListDTO.fromJson(Map<String, dynamic> json) =>
      $ProductClassifyListDTOFromJson(json);

  Map<String, dynamic> toJson() => $ProductClassifyListDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
