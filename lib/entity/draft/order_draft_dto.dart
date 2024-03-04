import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/order_draft_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class OrderDraftDTO {
  int? id;
  int? ledgerId;
  String? batchNo;
  List<String>? productNameList;
  int? customId;
  String? customName;
  Decimal? totalAmount;
  int? orderType;
  DateTime? gmtCreate;
  DateTime? orderDate;

  OrderDraftDTO();

  factory OrderDraftDTO.fromJson(Map<String, dynamic> json) =>
      $OrderDraftDTOFromJson(json);

  Map<String, dynamic> toJson() => $OrderDraftDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
