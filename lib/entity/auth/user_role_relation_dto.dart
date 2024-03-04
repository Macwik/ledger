import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/user_role_relation_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserRoleRelationDTO {
  int? userId;
  int? roleId;
  String? roleName;
  String? roleDesc;

  UserRoleRelationDTO();

  factory UserRoleRelationDTO.fromJson(Map<String, dynamic> json) =>
      $UserRoleRelationDTOFromJson(json);

  Map<String, dynamic> toJson() => $UserRoleRelationDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}