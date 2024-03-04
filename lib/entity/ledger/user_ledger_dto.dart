import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/user_ledger_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserLedgerDTO {
  List<LedgerUserRelationDetailDTO>? ownerList;
  List<LedgerUserRelationDetailDTO>? joinList;

  UserLedgerDTO();

  factory UserLedgerDTO.fromJson(Map<String, dynamic> json) =>
      $UserLedgerDTOFromJson(json);

  Map<String, dynamic> toJson() => $UserLedgerDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LedgerUserRelationDetailDTO {
  int? id;
  int? userId;
  int? ledgerId;
  String? ledgerName;
  int? ledgerUserType;
  int? storeType;
  int? businessScope;
  String? remark;
  bool? active;

  LedgerUserRelationDetailDTO();

  factory LedgerUserRelationDetailDTO.fromJson(Map<String, dynamic> json) =>
      $LedgerUserRelationDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => $LedgerUserRelationDetailDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
