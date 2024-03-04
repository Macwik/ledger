import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/ledger_dto_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class LedgerDTOEntity {
  int? ledgerId;

  String? ledgerName;

  String? remark;

  bool? owner;

  LedgerDTOEntity();

  factory LedgerDTOEntity.fromJson(Map<String, dynamic> json) =>
      $LedgerDTOEntityFromJson(json);

  Map<String, dynamic> toJson() => $LedgerDTOEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}