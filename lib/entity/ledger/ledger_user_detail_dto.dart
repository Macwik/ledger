import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/entity/auth/role_dto.dart';
import 'package:ledger/entity/user/user_dto_entity.dart';
import 'package:ledger/generated/json/ledger_user_detail_dto.g.dart';
import 'dart:convert';
@JsonSerializable()
class LedgerUserDetailDTO {
  int? userId;
  int? ledgerId;
  UserDTOEntity? userBaseDTO;
  RoleDTO? roleDTO;
  DateTime? entryDate;

  LedgerUserDetailDTO();

  factory LedgerUserDetailDTO.fromJson(Map<String, dynamic> json) =>
      $LedgerUserDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => $LedgerUserDetailDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

}