import 'package:decimal/decimal.dart';
import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/order_pay_request.g.dart';
import 'dart:convert';

@JsonSerializable()
class OrderPayRequest {//暂时没有用到

  int? payMethodId;
  Decimal? payAmount;
  int? ordinal;

  OrderPayRequest();

  factory OrderPayRequest.fromJson(Map<String, dynamic> json) =>
      $OrderPayRequestFromJson(json);

  Map<String, dynamic> toJson() => $OrderPayRequestToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }


}
