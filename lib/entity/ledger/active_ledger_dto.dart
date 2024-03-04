import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/active_ledger_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class ActiveLedgerDTO {
  int? ledgerId;
  String? ledgerName;
  String? remark;

  ActiveLedgerDTO();

  factory ActiveLedgerDTO.fromJson(Map<String, dynamic> json) =>
      $ActiveLedgerDTOFromJson(json);

  Map<String, dynamic> toJson() => $ActiveLedgerDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
