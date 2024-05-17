import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/costIncome/external_order_statistic_dto.dart';
import 'package:ledger/entity/statistics/external_order_base_dto.dart';


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
      ExternalOrderBaseDTO>? externalOrderList = (json['externalOrderList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ExternalOrderBaseDTO>(e) as ExternalOrderBaseDTO)
      .toList();
  if (externalOrderList != null) {
    externalOrderStatisticDTO.externalOrderList = externalOrderList;
  }
  return externalOrderStatisticDTO;
}

Map<String, dynamic> $ExternalOrderStatisticDTOToJson(
    ExternalOrderStatisticDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['salesOrderId'] = entity.salesOrderId;
  data['batchNo'] = entity.batchNo;
  data['externalOrderList'] =
      entity.externalOrderList?.map((v) => v.toJson()).toList();
  return data;
}

extension ExternalOrderStatisticDTOExtension on ExternalOrderStatisticDTO {
  ExternalOrderStatisticDTO copyWith({
    int? salesOrderId,
    String? batchNo,
    List<ExternalOrderBaseDTO>? externalOrderList,
  }) {
    return ExternalOrderStatisticDTO()
      ..salesOrderId = salesOrderId ?? this.salesOrderId
      ..batchNo = batchNo ?? this.batchNo
      ..externalOrderList = externalOrderList ?? this.externalOrderList;
  }
}