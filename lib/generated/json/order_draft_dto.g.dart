import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/draft/order_draft_dto.dart';
import 'package:decimal/decimal.dart';


OrderDraftDTO $OrderDraftDTOFromJson(Map<String, dynamic> json) {
  final OrderDraftDTO orderDraftDTO = OrderDraftDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    orderDraftDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    orderDraftDTO.ledgerId = ledgerId;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    orderDraftDTO.batchNo = batchNo;
  }
  final List<String>? productNameList = (json['productNameList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (productNameList != null) {
    orderDraftDTO.productNameList = productNameList;
  }
  final int? customId = jsonConvert.convert<int>(json['customId']);
  if (customId != null) {
    orderDraftDTO.customId = customId;
  }
  final String? customName = jsonConvert.convert<String>(json['customName']);
  if (customName != null) {
    orderDraftDTO.customName = customName;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    orderDraftDTO.totalAmount = totalAmount;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    orderDraftDTO.orderType = orderType;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    orderDraftDTO.gmtCreate = gmtCreate;
  }
  final DateTime? orderDate = jsonConvert.convert<DateTime>(json['orderDate']);
  if (orderDate != null) {
    orderDraftDTO.orderDate = orderDate;
  }
  return orderDraftDTO;
}

Map<String, dynamic> $OrderDraftDTOToJson(OrderDraftDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['batchNo'] = entity.batchNo;
  data['productNameList'] = entity.productNameList;
  data['customId'] = entity.customId;
  data['customName'] = entity.customName;
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['orderType'] = entity.orderType;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  data['orderDate'] = entity.orderDate?.toIso8601String();
  return data;
}

extension OrderDraftDTOExtension on OrderDraftDTO {
  OrderDraftDTO copyWith({
    int? id,
    int? ledgerId,
    String? batchNo,
    List<String>? productNameList,
    int? customId,
    String? customName,
    Decimal? totalAmount,
    int? orderType,
    DateTime? gmtCreate,
    DateTime? orderDate,
  }) {
    return OrderDraftDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..batchNo = batchNo ?? this.batchNo
      ..productNameList = productNameList ?? this.productNameList
      ..customId = customId ?? this.customId
      ..customName = customName ?? this.customName
      ..totalAmount = totalAmount ?? this.totalAmount
      ..orderType = orderType ?? this.orderType
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..orderDate = orderDate ?? this.orderDate;
  }
}