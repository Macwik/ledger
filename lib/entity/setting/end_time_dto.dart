import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/end_time_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class EndTimeDTO {
  int? hour;
  int? minute;
  int? second;
  int? nano;

  EndTimeDTO();

  factory EndTimeDTO.fromJson(Map<String, dynamic> json) =>
      $EndTimeDTOFromJson(json);

  Map<String, dynamic> toJson() => $EndTimeDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}