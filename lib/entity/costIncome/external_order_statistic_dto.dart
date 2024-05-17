import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/external_order_statistic_dto.g.dart';
import 'package:ledger/entity/statistics/external_order_base_dto.dart';
import 'dart:convert';

@JsonSerializable()
class ExternalOrderStatisticDTO {

  int? salesOrderId;
  String? batchNo;
  List<ExternalOrderBaseDTO>? externalOrderBaseDTO;

  ExternalOrderStatisticDTO();

  factory ExternalOrderStatisticDTO.fromJson(Map<String, dynamic> json) =>
      $ExternalOrderStatisticDTOFromJson(json);

  Map<String, dynamic> toJson() => $ExternalOrderStatisticDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
