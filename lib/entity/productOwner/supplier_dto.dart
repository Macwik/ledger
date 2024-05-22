import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/supplier_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class SupplierDTO {

  int? id;
  int? ledgerId;
  int? userId;
  String? supplierName;
  String? phone;
  String? remark;
  int? creator;
  String? creatorName;
  int? invalid;//0 正常 | 1 未启用
  int? used;//0未使用 | 1已使用
  int? deleted;
  String? gmtCreate;
  String? gmtModified;


  SupplierDTO();

  factory SupplierDTO.fromJson(Map<String, dynamic> json) =>
      $SupplierDTOFromJson(json);

  Map<String, dynamic> toJson() => $SupplierDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

}