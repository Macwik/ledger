import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/sys_res_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class SysResDTO {
  int? id;
  String? resCode;
  String? resName;
  String? resDesc;
  int? resType;
  int? parentId;
  int? hierarchy;
  int? ordinal;
  int? deleted;

  SysResDTO(
      {int? id,
      String? resCode,
      String? resName,
      String? resDesc,
      int? resType,
      int? parentId,
      int? hierarchy,
      int? ordinal,
      int? deleted}) {
    this.id = id;
    this.resCode = resCode;
    this.resName = resName;
    this.resDesc = resDesc;
    this.resType = resType;
    this.parentId = parentId;
    this.hierarchy = hierarchy;
    this.ordinal = ordinal;
    this.deleted = deleted;
  }

  factory SysResDTO.fromJson(Map<String, dynamic> json) =>
      $SysResDTOFromJson(json);

  Map<String, dynamic> toJson() => $SysResDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
