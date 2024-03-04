import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/custom_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class CustomDTO {
  int? id;
  int? ledgerId;
  String? customName;
  String? contact;
  String? phone;
  String? address;
  Decimal? tradeAmount;
  Decimal? creditAmount;
  int? invalid;
  int? used;  // 0 未使用 | 1 使用中
  String? remark;
  int? customType; // 1 客户 | 2 供应商

  CustomDTO({this.customName, this.tradeAmount, this.creditAmount, this.invalid, this.used});

  factory CustomDTO.fromJson(Map<String, dynamic> json) =>
      $CustomDTOFromJson(json);

  Map<String, dynamic> toJson() => $CustomDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
