import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/draft/order_draft_detail_dto.dart';
import 'package:ledger/entity/order/order_product_detail_dto.dart';

import 'package:ledger/entity/product/product_shopping_car_dto.dart';

import 'package:ledger/entity/custom/custom_dto.dart';

import 'package:decimal/decimal.dart';


OrderDraftDetailDTO $OrderDraftDetailDTOFromJson(Map<String, dynamic> json) {
  final OrderDraftDetailDTO orderDraftDetailDTO = OrderDraftDetailDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    orderDraftDetailDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    orderDraftDetailDTO.ledgerId = ledgerId;
  }
  final CustomDTO? customDTO = jsonConvert.convert<CustomDTO>(
      json['customDTO']);
  if (customDTO != null) {
    orderDraftDetailDTO.customDTO = customDTO;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    orderDraftDetailDTO.totalAmount = totalAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    orderDraftDetailDTO.batchNo = batchNo;
  }
  final List<
      ProductShoppingCarDTO>? shoppingCarList = (json['shoppingCarList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ProductShoppingCarDTO>(e) as ProductShoppingCarDTO)
      .toList();
  if (shoppingCarList != null) {
    orderDraftDetailDTO.shoppingCarList = shoppingCarList;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    orderDraftDetailDTO.orderType = orderType;
  }
  final DateTime? orderDate = jsonConvert.convert<DateTime>(json['orderDate']);
  if (orderDate != null) {
    orderDraftDetailDTO.orderDate = orderDate;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    orderDraftDetailDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    orderDraftDetailDTO.creatorName = creatorName;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    orderDraftDetailDTO.remark = remark;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    orderDraftDetailDTO.gmtCreate = gmtCreate;
  }
  return orderDraftDetailDTO;
}

Map<String, dynamic> $OrderDraftDetailDTOToJson(OrderDraftDetailDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['customDTO'] = entity.customDTO?.toJson();
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['batchNo'] = entity.batchNo;
  data['shoppingCarList'] =
      entity.shoppingCarList?.map((v) => v.toJson()).toList();
  data['orderType'] = entity.orderType;
  data['orderDate'] = entity.orderDate?.toIso8601String();
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['remark'] = entity.remark;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  return data;
}

extension OrderDraftDetailDTOExtension on OrderDraftDetailDTO {
  OrderDraftDetailDTO copyWith({
    int? id,
    int? ledgerId,
    CustomDTO? customDTO,
    Decimal? totalAmount,
    String? batchNo,
    List<ProductShoppingCarDTO>? shoppingCarList,
    int? orderType,
    DateTime? orderDate,
    int? creator,
    String? creatorName,
    String? remark,
    DateTime? gmtCreate,
  }) {
    return OrderDraftDetailDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..customDTO = customDTO ?? this.customDTO
      ..totalAmount = totalAmount ?? this.totalAmount
      ..batchNo = batchNo ?? this.batchNo
      ..shoppingCarList = shoppingCarList ?? this.shoppingCarList
      ..orderType = orderType ?? this.orderType
      ..orderDate = orderDate ?? this.orderDate
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..remark = remark ?? this.remark
      ..gmtCreate = gmtCreate ?? this.gmtCreate;
  }
}