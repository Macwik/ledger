import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/remittance/remittance_detail_dto.dart';
import 'package:ledger/entity/remittance/payment_dto.dart';

import 'package:decimal/decimal.dart';


RemittanceDetailDTO $RemittanceDetailDTOFromJson(Map<String, dynamic> json) {
  final RemittanceDetailDTO remittanceDetailDTO = RemittanceDetailDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    remittanceDetailDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    remittanceDetailDTO.ledgerId = ledgerId;
  }
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    remittanceDetailDTO.amount = amount;
  }
  final String? receiver = jsonConvert.convert<String>(json['receiver']);
  if (receiver != null) {
    remittanceDetailDTO.receiver = receiver;
  }
  final List<PaymentDTO>? paymentDTOList = (json['paymentDTOList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<PaymentDTO>(e) as PaymentDTO).toList();
  if (paymentDTOList != null) {
    remittanceDetailDTO.paymentDTOList = paymentDTOList;
  }
  final List<int>? productIdList = (json['productIdList'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<int>(e) as int)
      .toList();
  if (productIdList != null) {
    remittanceDetailDTO.productIdList = productIdList;
  }
  final List<String>? productNameList = (json['productNameList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (productNameList != null) {
    remittanceDetailDTO.productNameList = productNameList;
  }
  final DateTime? remittanceDate = jsonConvert.convert<DateTime>(
      json['remittanceDate']);
  if (remittanceDate != null) {
    remittanceDetailDTO.remittanceDate = remittanceDate;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    remittanceDetailDTO.invalid = invalid;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    remittanceDetailDTO.remark = remark;
  }
  return remittanceDetailDTO;
}

Map<String, dynamic> $RemittanceDetailDTOToJson(RemittanceDetailDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['amount'] = entity.amount;
  data['receiver'] = entity.receiver;
  data['paymentDTOList'] =
      entity.paymentDTOList?.map((v) => v.toJson()).toList();
  data['productIdList'] = entity.productIdList;
  data['productNameList'] = entity.productNameList;
  data['remittanceDate'] = entity.remittanceDate?.toIso8601String();
  data['invalid'] = entity.invalid;
  data['remark'] = entity.remark;
  return data;
}

extension RemittanceDetailDTOExtension on RemittanceDetailDTO {
  RemittanceDetailDTO copyWith({
    int? id,
    int? ledgerId,
    int? amount,
    String? receiver,
    List<PaymentDTO>? paymentDTOList,
    List<int>? productIdList,
    List<String>? productNameList,
    DateTime? remittanceDate,
    int? invalid,
    String? remark,
  }) {
    return RemittanceDetailDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..amount = amount ?? this.amount
      ..receiver = receiver ?? this.receiver
      ..paymentDTOList = paymentDTOList ?? this.paymentDTOList
      ..productIdList = productIdList ?? this.productIdList
      ..productNameList = productNameList ?? this.productNameList
      ..remittanceDate = remittanceDate ?? this.remittanceDate
      ..invalid = invalid ?? this.invalid
      ..remark = remark ?? this.remark;
  }
}