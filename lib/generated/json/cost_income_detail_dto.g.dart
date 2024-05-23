import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/costIncome/cost_income_detail_dto.dart';
import 'package:decimal/decimal.dart';

import 'package:ledger/entity/product/product_dto.dart';

import 'package:ledger/entity/order/order_payment_dto.dart';

import 'package:ledger/entity/order/order_dto.dart';


CostIncomeDetailDTO $CostIncomeDetailDTOFromJson(Map<String, dynamic> json) {
  final CostIncomeDetailDTO costIncomeDetailDTO = CostIncomeDetailDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    costIncomeDetailDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    costIncomeDetailDTO.ledgerId = ledgerId;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    costIncomeDetailDTO.orderType = orderType;
  }
  final int? discount = jsonConvert.convert<int>(json['discount']);
  if (discount != null) {
    costIncomeDetailDTO.discount = discount;
  }
  final int? labelId = jsonConvert.convert<int>(json['labelId']);
  if (labelId != null) {
    costIncomeDetailDTO.labelId = labelId;
  }
  final String? labelName = jsonConvert.convert<String>(json['labelName']);
  if (labelName != null) {
    costIncomeDetailDTO.labelName = labelName;
  }
  final String? costIncomeName = jsonConvert.convert<String>(
      json['costIncomeName']);
  if (costIncomeName != null) {
    costIncomeDetailDTO.costIncomeName = costIncomeName;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    costIncomeDetailDTO.totalAmount = totalAmount;
  }
  final int? salesOrderId = jsonConvert.convert<int>(json['salesOrderId']);
  if (salesOrderId != null) {
    costIncomeDetailDTO.salesOrderId = salesOrderId;
  }
  final String? salesOrderNo = jsonConvert.convert<String>(
      json['salesOrderNo']);
  if (salesOrderNo != null) {
    costIncomeDetailDTO.salesOrderNo = salesOrderNo;
  }
  final int? salesOrderType = jsonConvert.convert<int>(json['salesOrderType']);
  if (salesOrderType != null) {
    costIncomeDetailDTO.salesOrderType = salesOrderType;
  }
  final List<int>? productIdList = (json['productIdList'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (productIdList != null) {
    costIncomeDetailDTO.productIdList = productIdList;
  }
  final List<String>? productNameList = (json['productNameList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (productNameList != null) {
    costIncomeDetailDTO.productNameList = productNameList;
  }
  final List<OrderPaymentDTO>? paymentDTOList = (json['paymentDTOList'] as List<
      dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<OrderPaymentDTO>(e) as OrderPaymentDTO)
      .toList();
  if (paymentDTOList != null) {
    costIncomeDetailDTO.paymentDTOList = paymentDTOList;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    costIncomeDetailDTO.remark = remark;
  }
  final DateTime? orderDate = jsonConvert.convert<DateTime>(json['orderDate']);
  if (orderDate != null) {
    costIncomeDetailDTO.orderDate = orderDate;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    costIncomeDetailDTO.invalid = invalid;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    costIncomeDetailDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    costIncomeDetailDTO.creatorName = creatorName;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    costIncomeDetailDTO.gmtCreate = gmtCreate;
  }
  return costIncomeDetailDTO;
}

Map<String, dynamic> $CostIncomeDetailDTOToJson(CostIncomeDetailDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['orderType'] = entity.orderType;
  data['discount'] = entity.discount;
  data['labelId'] = entity.labelId;
  data['labelName'] = entity.labelName;
  data['costIncomeName'] = entity.costIncomeName;
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['salesOrderId'] = entity.salesOrderId;
  data['salesOrderNo'] = entity.salesOrderNo;
  data['salesOrderType'] = entity.salesOrderType;
  data['productIdList'] = entity.productIdList;
  data['productNameList'] = entity.productNameList;
  data['paymentDTOList'] =
      entity.paymentDTOList?.map((v) => v.toJson()).toList();
  data['remark'] = entity.remark;
  data['orderDate'] = entity.orderDate?.toIso8601String();
  data['invalid'] = entity.invalid;
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  return data;
}

extension CostIncomeDetailDTOExtension on CostIncomeDetailDTO {
  CostIncomeDetailDTO copyWith({
    int? id,
    int? ledgerId,
    int? orderType,
    int? discount,
    int? labelId,
    String? labelName,
    String? costIncomeName,
    Decimal? totalAmount,
    int? salesOrderId,
    String? salesOrderNo,
    int? salesOrderType,
    List<int>? productIdList,
    List<String>? productNameList,
    List<OrderPaymentDTO>? paymentDTOList,
    String? remark,
    DateTime? orderDate,
    int? invalid,
    int? creator,
    String? creatorName,
    DateTime? gmtCreate,
  }) {
    return CostIncomeDetailDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..orderType = orderType ?? this.orderType
      ..discount = discount ?? this.discount
      ..labelId = labelId ?? this.labelId
      ..labelName = labelName ?? this.labelName
      ..costIncomeName = costIncomeName ?? this.costIncomeName
      ..totalAmount = totalAmount ?? this.totalAmount
      ..salesOrderId = salesOrderId ?? this.salesOrderId
      ..salesOrderNo = salesOrderNo ?? this.salesOrderNo
      ..salesOrderType = salesOrderType ?? this.salesOrderType
      ..productIdList = productIdList ?? this.productIdList
      ..productNameList = productNameList ?? this.productNameList
      ..paymentDTOList = paymentDTOList ?? this.paymentDTOList
      ..remark = remark ?? this.remark
      ..orderDate = orderDate ?? this.orderDate
      ..invalid = invalid ?? this.invalid
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..gmtCreate = gmtCreate ?? this.gmtCreate;
  }
}