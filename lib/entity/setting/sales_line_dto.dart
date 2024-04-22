import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/sales_line_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class SalesLineDTO {
  String? startTime;
  String? endTime;

  SalesLineDTO();

  factory SalesLineDTO.fromJson(Map<String, dynamic> json) =>
      $SalesLineDTOFromJson(json);

  Map<String, dynamic> toJson() => $SalesLineDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}