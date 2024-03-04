import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/order/order_payment_dto.dart';
import 'package:decimal/decimal.dart';


OrderPaymentDTO $OrderPaymentDTOFromJson(Map<String, dynamic> json) {
  final OrderPaymentDTO orderPaymentDTO = OrderPaymentDTO();
  final int? paymentMethodId = jsonConvert.convert<int>(
      json['paymentMethodId']);
  if (paymentMethodId != null) {
    orderPaymentDTO.paymentMethodId = paymentMethodId;
  }
  final String? paymentMethodName = jsonConvert.convert<String>(
      json['paymentMethodName']);
  if (paymentMethodName != null) {
    orderPaymentDTO.paymentMethodName = paymentMethodName;
  }
  final String? paymentMethodIcon = jsonConvert.convert<String>(
      json['paymentMethodIcon']);
  if (paymentMethodIcon != null) {
    orderPaymentDTO.paymentMethodIcon = paymentMethodIcon;
  }
  final Decimal? paymentAmount = jsonConvert.convert<Decimal>(
      json['paymentAmount']);
  if (paymentAmount != null) {
    orderPaymentDTO.paymentAmount = paymentAmount;
  }
  final int? ordinal = jsonConvert.convert<int>(json['ordinal']);
  if (ordinal != null) {
    orderPaymentDTO.ordinal = ordinal;
  }
  return orderPaymentDTO;
}

Map<String, dynamic> $OrderPaymentDTOToJson(OrderPaymentDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['paymentMethodId'] = entity.paymentMethodId;
  data['paymentMethodName'] = entity.paymentMethodName;
  data['paymentMethodIcon'] = entity.paymentMethodIcon;
  data['paymentAmount'] = entity.paymentAmount?.toJson();
  data['ordinal'] = entity.ordinal;
  return data;
}

extension OrderPaymentDTOExtension on OrderPaymentDTO {
  OrderPaymentDTO copyWith({
    int? paymentMethodId,
    String? paymentMethodName,
    String? paymentMethodIcon,
    Decimal? paymentAmount,
    int? ordinal,
  }) {
    return OrderPaymentDTO()
      ..paymentMethodId = paymentMethodId ?? this.paymentMethodId
      ..paymentMethodName = paymentMethodName ?? this.paymentMethodName
      ..paymentMethodIcon = paymentMethodIcon ?? this.paymentMethodIcon
      ..paymentAmount = paymentAmount ?? this.paymentAmount
      ..ordinal = ordinal ?? this.ordinal;
  }
}