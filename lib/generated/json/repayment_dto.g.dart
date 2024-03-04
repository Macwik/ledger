import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/repayment/repayment_dto.dart';
import 'package:decimal/decimal.dart';


RepaymentDTO $RepaymentDTOFromJson(Map<String, dynamic> json) {
  final RepaymentDTO repaymentDTO = RepaymentDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    repaymentDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    repaymentDTO.ledgerId = ledgerId;
  }
  final int? customId = jsonConvert.convert<int>(json['customId']);
  if (customId != null) {
    repaymentDTO.customId = customId;
  }
  final String? customName = jsonConvert.convert<String>(json['customName']);
  if (customName != null) {
    repaymentDTO.customName = customName;
  }
  final DateTime? repaymentDate = jsonConvert.convert<DateTime>(
      json['repaymentDate']);
  if (repaymentDate != null) {
    repaymentDTO.repaymentDate = repaymentDate;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    repaymentDTO.totalAmount = totalAmount;
  }
  final Decimal? remainingAmount = jsonConvert.convert<Decimal>(
      json['remainingAmount']);
  if (remainingAmount != null) {
    repaymentDTO.remainingAmount = remainingAmount;
  }
  final Decimal? discountAmount = jsonConvert.convert<Decimal>(
      json['discountAmount']);
  if (discountAmount != null) {
    repaymentDTO.discountAmount = discountAmount;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    repaymentDTO.invalid = invalid;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    repaymentDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    repaymentDTO.creatorName = creatorName;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    repaymentDTO.gmtCreate = gmtCreate;
  }
  return repaymentDTO;
}

Map<String, dynamic> $RepaymentDTOToJson(RepaymentDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['customId'] = entity.customId;
  data['customName'] = entity.customName;
  data['repaymentDate'] = entity.repaymentDate?.toIso8601String();
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['remainingAmount'] = entity.remainingAmount?.toJson();
  data['discountAmount'] = entity.discountAmount?.toJson();
  data['invalid'] = entity.invalid;
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  return data;
}

extension RepaymentDTOExtension on RepaymentDTO {
  RepaymentDTO copyWith({
    int? id,
    int? ledgerId,
    int? customId,
    String? customName,
    DateTime? repaymentDate,
    Decimal? totalAmount,
    Decimal? remainingAmount,
    Decimal? discountAmount,
    int? invalid,
    int? creator,
    String? creatorName,
    DateTime? gmtCreate,
  }) {
    return RepaymentDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..customId = customId ?? this.customId
      ..customName = customName ?? this.customName
      ..repaymentDate = repaymentDate ?? this.repaymentDate
      ..totalAmount = totalAmount ?? this.totalAmount
      ..remainingAmount = remainingAmount ?? this.remainingAmount
      ..discountAmount = discountAmount ?? this.discountAmount
      ..invalid = invalid ?? this.invalid
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..gmtCreate = gmtCreate ?? this.gmtCreate;
  }
}