import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/order/order_product_request.dart';
import 'package:decimal/decimal.dart';


OrderProductRequest $OrderProductRequestFromJson(Map<String, dynamic> json) {
  final OrderProductRequest orderProductRequest = OrderProductRequest();
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    orderProductRequest.productId = productId;
  }
  final String? productName = jsonConvert.convert<String>(json['productName']);
  if (productName != null) {
    orderProductRequest.productName = productName;
  }
  final Decimal? masterNumber = jsonConvert.convert<Decimal>(
      json['masterNumber']);
  if (masterNumber != null) {
    orderProductRequest.masterNumber = masterNumber;
  }
  final Decimal? slaveNumber = jsonConvert.convert<Decimal>(
      json['slaveNumber']);
  if (slaveNumber != null) {
    orderProductRequest.slaveNumber = slaveNumber;
  }
  final bool? selectUnit = jsonConvert.convert<bool>(json['selectUnit']);
  if (selectUnit != null) {
    orderProductRequest.selectUnit = selectUnit;
  }
  final int? groupUnitId = jsonConvert.convert<int>(json['groupUnitId']);
  if (groupUnitId != null) {
    orderProductRequest.groupUnitId = groupUnitId;
  }
  final int? masterUnitId = jsonConvert.convert<int>(json['masterUnitId']);
  if (masterUnitId != null) {
    orderProductRequest.masterUnitId = masterUnitId;
  }
  final int? slaveUnitId = jsonConvert.convert<int>(json['slaveUnitId']);
  if (slaveUnitId != null) {
    orderProductRequest.slaveUnitId = slaveUnitId;
  }
  final Decimal? price = jsonConvert.convert<Decimal>(json['price']);
  if (price != null) {
    orderProductRequest.price = price;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    orderProductRequest.totalAmount = totalAmount;
  }
  return orderProductRequest;
}

Map<String, dynamic> $OrderProductRequestToJson(OrderProductRequest entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['productId'] = entity.productId;
  data['productName'] = entity.productName;
  data['masterNumber'] = entity.masterNumber?.toJson();
  data['slaveNumber'] = entity.slaveNumber?.toJson();
  data['selectUnit'] = entity.selectUnit;
  data['groupUnitId'] = entity.groupUnitId;
  data['masterUnitId'] = entity.masterUnitId;
  data['slaveUnitId'] = entity.slaveUnitId;
  data['price'] = entity.price?.toJson();
  data['totalAmount'] = entity.totalAmount?.toJson();
  return data;
}

extension OrderProductRequestExtension on OrderProductRequest {
  OrderProductRequest copyWith({
    int? productId,
    String? productName,
    Decimal? masterNumber,
    Decimal? slaveNumber,
    bool? selectUnit,
    int? groupUnitId,
    int? masterUnitId,
    int? slaveUnitId,
    Decimal? price,
    Decimal? totalAmount,
  }) {
    return OrderProductRequest()
      ..productId = productId ?? this.productId
      ..productName = productName ?? this.productName
      ..masterNumber = masterNumber ?? this.masterNumber
      ..slaveNumber = slaveNumber ?? this.slaveNumber
      ..selectUnit = selectUnit ?? this.selectUnit
      ..groupUnitId = groupUnitId ?? this.groupUnitId
      ..masterUnitId = masterUnitId ?? this.masterUnitId
      ..slaveUnitId = slaveUnitId ?? this.slaveUnitId
      ..price = price ?? this.price
      ..totalAmount = totalAmount ?? this.totalAmount;
  }
}