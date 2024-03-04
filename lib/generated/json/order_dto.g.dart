import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/order/order_dto.dart';
import 'package:decimal/decimal.dart';

import 'package:intl/intl.dart';


OrderDTO $OrderDTOFromJson(Map<String, dynamic> json) {
  final OrderDTO orderDTO = OrderDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    orderDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    orderDTO.ledgerId = ledgerId;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    orderDTO.orderNo = orderNo;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    orderDTO.batchNo = batchNo;
  }
  final List<String>? productNameList = (json['productNameList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (productNameList != null) {
    orderDTO.productNameList = productNameList;
  }
  final int? customId = jsonConvert.convert<int>(json['customId']);
  if (customId != null) {
    orderDTO.customId = customId;
  }
  final String? customName = jsonConvert.convert<String>(json['customName']);
  if (customName != null) {
    orderDTO.customName = customName;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    orderDTO.totalAmount = totalAmount;
  }
  final Decimal? creditAmount = jsonConvert.convert<Decimal>(
      json['creditAmount']);
  if (creditAmount != null) {
    orderDTO.creditAmount = creditAmount;
  }
  final Decimal? discountAmount = jsonConvert.convert<Decimal>(
      json['discountAmount']);
  if (discountAmount != null) {
    orderDTO.discountAmount = discountAmount;
  }
  final Decimal? repaymentDiscountAmount = jsonConvert.convert<Decimal>(
      json['repaymentDiscountAmount']);
  if (repaymentDiscountAmount != null) {
    orderDTO.repaymentDiscountAmount = repaymentDiscountAmount;
  }
  final DateTime? orderDate = jsonConvert.convert<DateTime>(json['orderDate']);
  if (orderDate != null) {
    orderDTO.orderDate = orderDate;
  }
  final int? orderStatus = jsonConvert.convert<int>(json['orderStatus']);
  if (orderStatus != null) {
    orderDTO.orderStatus = orderStatus;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    orderDTO.orderType = orderType;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    orderDTO.invalid = invalid;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    orderDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    orderDTO.creatorName = creatorName;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    orderDTO.gmtCreate = gmtCreate;
  }
  return orderDTO;
}

Map<String, dynamic> $OrderDTOToJson(OrderDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['orderNo'] = entity.orderNo;
  data['batchNo'] = entity.batchNo;
  data['productNameList'] = entity.productNameList;
  data['customId'] = entity.customId;
  data['customName'] = entity.customName;
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['creditAmount'] = entity.creditAmount?.toJson();
  data['discountAmount'] = entity.discountAmount?.toJson();
  data['repaymentDiscountAmount'] = entity.repaymentDiscountAmount?.toJson();
  data['orderDate'] = entity.orderDate?.toIso8601String();
  data['orderStatus'] = entity.orderStatus;
  data['orderType'] = entity.orderType;
  data['invalid'] = entity.invalid;
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  return data;
}

extension OrderDTOExtension on OrderDTO {
  OrderDTO copyWith({
    int? id,
    int? ledgerId,
    String? orderNo,
    String? batchNo,
    List<String>? productNameList,
    int? customId,
    String? customName,
    Decimal? totalAmount,
    Decimal? creditAmount,
    Decimal? discountAmount,
    Decimal? repaymentDiscountAmount,
    DateTime? orderDate,
    int? orderStatus,
    int? orderType,
    int? invalid,
    int? creator,
    String? creatorName,
    DateTime? gmtCreate,
  }) {
    return OrderDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..orderNo = orderNo ?? this.orderNo
      ..batchNo = batchNo ?? this.batchNo
      ..productNameList = productNameList ?? this.productNameList
      ..customId = customId ?? this.customId
      ..customName = customName ?? this.customName
      ..totalAmount = totalAmount ?? this.totalAmount
      ..creditAmount = creditAmount ?? this.creditAmount
      ..discountAmount = discountAmount ?? this.discountAmount
      ..repaymentDiscountAmount = repaymentDiscountAmount ??
          this.repaymentDiscountAmount
      ..orderDate = orderDate ?? this.orderDate
      ..orderStatus = orderStatus ?? this.orderStatus
      ..orderType = orderType ?? this.orderType
      ..invalid = invalid ?? this.invalid
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..gmtCreate = gmtCreate ?? this.gmtCreate;
  }
}