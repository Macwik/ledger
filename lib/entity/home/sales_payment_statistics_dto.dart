import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/sales_payment_statistics_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class SalesPaymentStatisticsDTO{
  int? paymentMethodId;
  String? paymentMethodName;
  String? paymentMethodIcon;
  Decimal? paymentAmount;

  SalesPaymentStatisticsDTO();

  factory SalesPaymentStatisticsDTO.fromJson(Map<String, dynamic> json) =>
      $SalesPaymentStatisticsDTOFromJson(json);

  Map<String, dynamic> toJson() => $SalesPaymentStatisticsDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}