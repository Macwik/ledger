import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/repayment/repayment_bind_order_dto.dart';
import 'package:decimal/decimal.dart';


RepaymentBindOrderDTO $RepaymentBindOrderDTOFromJson(
    Map<String, dynamic> json) {
  final RepaymentBindOrderDTO repaymentBindOrderDTO = RepaymentBindOrderDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    repaymentBindOrderDTO.id = id;
  }
  final int? customCreditId = jsonConvert.convert<int>(json['customCreditId']);
  if (customCreditId != null) {
    repaymentBindOrderDTO.customCreditId = customCreditId;
  }
  final Decimal? creditAmount = jsonConvert.convert<Decimal>(
      json['creditAmount']);
  if (creditAmount != null) {
    repaymentBindOrderDTO.creditAmount = creditAmount;
  }
  final int? creditType = jsonConvert.convert<int>(json['creditType']);
  if (creditType != null) {
    repaymentBindOrderDTO.creditType = creditType;
  }
  final int? salesOrderId = jsonConvert.convert<int>(json['salesOrderId']);
  if (salesOrderId != null) {
    repaymentBindOrderDTO.salesOrderId = salesOrderId;
  }
  final Decimal? repaymentAmount = jsonConvert.convert<Decimal>(
      json['repaymentAmount']);
  if (repaymentAmount != null) {
    repaymentBindOrderDTO.repaymentAmount = repaymentAmount;
  }
  final List<int>? productIdList = (json['productIdList'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (productIdList != null) {
    repaymentBindOrderDTO.productIdList = productIdList;
  }
  final List<String>? productNameList = (json['productNameList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (productNameList != null) {
    repaymentBindOrderDTO.productNameList = productNameList;
  }
  final DateTime? creditDate = jsonConvert.convert<DateTime>(
      json['creditDate']);
  if (creditDate != null) {
    repaymentBindOrderDTO.creditDate = creditDate;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    repaymentBindOrderDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    repaymentBindOrderDTO.creatorName = creatorName;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    repaymentBindOrderDTO.gmtCreate = gmtCreate;
  }
  return repaymentBindOrderDTO;
}

Map<String, dynamic> $RepaymentBindOrderDTOToJson(
    RepaymentBindOrderDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['customCreditId'] = entity.customCreditId;
  data['creditAmount'] = entity.creditAmount?.toJson();
  data['creditType'] = entity.creditType;
  data['salesOrderId'] = entity.salesOrderId;
  data['repaymentAmount'] = entity.repaymentAmount?.toJson();
  data['productIdList'] = entity.productIdList;
  data['productNameList'] = entity.productNameList;
  data['creditDate'] = entity.creditDate?.toIso8601String();
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  return data;
}

extension RepaymentBindOrderDTOExtension on RepaymentBindOrderDTO {
  RepaymentBindOrderDTO copyWith({
    int? id,
    int? customCreditId,
    Decimal? creditAmount,
    int? creditType,
    int? salesOrderId,
    Decimal? repaymentAmount,
    List<int>? productIdList,
    List<String>? productNameList,
    DateTime? creditDate,
    int? creator,
    String? creatorName,
    DateTime? gmtCreate,
  }) {
    return RepaymentBindOrderDTO()
      ..id = id ?? this.id
      ..customCreditId = customCreditId ?? this.customCreditId
      ..creditAmount = creditAmount ?? this.creditAmount
      ..creditType = creditType ?? this.creditType
      ..salesOrderId = salesOrderId ?? this.salesOrderId
      ..repaymentAmount = repaymentAmount ?? this.repaymentAmount
      ..productIdList = productIdList ?? this.productIdList
      ..productNameList = productNameList ?? this.productNameList
      ..creditDate = creditDate ?? this.creditDate
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..gmtCreate = gmtCreate ?? this.gmtCreate;
  }
}