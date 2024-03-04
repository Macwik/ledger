import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/statistics/external_order_base_dto.dart';
import 'package:decimal/decimal.dart';


ExternalOrderBaseDTO $ExternalOrderBaseDTOFromJson(Map<String, dynamic> json) {
  final ExternalOrderBaseDTO externalOrderBaseDTO = ExternalOrderBaseDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    externalOrderBaseDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    externalOrderBaseDTO.ledgerId = ledgerId;
  }
  final int? salesOrderId = jsonConvert.convert<int>(json['salesOrderId']);
  if (salesOrderId != null) {
    externalOrderBaseDTO.salesOrderId = salesOrderId;
  }
  final String? costIncomeName = jsonConvert.convert<String>(
      json['costIncomeName']);
  if (costIncomeName != null) {
    externalOrderBaseDTO.costIncomeName = costIncomeName;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    externalOrderBaseDTO.totalAmount = totalAmount;
  }
  return externalOrderBaseDTO;
}

Map<String, dynamic> $ExternalOrderBaseDTOToJson(ExternalOrderBaseDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['salesOrderId'] = entity.salesOrderId;
  data['costIncomeName'] = entity.costIncomeName;
  data['totalAmount'] = entity.totalAmount?.toJson();
  return data;
}

extension ExternalOrderBaseDTOExtension on ExternalOrderBaseDTO {
  ExternalOrderBaseDTO copyWith({
    int? id,
    int? ledgerId,
    int? salesOrderId,
    String? costIncomeName,
    Decimal? totalAmount,
  }) {
    return ExternalOrderBaseDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..salesOrderId = salesOrderId ?? this.salesOrderId
      ..costIncomeName = costIncomeName ?? this.costIncomeName
      ..totalAmount = totalAmount ?? this.totalAmount;
  }
}