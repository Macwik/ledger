import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/order_payment_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class OrderPaymentDTO {
  int? paymentMethodId;
  String? paymentMethodName;
  String? paymentMethodIcon;
  Decimal? paymentAmount;
  int? ordinal;


  OrderPaymentDTO();

  factory OrderPaymentDTO.fromJson(Map<String, dynamic> json) =>
      $OrderPaymentDTOFromJson(json);

  Map<String, dynamic> toJson() => $OrderPaymentDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
