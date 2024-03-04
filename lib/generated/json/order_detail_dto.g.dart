import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/order/order_detail_dto.dart';
import 'package:ledger/entity/order/order_payment_dto.dart';

import 'package:ledger/entity/order/order_product_detail_dto.dart';

import 'package:ledger/entity/statistics/external_order_base_dto.dart';

import 'package:decimal/decimal.dart';


OrderDetailDTO $OrderDetailDTOFromJson(Map<String, dynamic> json) {
  final OrderDetailDTO orderDetailDTO = OrderDetailDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    orderDetailDTO.id = id;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    orderDetailDTO.orderNo = orderNo;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    orderDetailDTO.ledgerId = ledgerId;
  }
  final int? customId = jsonConvert.convert<int>(json['customId']);
  if (customId != null) {
    orderDetailDTO.customId = customId;
  }
  final String? customName = jsonConvert.convert<String>(json['customName']);
  if (customName != null) {
    orderDetailDTO.customName = customName;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    orderDetailDTO.totalAmount = totalAmount;
  }
  final Decimal? creditAmount = jsonConvert.convert<Decimal>(
      json['creditAmount']);
  if (creditAmount != null) {
    orderDetailDTO.creditAmount = creditAmount;
  }
  final Decimal? discountAmount = jsonConvert.convert<Decimal>(
      json['discountAmount']);
  if (discountAmount != null) {
    orderDetailDTO.discountAmount = discountAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    orderDetailDTO.batchNo = batchNo;
  }
  final List<
      OrderProductDetail>? orderProductDetailList = (json['orderProductDetailList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<OrderProductDetail>(e) as OrderProductDetail)
      .toList();
  if (orderProductDetailList != null) {
    orderDetailDTO.orderProductDetailList = orderProductDetailList;
  }
  final List<
      OrderPaymentDTO>? orderPaymentList = (json['orderPaymentList'] as List<
      dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<OrderPaymentDTO>(e) as OrderPaymentDTO)
      .toList();
  if (orderPaymentList != null) {
    orderDetailDTO.orderPaymentList = orderPaymentList;
  }
  final DateTime? orderDate = jsonConvert.convert<DateTime>(json['orderDate']);
  if (orderDate != null) {
    orderDetailDTO.orderDate = orderDate;
  }
  final int? orderStatus = jsonConvert.convert<int>(json['orderStatus']);
  if (orderStatus != null) {
    orderDetailDTO.orderStatus = orderStatus;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    orderDetailDTO.invalid = invalid;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    orderDetailDTO.orderType = orderType;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    orderDetailDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    orderDetailDTO.creatorName = creatorName;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    orderDetailDTO.remark = remark;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    orderDetailDTO.gmtCreate = gmtCreate;
  }
  final List<
      ExternalOrderBaseDTO>? externalOrderBaseDTOList = (json['externalOrderBaseDTOList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ExternalOrderBaseDTO>(e) as ExternalOrderBaseDTO)
      .toList();
  if (externalOrderBaseDTOList != null) {
    orderDetailDTO.externalOrderBaseDTOList = externalOrderBaseDTOList;
  }
  return orderDetailDTO;
}

Map<String, dynamic> $OrderDetailDTOToJson(OrderDetailDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['orderNo'] = entity.orderNo;
  data['ledgerId'] = entity.ledgerId;
  data['customId'] = entity.customId;
  data['customName'] = entity.customName;
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['creditAmount'] = entity.creditAmount?.toJson();
  data['discountAmount'] = entity.discountAmount?.toJson();
  data['batchNo'] = entity.batchNo;
  data['orderProductDetailList'] =
      entity.orderProductDetailList?.map((v) => v.toJson()).toList();
  data['orderPaymentList'] =
      entity.orderPaymentList?.map((v) => v.toJson()).toList();
  data['orderDate'] = entity.orderDate?.toIso8601String();
  data['orderStatus'] = entity.orderStatus;
  data['invalid'] = entity.invalid;
  data['orderType'] = entity.orderType;
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['remark'] = entity.remark;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  data['externalOrderBaseDTOList'] =
      entity.externalOrderBaseDTOList?.map((v) => v.toJson()).toList();
  return data;
}

extension OrderDetailDTOExtension on OrderDetailDTO {
  OrderDetailDTO copyWith({
    int? id,
    String? orderNo,
    int? ledgerId,
    int? customId,
    String? customName,
    Decimal? totalAmount,
    Decimal? creditAmount,
    Decimal? discountAmount,
    String? batchNo,
    List<OrderProductDetail>? orderProductDetailList,
    List<OrderPaymentDTO>? orderPaymentList,
    DateTime? orderDate,
    int? orderStatus,
    int? invalid,
    int? orderType,
    int? creator,
    String? creatorName,
    String? remark,
    DateTime? gmtCreate,
    List<ExternalOrderBaseDTO>? externalOrderBaseDTOList,
  }) {
    return OrderDetailDTO()
      ..id = id ?? this.id
      ..orderNo = orderNo ?? this.orderNo
      ..ledgerId = ledgerId ?? this.ledgerId
      ..customId = customId ?? this.customId
      ..customName = customName ?? this.customName
      ..totalAmount = totalAmount ?? this.totalAmount
      ..creditAmount = creditAmount ?? this.creditAmount
      ..discountAmount = discountAmount ?? this.discountAmount
      ..batchNo = batchNo ?? this.batchNo
      ..orderProductDetailList = orderProductDetailList ??
          this.orderProductDetailList
      ..orderPaymentList = orderPaymentList ?? this.orderPaymentList
      ..orderDate = orderDate ?? this.orderDate
      ..orderStatus = orderStatus ?? this.orderStatus
      ..invalid = invalid ?? this.invalid
      ..orderType = orderType ?? this.orderType
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..remark = remark ?? this.remark
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..externalOrderBaseDTOList = externalOrderBaseDTOList ??
          this.externalOrderBaseDTOList;
  }
}