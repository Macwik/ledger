import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/payment/order_pay_dialog_result.dart';
import 'package:ledger/entity/custom/custom_dto.dart';

import 'package:ledger/entity/payment/order_payment_request.dart';

import 'package:decimal/decimal.dart';


OrderPayDialogResult $OrderPayDialogResultFromJson(Map<String, dynamic> json) {
  final OrderPayDialogResult orderPayDialogResult = OrderPayDialogResult();
  final Decimal? discountAmount = jsonConvert.convert<Decimal>(
      json['discountAmount']);
  if (discountAmount != null) {
    orderPayDialogResult.discountAmount = discountAmount;
  }
  final Decimal? creditAmount = jsonConvert.convert<Decimal>(
      json['creditAmount']);
  if (creditAmount != null) {
    orderPayDialogResult.creditAmount = creditAmount;
  }
  final CustomDTO? customDTO = jsonConvert.convert<CustomDTO>(
      json['customDTO']);
  if (customDTO != null) {
    orderPayDialogResult.customDTO = customDTO;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    orderPayDialogResult.remark = remark;
  }
  final List<
      OrderPaymentRequest>? orderPaymentRequest = (json['orderPaymentRequest'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<OrderPaymentRequest>(e) as OrderPaymentRequest)
      .toList();
  if (orderPaymentRequest != null) {
    orderPayDialogResult.orderPaymentRequest = orderPaymentRequest;
  }
  return orderPayDialogResult;
}

Map<String, dynamic> $OrderPayDialogResultToJson(OrderPayDialogResult entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['discountAmount'] = entity.discountAmount?.toJson();
  data['creditAmount'] = entity.creditAmount?.toJson();
  data['customDTO'] = entity.customDTO?.toJson();
  data['remark'] = entity.remark;
  data['orderPaymentRequest'] =
      entity.orderPaymentRequest?.map((v) => v.toJson()).toList();
  return data;
}

extension OrderPayDialogResultExtension on OrderPayDialogResult {
  OrderPayDialogResult copyWith({
    Decimal? discountAmount,
    Decimal? creditAmount,
    CustomDTO? customDTO,
    String? remark,
    List<OrderPaymentRequest>? orderPaymentRequest,
  }) {
    return OrderPayDialogResult()
      ..discountAmount = discountAmount ?? this.discountAmount
      ..creditAmount = creditAmount ?? this.creditAmount
      ..customDTO = customDTO ?? this.customDTO
      ..remark = remark ?? this.remark
      ..orderPaymentRequest = orderPaymentRequest ?? this.orderPaymentRequest;
  }
}