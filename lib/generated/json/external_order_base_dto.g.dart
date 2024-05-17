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
  final DateTime? externalDate = jsonConvert.convert<DateTime>(
      json['externalDate']);
  if (externalDate != null) {
    externalOrderBaseDTO.externalDate = externalDate;
  }
  final int? salesOrderId = jsonConvert.convert<int>(json['salesOrderId']);
  if (salesOrderId != null) {
    externalOrderBaseDTO.salesOrderId = salesOrderId;
  }
  final int? discount = jsonConvert.convert<int>(json['discount']);
  if (discount != null) {
    externalOrderBaseDTO.discount = discount;
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
  data['externalDate'] = entity.externalDate?.toIso8601String();
  data['salesOrderId'] = entity.salesOrderId;
  data['discount'] = entity.discount;
  data['costIncomeName'] = entity.costIncomeName;
  data['totalAmount'] = entity.totalAmount?.toJson();
  return data;
}

extension ExternalOrderBaseDTOExtension on ExternalOrderBaseDTO {
  ExternalOrderBaseDTO copyWith({
    int? id,
    int? ledgerId,
    DateTime? externalDate,
    int? salesOrderId,
    int? discount,
    String? costIncomeName,
    Decimal? totalAmount,
  }) {
    return ExternalOrderBaseDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..externalDate = externalDate ?? this.externalDate
      ..salesOrderId = salesOrderId ?? this.salesOrderId
      ..discount = discount ?? this.discount
      ..costIncomeName = costIncomeName ?? this.costIncomeName
      ..totalAmount = totalAmount ?? this.totalAmount;
  }
}