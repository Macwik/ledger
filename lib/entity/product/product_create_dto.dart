import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/product_create_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class ProductCreateDTO {
  int? ledgerId;
  int? productType;
  String? productName;
  String? productStandard;
  String? productPlace;
  bool? multiUnit;
  int? unitGroup;
  int? unit;
  int? price;
  String? unitName;
  String? remark;
  int? supplier;
  int? productSource;


  ProductCreateDTO();

  factory ProductCreateDTO.fromJson(Map<String, dynamic> json) =>
      $ProductCreateDTOFromJson(json);

  Map<String, dynamic> toJson() => $ProductCreateDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
