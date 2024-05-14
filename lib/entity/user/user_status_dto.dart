import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/entity/user/user_dto_entity.dart';
import 'package:ledger/generated/json/user_status_dto.g.dart';
import 'package:ledger/generated/json/user_dto_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserStatusDTO {
  int? statusCode;

  String? phone;

  UserDTOEntity? userDTO;

  UserStatusDTO();

  factory UserStatusDTO.fromJson(Map<String, dynamic> json) =>
      $UserStatusDTOFromJson(json);

  Map<String, dynamic> toJson() => $UserStatusDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
