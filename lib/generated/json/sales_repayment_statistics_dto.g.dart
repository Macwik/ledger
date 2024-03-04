import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/home/sales_repayment_statistics_dto.dart';
import 'package:decimal/decimal.dart';


SalesRepaymentStatisticsDTO $SalesRepaymentStatisticsDTOFromJson(
    Map<String, dynamic> json) {
  final SalesRepaymentStatisticsDTO salesRepaymentStatisticsDTO = SalesRepaymentStatisticsDTO();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    salesRepaymentStatisticsDTO.ledgerId = ledgerId;
  }
  final int? customId = jsonConvert.convert<int>(json['customId']);
  if (customId != null) {
    salesRepaymentStatisticsDTO.customId = customId;
  }
  final String? customName = jsonConvert.convert<String>(json['customName']);
  if (customName != null) {
    salesRepaymentStatisticsDTO.customName = customName;
  }
  final int? customType = jsonConvert.convert<int>(json['customType']);
  if (customType != null) {
    salesRepaymentStatisticsDTO.customType = customType;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    salesRepaymentStatisticsDTO.totalAmount = totalAmount;
  }
  final Decimal? discountAmount = jsonConvert.convert<Decimal>(
      json['discountAmount']);
  if (discountAmount != null) {
    salesRepaymentStatisticsDTO.discountAmount = discountAmount;
  }
  return salesRepaymentStatisticsDTO;
}

Map<String, dynamic> $SalesRepaymentStatisticsDTOToJson(
    SalesRepaymentStatisticsDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['customId'] = entity.customId;
  data['customName'] = entity.customName;
  data['customType'] = entity.customType;
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['discountAmount'] = entity.discountAmount?.toJson();
  return data;
}

extension SalesRepaymentStatisticsDTOExtension on SalesRepaymentStatisticsDTO {
  SalesRepaymentStatisticsDTO copyWith({
    int? ledgerId,
    int? customId,
    String? customName,
    int? customType,
    Decimal? totalAmount,
    Decimal? discountAmount,
  }) {
    return SalesRepaymentStatisticsDTO()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..customId = customId ?? this.customId
      ..customName = customName ?? this.customName
      ..customType = customType ?? this.customType
      ..totalAmount = totalAmount ?? this.totalAmount
      ..discountAmount = discountAmount ?? this.discountAmount;
  }
}