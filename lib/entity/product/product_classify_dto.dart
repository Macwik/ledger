import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/product_classify_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class ProductClassifyDTO {
  int? id;
  String? remark;
  String? productClassify ;

  ProductClassifyDTO();

  factory ProductClassifyDTO.fromJson(Map<String, dynamic> json) =>
      $ProductClassifyDTOFromJson(json);

  Map<String, dynamic> toJson() => $ProductClassifyDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
