import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/payment_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class PaymentDTO {
  int? paymentMethodId;
  String? paymentMethodName;
  String? paymentMethodIcon;
  int? paymentAmount;
  int? ordinal;

  PaymentDTO();

  factory PaymentDTO.fromJson(Map<String, dynamic> json) =>
      $PaymentDTOFromJson(json);

  Map<String, dynamic> toJson() => $PaymentDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}