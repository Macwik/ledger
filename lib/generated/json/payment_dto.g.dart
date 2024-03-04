import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/remittance/payment_dto.dart';

PaymentDTO $PaymentDTOFromJson(Map<String, dynamic> json) {
  final PaymentDTO paymentDTO = PaymentDTO();
  final int? paymentMethodId = jsonConvert.convert<int>(
      json['paymentMethodId']);
  if (paymentMethodId != null) {
    paymentDTO.paymentMethodId = paymentMethodId;
  }
  final String? paymentMethodName = jsonConvert.convert<String>(
      json['paymentMethodName']);
  if (paymentMethodName != null) {
    paymentDTO.paymentMethodName = paymentMethodName;
  }
  final String? paymentMethodIcon = jsonConvert.convert<String>(
      json['paymentMethodIcon']);
  if (paymentMethodIcon != null) {
    paymentDTO.paymentMethodIcon = paymentMethodIcon;
  }
  final int? paymentAmount = jsonConvert.convert<int>(json['paymentAmount']);
  if (paymentAmount != null) {
    paymentDTO.paymentAmount = paymentAmount;
  }
  final int? ordinal = jsonConvert.convert<int>(json['ordinal']);
  if (ordinal != null) {
    paymentDTO.ordinal = ordinal;
  }
  return paymentDTO;
}

Map<String, dynamic> $PaymentDTOToJson(PaymentDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['paymentMethodId'] = entity.paymentMethodId;
  data['paymentMethodName'] = entity.paymentMethodName;
  data['paymentMethodIcon'] = entity.paymentMethodIcon;
  data['paymentAmount'] = entity.paymentAmount;
  data['ordinal'] = entity.ordinal;
  return data;
}

extension PaymentDTOExtension on PaymentDTO {
  PaymentDTO copyWith({
    int? paymentMethodId,
    String? paymentMethodName,
    String? paymentMethodIcon,
    int? paymentAmount,
    int? ordinal,
  }) {
    return PaymentDTO()
      ..paymentMethodId = paymentMethodId ?? this.paymentMethodId
      ..paymentMethodName = paymentMethodName ?? this.paymentMethodName
      ..paymentMethodIcon = paymentMethodIcon ?? this.paymentMethodIcon
      ..paymentAmount = paymentAmount ?? this.paymentAmount
      ..ordinal = ordinal ?? this.ordinal;
  }
}