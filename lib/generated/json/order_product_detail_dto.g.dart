import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/order/order_product_detail_dto.dart';
import 'package:decimal/decimal.dart';


OrderProductDetail $OrderProductDetailFromJson(Map<String, dynamic> json) {
  final OrderProductDetail orderProductDetail = OrderProductDetail();
  final int? orderId = jsonConvert.convert<int>(json['orderId']);
  if (orderId != null) {
    orderProductDetail.orderId = orderId;
  }
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    orderProductDetail.productId = productId;
  }
  final String? productName = jsonConvert.convert<String>(json['productName']);
  if (productName != null) {
    orderProductDetail.productName = productName;
  }
  final String? productPlace = jsonConvert.convert<String>(
      json['productPlace']);
  if (productPlace != null) {
    orderProductDetail.productPlace = productPlace;
  }
  final String? productStandard = jsonConvert.convert<String>(
      json['productStandard']);
  if (productStandard != null) {
    orderProductDetail.productStandard = productStandard;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    orderProductDetail.invalid = invalid;
  }
  final int? unitType = jsonConvert.convert<int>(json['unitType']);
  if (unitType != null) {
    orderProductDetail.unitType = unitType;
  }
  final int? unitGroupId = jsonConvert.convert<int>(json['unitGroupId']);
  if (unitGroupId != null) {
    orderProductDetail.unitGroupId = unitGroupId;
  }
  final int? unitId = jsonConvert.convert<int>(json['unitId']);
  if (unitId != null) {
    orderProductDetail.unitId = unitId;
  }
  final String? unitName = jsonConvert.convert<String>(json['unitName']);
  if (unitName != null) {
    orderProductDetail.unitName = unitName;
  }
  final int? selectMasterUnit = jsonConvert.convert<int>(
      json['selectMasterUnit']);
  if (selectMasterUnit != null) {
    orderProductDetail.selectMasterUnit = selectMasterUnit;
  }
  final int? masterUnitId = jsonConvert.convert<int>(json['masterUnitId']);
  if (masterUnitId != null) {
    orderProductDetail.masterUnitId = masterUnitId;
  }
  final String? masterUnitName = jsonConvert.convert<String>(
      json['masterUnitName']);
  if (masterUnitName != null) {
    orderProductDetail.masterUnitName = masterUnitName;
  }
  final int? slaveUnitId = jsonConvert.convert<int>(json['slaveUnitId']);
  if (slaveUnitId != null) {
    orderProductDetail.slaveUnitId = slaveUnitId;
  }
  final String? slaveUnitName = jsonConvert.convert<String>(
      json['slaveUnitName']);
  if (slaveUnitName != null) {
    orderProductDetail.slaveUnitName = slaveUnitName;
  }
  final Decimal? number = jsonConvert.convert<Decimal>(json['number']);
  if (number != null) {
    orderProductDetail.number = number;
  }
  final Decimal? masterNumber = jsonConvert.convert<Decimal>(
      json['masterNumber']);
  if (masterNumber != null) {
    orderProductDetail.masterNumber = masterNumber;
  }
  final Decimal? slaveNumber = jsonConvert.convert<Decimal>(
      json['slaveNumber']);
  if (slaveNumber != null) {
    orderProductDetail.slaveNumber = slaveNumber;
  }
  final Decimal? price = jsonConvert.convert<Decimal>(json['price']);
  if (price != null) {
    orderProductDetail.price = price;
  }
  final Decimal? masterPrice = jsonConvert.convert<Decimal>(
      json['masterPrice']);
  if (masterPrice != null) {
    orderProductDetail.masterPrice = masterPrice;
  }
  final Decimal? slavePrice = jsonConvert.convert<Decimal>(json['slavePrice']);
  if (slavePrice != null) {
    orderProductDetail.slavePrice = slavePrice;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    orderProductDetail.totalAmount = totalAmount;
  }
  return orderProductDetail;
}

Map<String, dynamic> $OrderProductDetailToJson(OrderProductDetail entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderId'] = entity.orderId;
  data['productId'] = entity.productId;
  data['productName'] = entity.productName;
  data['productPlace'] = entity.productPlace;
  data['productStandard'] = entity.productStandard;
  data['invalid'] = entity.invalid;
  data['unitType'] = entity.unitType;
  data['unitGroupId'] = entity.unitGroupId;
  data['unitId'] = entity.unitId;
  data['unitName'] = entity.unitName;
  data['selectMasterUnit'] = entity.selectMasterUnit;
  data['masterUnitId'] = entity.masterUnitId;
  data['masterUnitName'] = entity.masterUnitName;
  data['slaveUnitId'] = entity.slaveUnitId;
  data['slaveUnitName'] = entity.slaveUnitName;
  data['number'] = entity.number?.toJson();
  data['masterNumber'] = entity.masterNumber?.toJson();
  data['slaveNumber'] = entity.slaveNumber?.toJson();
  data['price'] = entity.price?.toJson();
  data['masterPrice'] = entity.masterPrice?.toJson();
  data['slavePrice'] = entity.slavePrice?.toJson();
  data['totalAmount'] = entity.totalAmount?.toJson();
  return data;
}

extension OrderProductDetailExtension on OrderProductDetail {
  OrderProductDetail copyWith({
    int? orderId,
    int? productId,
    String? productName,
    String? productPlace,
    String? productStandard,
    int? invalid,
    int? unitType,
    int? unitGroupId,
    int? unitId,
    String? unitName,
    int? selectMasterUnit,
    int? masterUnitId,
    String? masterUnitName,
    int? slaveUnitId,
    String? slaveUnitName,
    Decimal? number,
    Decimal? masterNumber,
    Decimal? slaveNumber,
    Decimal? price,
    Decimal? masterPrice,
    Decimal? slavePrice,
    Decimal? totalAmount,
  }) {
    return OrderProductDetail()
      ..orderId = orderId ?? this.orderId
      ..productId = productId ?? this.productId
      ..productName = productName ?? this.productName
      ..productPlace = productPlace ?? this.productPlace
      ..productStandard = productStandard ?? this.productStandard
      ..invalid = invalid ?? this.invalid
      ..unitType = unitType ?? this.unitType
      ..unitGroupId = unitGroupId ?? this.unitGroupId
      ..unitId = unitId ?? this.unitId
      ..unitName = unitName ?? this.unitName
      ..selectMasterUnit = selectMasterUnit ?? this.selectMasterUnit
      ..masterUnitId = masterUnitId ?? this.masterUnitId
      ..masterUnitName = masterUnitName ?? this.masterUnitName
      ..slaveUnitId = slaveUnitId ?? this.slaveUnitId
      ..slaveUnitName = slaveUnitName ?? this.slaveUnitName
      ..number = number ?? this.number
      ..masterNumber = masterNumber ?? this.masterNumber
      ..slaveNumber = slaveNumber ?? this.slaveNumber
      ..price = price ?? this.price
      ..masterPrice = masterPrice ?? this.masterPrice
      ..slavePrice = slavePrice ?? this.slavePrice
      ..totalAmount = totalAmount ?? this.totalAmount;
  }
}