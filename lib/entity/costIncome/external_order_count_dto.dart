import 'package:decimal/decimal.dart';
import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/external_order_count_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class ExternalOrderCountDTO {

  int? count;
  Decimal? totalAmount;

  ExternalOrderCountDTO();

  factory ExternalOrderCountDTO.fromJson(Map<String, dynamic> json) =>
      $ExternalOrderCountDTOFromJson(json);

  Map<String, dynamic> toJson() => $ExternalOrderCountDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }


}
