import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/costIncome/external_order_count_dto.dart';
import 'package:decimal/decimal.dart';


ExternalOrderCountDTO $ExternalOrderCountDTOFromJson(
    Map<String, dynamic> json) {
  final ExternalOrderCountDTO externalOrderCountDTO = ExternalOrderCountDTO();
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    externalOrderCountDTO.count = count;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    externalOrderCountDTO.totalAmount = totalAmount;
  }
  return externalOrderCountDTO;
}

Map<String, dynamic> $ExternalOrderCountDTOToJson(
    ExternalOrderCountDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['count'] = entity.count;
  data['totalAmount'] = entity.totalAmount?.toJson();
  return data;
}

extension ExternalOrderCountDTOExtension on ExternalOrderCountDTO {
  ExternalOrderCountDTO copyWith({
    int? count,
    Decimal? totalAmount,
  }) {
    return ExternalOrderCountDTO()
      ..count = count ?? this.count
      ..totalAmount = totalAmount ?? this.totalAmount;
  }
}