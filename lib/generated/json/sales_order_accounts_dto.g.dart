import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/statistics/sales_order_accounts_dto.dart';
import 'package:decimal/decimal.dart';


SalesOrderAccountsDTO $SalesOrderAccountsDTOFromJson(
    Map<String, dynamic> json) {
  final SalesOrderAccountsDTO salesOrderAccountsDTO = SalesOrderAccountsDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    salesOrderAccountsDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    salesOrderAccountsDTO.ledgerId = ledgerId;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    salesOrderAccountsDTO.orderType = orderType;
  }
  final int? orderId = jsonConvert.convert<int>(json['orderId']);
  if (orderId != null) {
    salesOrderAccountsDTO.orderId = orderId;
  }
  final int? customId = jsonConvert.convert<int>(json['customId']);
  if (customId != null) {
    salesOrderAccountsDTO.customId = customId;
  }
  final List<String>? productNameList = (json['productNameList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (productNameList != null) {
    salesOrderAccountsDTO.productNameList = productNameList;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    salesOrderAccountsDTO.totalAmount = totalAmount;
  }
  final Decimal? actualAmount = jsonConvert.convert<Decimal>(
      json['actualAmount']);
  if (actualAmount != null) {
    salesOrderAccountsDTO.actualAmount = actualAmount;
  }
  final Decimal? creditAmount = jsonConvert.convert<Decimal>(
      json['creditAmount']);
  if (creditAmount != null) {
    salesOrderAccountsDTO.creditAmount = creditAmount;
  }
  final Decimal? discountAmount = jsonConvert.convert<Decimal>(
      json['discountAmount']);
  if (discountAmount != null) {
    salesOrderAccountsDTO.discountAmount = discountAmount;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    salesOrderAccountsDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    salesOrderAccountsDTO.creatorName = creatorName;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    salesOrderAccountsDTO.invalid = invalid;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    salesOrderAccountsDTO.gmtCreate = gmtCreate;
  }
  return salesOrderAccountsDTO;
}

Map<String, dynamic> $SalesOrderAccountsDTOToJson(
    SalesOrderAccountsDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['orderType'] = entity.orderType;
  data['orderId'] = entity.orderId;
  data['customId'] = entity.customId;
  data['productNameList'] = entity.productNameList;
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['actualAmount'] = entity.actualAmount?.toJson();
  data['creditAmount'] = entity.creditAmount?.toJson();
  data['discountAmount'] = entity.discountAmount?.toJson();
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['invalid'] = entity.invalid;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  return data;
}

extension SalesOrderAccountsDTOExtension on SalesOrderAccountsDTO {
  SalesOrderAccountsDTO copyWith({
    int? id,
    int? ledgerId,
    int? orderType,
    int? orderId,
    int? customId,
    List<String>? productNameList,
    Decimal? totalAmount,
    Decimal? actualAmount,
    Decimal? creditAmount,
    Decimal? discountAmount,
    int? creator,
    String? creatorName,
    int? invalid,
    DateTime? gmtCreate,
  }) {
    return SalesOrderAccountsDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..orderType = orderType ?? this.orderType
      ..orderId = orderId ?? this.orderId
      ..customId = customId ?? this.customId
      ..productNameList = productNameList ?? this.productNameList
      ..totalAmount = totalAmount ?? this.totalAmount
      ..actualAmount = actualAmount ?? this.actualAmount
      ..creditAmount = creditAmount ?? this.creditAmount
      ..discountAmount = discountAmount ?? this.discountAmount
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..invalid = invalid ?? this.invalid
      ..gmtCreate = gmtCreate ?? this.gmtCreate;
  }
}