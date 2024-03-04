import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/user_authorization_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserAuthorizationDTO {
  List<String>? authorizationCodes;

  bool? latest;

  int? version;

  UserAuthorizationDTO();

  factory UserAuthorizationDTO.fromJson(Map<String, dynamic> json) =>
      $UserAuthorizationDTOFromJson(json);

  Map<String, dynamic> toJson() => $UserAuthorizationDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
