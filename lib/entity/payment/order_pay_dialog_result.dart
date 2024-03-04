import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/order_pay_dialog_result.g.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/payment/order_payment_request.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class OrderPayDialogResult {
  Decimal? discountAmount;

  Decimal? creditAmount;

  CustomDTO? customDTO;

  List<OrderPaymentRequest>? orderPaymentRequest;

  OrderPayDialogResult(
      {this.discountAmount,
      this.creditAmount,
      this.customDTO,
      this.orderPaymentRequest});

  factory OrderPayDialogResult.fromJson(Map<String, dynamic> json) =>
      $OrderPayDialogResultFromJson(json);

  Map<String, dynamic> toJson() => $OrderPayDialogResultToJson(this);

  String toJsonString() => json.encode(toJson());
}
