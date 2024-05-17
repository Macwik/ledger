import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/costIncome/external_order_statistic_dto.dart';
import 'package:ledger/entity/costIncome/external_order_base_dto.dart';


ExternalOrderStatisticDTO $ExternalOrderStatisticDTOFromJson(
    Map<String, dynamic> json) {
  final ExternalOrderStatisticDTO externalOrderStatisticDTO = ExternalOrderStatisticDTO();
  final int? salesOrderId = jsonConvert.convert<int>(json['salesOrderId']);
  if (salesOrderId != null) {
    externalOrderStatisticDTO.salesOrderId = salesOrderId;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    externalOrderStatisticDTO.batchNo = batchNo;
  }
  final List<
      ExternalOrderBaseDTO>? externalOrderBaseDTO = (json['externalOrderBaseDTO'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ExternalOrderBaseDTO>(e) as ExternalOrderBaseDTO)
      .toList();
  if (externalOrderBaseDTO != null) {
    externalOrderStatisticDTO.externalOrderBaseDTO = externalOrderBaseDTO;
  }
  return externalOrderStatisticDTO;
}

Map<String, dynamic> $ExternalOrderStatisticDTOToJson(
    ExternalOrderStatisticDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['salesOrderId'] = entity.salesOrderId;
  data['batchNo'] = entity.batchNo;
  data['externalOrderBaseDTO'] =
      entity.externalOrderBaseDTO?.map((v) => v.toJson()).toList();
  return data;
}

extension ExternalOrderStatisticDTOExtension on ExternalOrderStatisticDTO {
  ExternalOrderStatisticDTO copyWith({
    int? salesOrderId,
    String? batchNo,
    List<ExternalOrderBaseDTO>? externalOrderBaseDTO,
  }) {
    return ExternalOrderStatisticDTO()
      ..salesOrderId = salesOrderId ?? this.salesOrderId
      ..batchNo = batchNo ?? this.batchNo
      ..externalOrderBaseDTO = externalOrderBaseDTO ??
          this.externalOrderBaseDTO;
  }
}