import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/home/sales_payment_statistics_dto.dart';
import 'package:decimal/decimal.dart';


SalesPaymentStatisticsDTO $SalesPaymentStatisticsDTOFromJson(
    Map<String, dynamic> json) {
  final SalesPaymentStatisticsDTO salesPaymentStatisticsDTO = SalesPaymentStatisticsDTO();
  final int? paymentMethodId = jsonConvert.convert<int>(
      json['paymentMethodId']);
  if (paymentMethodId != null) {
    salesPaymentStatisticsDTO.paymentMethodId = paymentMethodId;
  }
  final String? paymentMethodName = jsonConvert.convert<String>(
      json['paymentMethodName']);
  if (paymentMethodName != null) {
    salesPaymentStatisticsDTO.paymentMethodName = paymentMethodName;
  }
  final String? paymentMethodIcon = jsonConvert.convert<String>(
      json['paymentMethodIcon']);
  if (paymentMethodIcon != null) {
    salesPaymentStatisticsDTO.paymentMethodIcon = paymentMethodIcon;
  }
  final Decimal? paymentAmount = jsonConvert.convert<Decimal>(
      json['paymentAmount']);
  if (paymentAmount != null) {
    salesPaymentStatisticsDTO.paymentAmount = paymentAmount;
  }
  return salesPaymentStatisticsDTO;
}

Map<String, dynamic> $SalesPaymentStatisticsDTOToJson(
    SalesPaymentStatisticsDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['paymentMethodId'] = entity.paymentMethodId;
  data['paymentMethodName'] = entity.paymentMethodName;
  data['paymentMethodIcon'] = entity.paymentMethodIcon;
  data['paymentAmount'] = entity.paymentAmount?.toJson();
  return data;
}

extension SalesPaymentStatisticsDTOExtension on SalesPaymentStatisticsDTO {
  SalesPaymentStatisticsDTO copyWith({
    int? paymentMethodId,
    String? paymentMethodName,
    String? paymentMethodIcon,
    Decimal? paymentAmount,
  }) {
    return SalesPaymentStatisticsDTO()
      ..paymentMethodId = paymentMethodId ?? this.paymentMethodId
      ..paymentMethodName = paymentMethodName ?? this.paymentMethodName
      ..paymentMethodIcon = paymentMethodIcon ?? this.paymentMethodIcon
      ..paymentAmount = paymentAmount ?? this.paymentAmount;
  }
}