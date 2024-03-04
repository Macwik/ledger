import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/costIncome/order_pay_request.dart';
import 'package:decimal/decimal.dart';


OrderPayRequest $OrderPayRequestFromJson(Map<String, dynamic> json) {
  final OrderPayRequest orderPayRequest = OrderPayRequest();
  final int? payMethodId = jsonConvert.convert<int>(json['payMethodId']);
  if (payMethodId != null) {
    orderPayRequest.payMethodId = payMethodId;
  }
  final Decimal? payAmount = jsonConvert.convert<Decimal>(json['payAmount']);
  if (payAmount != null) {
    orderPayRequest.payAmount = payAmount;
  }
  final int? ordinal = jsonConvert.convert<int>(json['ordinal']);
  if (ordinal != null) {
    orderPayRequest.ordinal = ordinal;
  }
  return orderPayRequest;
}

Map<String, dynamic> $OrderPayRequestToJson(OrderPayRequest entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['payMethodId'] = entity.payMethodId;
  data['payAmount'] = entity.payAmount?.toJson();
  data['ordinal'] = entity.ordinal;
  return data;
}

extension OrderPayRequestExtension on OrderPayRequest {
  OrderPayRequest copyWith({
    int? payMethodId,
    Decimal? payAmount,
    int? ordinal,
  }) {
    return OrderPayRequest()
      ..payMethodId = payMethodId ?? this.payMethodId
      ..payAmount = payAmount ?? this.payAmount
      ..ordinal = ordinal ?? this.ordinal;
  }
}