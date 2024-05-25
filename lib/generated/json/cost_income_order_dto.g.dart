import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/costIncome/cost_income_order_dto.dart';
import 'package:decimal/decimal.dart';


CostIncomeOrderDTO $CostIncomeOrderDTOFromJson(Map<String, dynamic> json) {
  final CostIncomeOrderDTO costIncomeOrderDTO = CostIncomeOrderDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    costIncomeOrderDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    costIncomeOrderDTO.ledgerId = ledgerId;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    costIncomeOrderDTO.orderType = orderType;
  }
  final int? discount = jsonConvert.convert<int>(json['discount']);
  if (discount != null) {
    costIncomeOrderDTO.discount = discount;
  }
  final int? labelId = jsonConvert.convert<int>(json['labelId']);
  if (labelId != null) {
    costIncomeOrderDTO.labelId = labelId;
  }
  final String? labelName = jsonConvert.convert<String>(json['labelName']);
  if (labelName != null) {
    costIncomeOrderDTO.labelName = labelName;
  }
  final String? costIncomeName = jsonConvert.convert<String>(
      json['costIncomeName']);
  if (costIncomeName != null) {
    costIncomeOrderDTO.costIncomeName = costIncomeName;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    costIncomeOrderDTO.totalAmount = totalAmount;
  }
  final List<int>? productIdList = (json['productIdList'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (productIdList != null) {
    costIncomeOrderDTO.productIdList = productIdList;
  }
  final List<String>? productNameList = (json['productNameList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (productNameList != null) {
    costIncomeOrderDTO.productNameList = productNameList;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    costIncomeOrderDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    costIncomeOrderDTO.creatorName = creatorName;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    costIncomeOrderDTO.invalid = invalid;
  }
  final DateTime? orderDate = jsonConvert.convert<DateTime>(json['orderDate']);
  if (orderDate != null) {
    costIncomeOrderDTO.orderDate = orderDate;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    costIncomeOrderDTO.gmtCreate = gmtCreate;
  }
  final bool? showDateTime = jsonConvert.convert<bool>(json['showDateTime']);
  if (showDateTime != null) {
    costIncomeOrderDTO.showDateTime = showDateTime;
  }
  return costIncomeOrderDTO;
}

Map<String, dynamic> $CostIncomeOrderDTOToJson(CostIncomeOrderDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['orderType'] = entity.orderType;
  data['discount'] = entity.discount;
  data['labelId'] = entity.labelId;
  data['labelName'] = entity.labelName;
  data['costIncomeName'] = entity.costIncomeName;
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['productIdList'] = entity.productIdList;
  data['productNameList'] = entity.productNameList;
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['invalid'] = entity.invalid;
  data['orderDate'] = entity.orderDate?.toIso8601String();
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  data['showDateTime'] = entity.showDateTime;
  return data;
}

extension CostIncomeOrderDTOExtension on CostIncomeOrderDTO {
  CostIncomeOrderDTO copyWith({
    int? id,
    int? ledgerId,
    int? orderType,
    int? discount,
    int? labelId,
    String? labelName,
    String? costIncomeName,
    Decimal? totalAmount,
    List<int>? productIdList,
    List<String>? productNameList,
    int? creator,
    String? creatorName,
    int? invalid,
    DateTime? orderDate,
    DateTime? gmtCreate,
    bool? showDateTime,
  }) {
    return CostIncomeOrderDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..orderType = orderType ?? this.orderType
      ..discount = discount ?? this.discount
      ..labelId = labelId ?? this.labelId
      ..labelName = labelName ?? this.labelName
      ..costIncomeName = costIncomeName ?? this.costIncomeName
      ..totalAmount = totalAmount ?? this.totalAmount
      ..productIdList = productIdList ?? this.productIdList
      ..productNameList = productNameList ?? this.productNameList
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..invalid = invalid ?? this.invalid
      ..orderDate = orderDate ?? this.orderDate
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..showDateTime = showDateTime ?? this.showDateTime;
  }
}