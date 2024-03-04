import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/user_base_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserBaseDTO {
  int? id;
  String? username;
  int? gender;
  String? phone;
  int? ledgerId;
  String? ledgerName;

  UserBaseDTO();

  factory UserBaseDTO.fromJson(Map<String, dynamic> json) =>
      $UserBaseDTOFromJson(json);

  Map<String, dynamic> toJson() => $UserBaseDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
