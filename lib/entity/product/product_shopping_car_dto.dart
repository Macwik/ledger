import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/product_shopping_car_dto.g.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class ProductShoppingCarDTO {
  int? productId;
  String? productName;
  String? productStandard;
  String? productPlace;
  int? salesChannel;
  UnitDetailDTO? unitDetailDTO;

  ProductShoppingCarDTO(
      {this.productId,
      this.productName,
      this.productPlace,
      this.productStandard,
      this.salesChannel,
      this.unitDetailDTO});

  factory ProductShoppingCarDTO.fromJson(Map<String, dynamic> json) =>
      $ProductShoppingCarDTOFromJson(json);

  Map<String, dynamic> toJson() => $ProductShoppingCarDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
