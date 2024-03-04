import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/entity/ledger/ledger_dto_entity.dart';
import 'package:ledger/generated/json/user_dto_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserDTOEntity {
  int? id;

  String? username;

  int? gender;

  String? phone;

  LedgerDTOEntity? activeLedger;

  UserDTOEntity();

  factory UserDTOEntity.fromJson(Map<String, dynamic> json) =>
      $UserDTOEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserDTOEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}