import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/statistics/money_payment_dto.dart';
import 'package:decimal/decimal.dart';


MoneyPaymentDTO $MoneyPaymentDTOFromJson(Map<String, dynamic> json) {
  final MoneyPaymentDTO moneyPaymentDTO = MoneyPaymentDTO();
  final int? paymentMethodId = jsonConvert.convert<int>(
      json['paymentMethodId']);
  if (paymentMethodId != null) {
    moneyPaymentDTO.paymentMethodId = paymentMethodId;
  }
  final String? paymentMethodName = jsonConvert.convert<String>(
      json['paymentMethodName']);
  if (paymentMethodName != null) {
    moneyPaymentDTO.paymentMethodName = paymentMethodName;
  }
  final String? paymentMethodIcon = jsonConvert.convert<String>(
      json['paymentMethodIcon']);
  if (paymentMethodIcon != null) {
    moneyPaymentDTO.paymentMethodIcon = paymentMethodIcon;
  }
  final Decimal? salesAmount = jsonConvert.convert<Decimal>(
      json['salesAmount']);
  if (salesAmount != null) {
    moneyPaymentDTO.salesAmount = salesAmount;
  }
  final Decimal? incomeAmount = jsonConvert.convert<Decimal>(
      json['incomeAmount']);
  if (incomeAmount != null) {
    moneyPaymentDTO.incomeAmount = incomeAmount;
  }
  final Decimal? costAmount = jsonConvert.convert<Decimal>(json['costAmount']);
  if (costAmount != null) {
    moneyPaymentDTO.costAmount = costAmount;
  }
  final Decimal? repaymentAmount = jsonConvert.convert<Decimal>(
      json['repaymentAmount']);
  if (repaymentAmount != null) {
    moneyPaymentDTO.repaymentAmount = repaymentAmount;
  }
  return moneyPaymentDTO;
}

Map<String, dynamic> $MoneyPaymentDTOToJson(MoneyPaymentDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['paymentMethodId'] = entity.paymentMethodId;
  data['paymentMethodName'] = entity.paymentMethodName;
  data['paymentMethodIcon'] = entity.paymentMethodIcon;
  data['salesAmount'] = entity.salesAmount?.toJson();
  data['incomeAmount'] = entity.incomeAmount?.toJson();
  data['costAmount'] = entity.costAmount?.toJson();
  data['repaymentAmount'] = entity.repaymentAmount?.toJson();
  return data;
}

extension MoneyPaymentDTOExtension on MoneyPaymentDTO {
  MoneyPaymentDTO copyWith({
    int? paymentMethodId,
    String? paymentMethodName,
    String? paymentMethodIcon,
    Decimal? salesAmount,
    Decimal? incomeAmount,
    Decimal? costAmount,
    Decimal? repaymentAmount,
  }) {
    return MoneyPaymentDTO()
      ..paymentMethodId = paymentMethodId ?? this.paymentMethodId
      ..paymentMethodName = paymentMethodName ?? this.paymentMethodName
      ..paymentMethodIcon = paymentMethodIcon ?? this.paymentMethodIcon
      ..salesAmount = salesAmount ?? this.salesAmount
      ..incomeAmount = incomeAmount ?? this.incomeAmount
      ..costAmount = costAmount ?? this.costAmount
      ..repaymentAmount = repaymentAmount ?? this.repaymentAmount;
  }
}