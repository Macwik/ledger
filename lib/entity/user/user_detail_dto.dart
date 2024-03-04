import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/user_detail_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserDetailDTO {
  int? id;
  String? username;
  String? nickname;
  int? gender;
  String? phone;
  String? email;
  DateTime? gmtCreate;
  String? gmtModified;

  UserDetailDTO();

  factory UserDetailDTO.fromJson(Map<String, dynamic> json) =>
      $UserDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => $UserDetailDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

}