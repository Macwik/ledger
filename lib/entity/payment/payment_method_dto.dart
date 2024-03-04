import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/payment_method_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class PaymentMethodDTO {
  int? ledgerId;
  int? id;
  String? name;
  String? icon;
  String? remark;
  int? ordinal;

  PaymentMethodDTO({
    this.ledgerId,
    this.name,
    this.icon,
    this.remark,
    this.ordinal,
  });

  factory PaymentMethodDTO.fromJson(Map<String, dynamic> json) =>
      $PaymentMethodDTOFromJson(json);

  Map<String, dynamic> toJson() => $PaymentMethodDTOToJson(this);

  @override
  String toString() {
    return json.encode(this);
  }
}
