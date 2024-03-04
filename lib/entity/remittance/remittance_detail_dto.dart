import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/remittance_detail_dto.g.dart';
import 'package:ledger/entity/remittance/payment_dto.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class RemittanceDetailDTO {
  int? id;
  int? ledgerId;
  int? amount;
  String? receiver;
  List<PaymentDTO>? paymentDTOList;
  List<int>? productIdList;
  List<String>? productNameList;
  DateTime? remittanceDate;
  int? invalid;
  String? remark;

  RemittanceDetailDTO();

  factory RemittanceDetailDTO.fromJson(Map<String, dynamic> json) =>
      $RemittanceDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => $RemittanceDetailDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}