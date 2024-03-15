import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/order_payment_request.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class OrderPaymentRequest{
  int? paymentMethodId;
  Decimal? paymentAmount;
  int? ordinal;

  OrderPaymentRequest({
    this.paymentMethodId,
    this.paymentAmount,
    this.ordinal});

  factory OrderPaymentRequest.fromJson(Map<String, dynamic> json) =>
      $OrderPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => $OrderPaymentRequestToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}