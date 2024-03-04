import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/ledger_create_request.g.dart';
import 'dart:convert';

@JsonSerializable()
class LedgerCreateRequest {
  String? ledgerName;
  int? storeType;
  int? businessScope;
  String? remark;

  LedgerCreateRequest();

  factory LedgerCreateRequest.fromJson(Map<String, dynamic> json) =>
      $LedgerCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => $LedgerCreateRequestToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
