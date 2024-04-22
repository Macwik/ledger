import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/start_time_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class StartTimeDTO {
  int? hour;
  int? minute;
  int? second;
  int? nano;

  StartTimeDTO();

  factory StartTimeDTO.fromJson(Map<String, dynamic> json) =>
      $StartTimeDTOFromJson(json);

  Map<String, dynamic> toJson() => $StartTimeDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}