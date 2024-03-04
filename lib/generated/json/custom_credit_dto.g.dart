import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/repayment/custom_credit_dto.dart';
import 'package:decimal/decimal.dart';


CustomCreditDTO $CustomCreditDTOFromJson(Map<String, dynamic> json) {
  final CustomCreditDTO customCreditDTO = CustomCreditDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    customCreditDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    customCreditDTO.ledgerId = ledgerId;
  }
  final int? customId = jsonConvert.convert<int>(json['customId']);
  if (customId != null) {
    customCreditDTO.customId = customId;
  }
  final int? customType = jsonConvert.convert<int>(json['customType']);
  if (customType != null) {
    customCreditDTO.customType = customType;
  }
  final int? creditType = jsonConvert.convert<int>(json['creditType']);
  if (creditType != null) {
    customCreditDTO.creditType = creditType;
  }
  final DateTime? creditDate = jsonConvert.convert<DateTime>(
      json['creditDate']);
  if (creditDate != null) {
    customCreditDTO.creditDate = creditDate;
  }
  final String? customName = jsonConvert.convert<String>(json['customName']);
  if (customName != null) {
    customCreditDTO.customName = customName;
  }
  final int? orderId = jsonConvert.convert<int>(json['orderId']);
  if (orderId != null) {
    customCreditDTO.orderId = orderId;
  }
  final List<String>? productNameList = (json['productNameList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (productNameList != null) {
    customCreditDTO.productNameList = productNameList;
  }
  final Decimal? creditAmount = jsonConvert.convert<Decimal>(
      json['creditAmount']);
  if (creditAmount != null) {
    customCreditDTO.creditAmount = creditAmount;
  }
  final Decimal? repaymentAmount = jsonConvert.convert<Decimal>(
      json['repaymentAmount']);
  if (repaymentAmount != null) {
    customCreditDTO.repaymentAmount = repaymentAmount;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    customCreditDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    customCreditDTO.creatorName = creatorName;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    customCreditDTO.gmtCreate = gmtCreate;
  }
  return customCreditDTO;
}

Map<String, dynamic> $CustomCreditDTOToJson(CustomCreditDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['customId'] = entity.customId;
  data['customType'] = entity.customType;
  data['creditType'] = entity.creditType;
  data['creditDate'] = entity.creditDate?.toIso8601String();
  data['customName'] = entity.customName;
  data['orderId'] = entity.orderId;
  data['productNameList'] = entity.productNameList;
  data['creditAmount'] = entity.creditAmount?.toJson();
  data['repaymentAmount'] = entity.repaymentAmount?.toJson();
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  return data;
}

extension CustomCreditDTOExtension on CustomCreditDTO {
  CustomCreditDTO copyWith({
    int? id,
    int? ledgerId,
    int? customId,
    int? customType,
    int? creditType,
    DateTime? creditDate,
    String? customName,
    int? orderId,
    List<String>? productNameList,
    Decimal? creditAmount,
    Decimal? repaymentAmount,
    int? creator,
    String? creatorName,
    DateTime? gmtCreate,
  }) {
    return CustomCreditDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..customId = customId ?? this.customId
      ..customType = customType ?? this.customType
      ..creditType = creditType ?? this.creditType
      ..creditDate = creditDate ?? this.creditDate
      ..customName = customName ?? this.customName
      ..orderId = orderId ?? this.orderId
      ..productNameList = productNameList ?? this.productNameList
      ..creditAmount = creditAmount ?? this.creditAmount
      ..repaymentAmount = repaymentAmount ?? this.repaymentAmount
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..gmtCreate = gmtCreate ?? this.gmtCreate;
  }
}