import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/role_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class RoleDTO {
  int? id;
  int? ledgerId;
  String? roleName;
  String? roleDesc;
  int? roleType;

  RoleDTO();

  factory RoleDTO.fromJson(Map<String, dynamic> json) => $RoleDTOFromJson(json);

  Map<String, dynamic> toJson() => $RoleDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
