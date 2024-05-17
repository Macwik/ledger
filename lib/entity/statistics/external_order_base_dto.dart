import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/external_order_base_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class ExternalOrderBaseDTO {
  int? id;
  int? ledgerId;
  DateTime? externalDate;
  int? salesOrderId;
  int? discount;
  String? costIncomeName;
  Decimal? totalAmount;

  ExternalOrderBaseDTO();

  factory ExternalOrderBaseDTO.fromJson(Map<String, dynamic> json) =>
      $ExternalOrderBaseDTOFromJson(json);

  Map<String, dynamic> toJson() => $ExternalOrderBaseDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

}