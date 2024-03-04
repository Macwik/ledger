import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/remittance/remittance_dto.dart';
import 'package:ledger/entity/remittance/payment_dto.dart';

import 'package:decimal/decimal.dart';


RemittanceDTO $RemittanceDTOFromJson(Map<String, dynamic> json) {
  final RemittanceDTO remittanceDTO = RemittanceDTO();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    remittanceDTO.ledgerId = ledgerId;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    remittanceDTO.id = id;
  }
  final Decimal? amount = jsonConvert.convert<Decimal>(json['amount']);
  if (amount != null) {
    remittanceDTO.amount = amount;
  }
  final String? receiver = jsonConvert.convert<String>(json['receiver']);
  if (receiver != null) {
    remittanceDTO.receiver = receiver;
  }
  final List<PaymentDTO>? paymentDTO = (json['paymentDTO'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<PaymentDTO>(e) as PaymentDTO)
      .toList();
  if (paymentDTO != null) {
    remittanceDTO.paymentDTO = paymentDTO;
  }
  final List<int>? productId = (json['productId'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (productId != null) {
    remittanceDTO.productId = productId;
  }
  final List<String>? productNameList = (json['productNameList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (productNameList != null) {
    remittanceDTO.productNameList = productNameList;
  }
  final DateTime? remittanceDate = jsonConvert.convert<DateTime>(
      json['remittanceDate']);
  if (remittanceDate != null) {
    remittanceDTO.remittanceDate = remittanceDate;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    remittanceDTO.invalid = invalid;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    remittanceDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    remittanceDTO.creatorName = creatorName;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    remittanceDTO.gmtCreate = gmtCreate;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    remittanceDTO.remark = remark;
  }
  return remittanceDTO;
}

Map<String, dynamic> $RemittanceDTOToJson(RemittanceDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['id'] = entity.id;
  data['amount'] = entity.amount?.toJson();
  data['receiver'] = entity.receiver;
  data['paymentDTO'] = entity.paymentDTO?.map((v) => v.toJson()).toList();
  data['productId'] = entity.productId;
  data['productNameList'] = entity.productNameList;
  data['remittanceDate'] = entity.remittanceDate?.toIso8601String();
  data['invalid'] = entity.invalid;
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  data['remark'] = entity.remark;
  return data;
}

extension RemittanceDTOExtension on RemittanceDTO {
  RemittanceDTO copyWith({
    int? ledgerId,
    int? id,
    Decimal? amount,
    String? receiver,
    List<PaymentDTO>? paymentDTO,
    List<int>? productId,
    List<String>? productNameList,
    DateTime? remittanceDate,
    int? invalid,
    int? creator,
    String? creatorName,
    DateTime? gmtCreate,
    String? remark,
  }) {
    return RemittanceDTO()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..id = id ?? this.id
      ..amount = amount ?? this.amount
      ..receiver = receiver ?? this.receiver
      ..paymentDTO = paymentDTO ?? this.paymentDTO
      ..productId = productId ?? this.productId
      ..productNameList = productNameList ?? this.productNameList
      ..remittanceDate = remittanceDate ?? this.remittanceDate
      ..invalid = invalid ?? this.invalid
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..remark = remark ?? this.remark;
  }
}