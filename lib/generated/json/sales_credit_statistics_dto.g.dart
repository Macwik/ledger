import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/home/sales_credit_statistics_dto.dart';
import 'package:decimal/decimal.dart';


SalesCreditStatisticsDTO $SalesCreditStatisticsDTOFromJson(
    Map<String, dynamic> json) {
  final SalesCreditStatisticsDTO salesCreditStatisticsDTO = SalesCreditStatisticsDTO();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    salesCreditStatisticsDTO.ledgerId = ledgerId;
  }
  final int? customId = jsonConvert.convert<int>(json['customId']);
  if (customId != null) {
    salesCreditStatisticsDTO.customId = customId;
  }
  final String? customName = jsonConvert.convert<String>(json['customName']);
  if (customName != null) {
    salesCreditStatisticsDTO.customName = customName;
  }
  final int? customType = jsonConvert.convert<int>(json['customType']);
  if (customType != null) {
    salesCreditStatisticsDTO.customType = customType;
  }
  final int? creditType = jsonConvert.convert<int>(json['creditType']);
  if (creditType != null) {
    salesCreditStatisticsDTO.creditType = creditType;
  }
  final int? orderId = jsonConvert.convert<int>(json['orderId']);
  if (orderId != null) {
    salesCreditStatisticsDTO.orderId = orderId;
  }
  final Decimal? creditAmount = jsonConvert.convert<Decimal>(
      json['creditAmount']);
  if (creditAmount != null) {
    salesCreditStatisticsDTO.creditAmount = creditAmount;
  }
  return salesCreditStatisticsDTO;
}

Map<String, dynamic> $SalesCreditStatisticsDTOToJson(
    SalesCreditStatisticsDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['customId'] = entity.customId;
  data['customName'] = entity.customName;
  data['customType'] = entity.customType;
  data['creditType'] = entity.creditType;
  data['orderId'] = entity.orderId;
  data['creditAmount'] = entity.creditAmount?.toJson();
  return data;
}

extension SalesCreditStatisticsDTOExtension on SalesCreditStatisticsDTO {
  SalesCreditStatisticsDTO copyWith({
    int? ledgerId,
    int? customId,
    String? customName,
    int? customType,
    int? creditType,
    int? orderId,
    Decimal? creditAmount,
  }) {
    return SalesCreditStatisticsDTO()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..customId = customId ?? this.customId
      ..customName = customName ?? this.customName
      ..customType = customType ?? this.customType
      ..creditType = creditType ?? this.creditType
      ..orderId = orderId ?? this.orderId
      ..creditAmount = creditAmount ?? this.creditAmount;
  }
}