import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/payment/order_payment_request.dart';
import 'package:decimal/decimal.dart';


OrderPaymentRequest $OrderPaymentRequestFromJson(Map<String, dynamic> json) {
  final OrderPaymentRequest orderPaymentRequest = OrderPaymentRequest();
  final int? paymentMethodId = jsonConvert.convert<int>(
      json['paymentMethodId']);
  if (paymentMethodId != null) {
    orderPaymentRequest.paymentMethodId = paymentMethodId;
  }
  final Decimal? paymentAmount = jsonConvert.convert<Decimal>(
      json['paymentAmount']);
  if (paymentAmount != null) {
    orderPaymentRequest.paymentAmount = paymentAmount;
  }
  final int? ordinal = jsonConvert.convert<int>(json['ordinal']);
  if (ordinal != null) {
    orderPaymentRequest.ordinal = ordinal;
  }
  return orderPaymentRequest;
}

Map<String, dynamic> $OrderPaymentRequestToJson(OrderPaymentRequest entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['paymentMethodId'] = entity.paymentMethodId;
  data['paymentAmount'] = entity.paymentAmount?.toJson();
  data['ordinal'] = entity.ordinal;
  return data;
}

extension OrderPaymentRequestExtension on OrderPaymentRequest {
  OrderPaymentRequest copyWith({
    int? paymentMethodId,
    Decimal? paymentAmount,
    int? ordinal,
  }) {
    return OrderPaymentRequest()
      ..paymentMethodId = paymentMethodId ?? this.paymentMethodId
      ..paymentAmount = paymentAmount ?? this.paymentAmount
      ..ordinal = ordinal ?? this.ordinal;
  }
}