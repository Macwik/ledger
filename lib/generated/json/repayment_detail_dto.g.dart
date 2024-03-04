import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/repayment/repayment_detail_dto.dart';
import 'package:ledger/entity/order/order_payment_dto.dart';

import 'package:ledger/entity/repayment/repayment_bind_order_dto.dart';

import 'package:decimal/decimal.dart';


RepaymentDetailDTO $RepaymentDetailDTOFromJson(Map<String, dynamic> json) {
  final RepaymentDetailDTO repaymentDetailDTO = RepaymentDetailDTO();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    repaymentDetailDTO.ledgerId = ledgerId;
  }
  final int? customId = jsonConvert.convert<int>(json['customId']);
  if (customId != null) {
    repaymentDetailDTO.customId = customId;
  }
  final String? customName = jsonConvert.convert<String>(json['customName']);
  if (customName != null) {
    repaymentDetailDTO.customName = customName;
  }
  final DateTime? repaymentDate = jsonConvert.convert<DateTime>(
      json['repaymentDate']);
  if (repaymentDate != null) {
    repaymentDetailDTO.repaymentDate = repaymentDate;
  }
  final int? settlementType = jsonConvert.convert<int>(json['settlementType']);
  if (settlementType != null) {
    repaymentDetailDTO.settlementType = settlementType;
  }
  final List<
      RepaymentBindOrderDTO>? repaymentBindOrderList = (json['repaymentBindOrderList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<RepaymentBindOrderDTO>(e) as RepaymentBindOrderDTO)
      .toList();
  if (repaymentBindOrderList != null) {
    repaymentDetailDTO.repaymentBindOrderList = repaymentBindOrderList;
  }
  final List<OrderPaymentDTO>? paymentDTOList = (json['paymentDTOList'] as List<
      dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<OrderPaymentDTO>(e) as OrderPaymentDTO)
      .toList();
  if (paymentDTOList != null) {
    repaymentDetailDTO.paymentDTOList = paymentDTOList;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    repaymentDetailDTO.totalAmount = totalAmount;
  }
  final Decimal? discountAmount = jsonConvert.convert<Decimal>(
      json['discountAmount']);
  if (discountAmount != null) {
    repaymentDetailDTO.discountAmount = discountAmount;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    repaymentDetailDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    repaymentDetailDTO.creatorName = creatorName;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    repaymentDetailDTO.invalid = invalid;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    repaymentDetailDTO.remark = remark;
  }
  return repaymentDetailDTO;
}

Map<String, dynamic> $RepaymentDetailDTOToJson(RepaymentDetailDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['customId'] = entity.customId;
  data['customName'] = entity.customName;
  data['repaymentDate'] = entity.repaymentDate?.toIso8601String();
  data['settlementType'] = entity.settlementType;
  data['repaymentBindOrderList'] =
      entity.repaymentBindOrderList?.map((v) => v.toJson()).toList();
  data['paymentDTOList'] =
      entity.paymentDTOList?.map((v) => v.toJson()).toList();
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['discountAmount'] = entity.discountAmount?.toJson();
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['invalid'] = entity.invalid;
  data['remark'] = entity.remark;
  return data;
}

extension RepaymentDetailDTOExtension on RepaymentDetailDTO {
  RepaymentDetailDTO copyWith({
    int? ledgerId,
    int? customId,
    String? customName,
    DateTime? repaymentDate,
    int? settlementType,
    List<RepaymentBindOrderDTO>? repaymentBindOrderList,
    List<OrderPaymentDTO>? paymentDTOList,
    Decimal? totalAmount,
    Decimal? discountAmount,
    int? creator,
    String? creatorName,
    int? invalid,
    String? remark,
  }) {
    return RepaymentDetailDTO()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..customId = customId ?? this.customId
      ..customName = customName ?? this.customName
      ..repaymentDate = repaymentDate ?? this.repaymentDate
      ..settlementType = settlementType ?? this.settlementType
      ..repaymentBindOrderList = repaymentBindOrderList ??
          this.repaymentBindOrderList
      ..paymentDTOList = paymentDTOList ?? this.paymentDTOList
      ..totalAmount = totalAmount ?? this.totalAmount
      ..discountAmount = discountAmount ?? this.discountAmount
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..invalid = invalid ?? this.invalid
      ..remark = remark ?? this.remark;
  }
}