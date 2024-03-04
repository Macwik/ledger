import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/calculate_scale_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class CalculateScaleDTO {
  int? id;
  int? userId;
  int? ledgerId;
  int? scale;


  CalculateScaleDTO();

  factory CalculateScaleDTO.fromJson(Map<String, dynamic> json) =>
      $CalculateScaleDTOFromJson(json);

  Map<String, dynamic> toJson() => $CalculateScaleDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}