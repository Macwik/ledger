import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/remittance_dto.g.dart';
import 'package:ledger/entity/remittance/payment_dto.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class RemittanceDTO {
  int? ledgerId;
  int? id;
  Decimal? amount;
  String? receiver;
  List<PaymentDTO>? paymentDTO;
  List<int>? productId;
  List<String>? productNameList;
  DateTime? remittanceDate;
  int? invalid;
  int? creator;
  String? creatorName;
  DateTime? gmtCreate;
  String? remark;

  RemittanceDTO();

  factory RemittanceDTO.fromJson(Map<String, dynamic> json) =>
      $RemittanceDTOFromJson(json);

  Map<String, dynamic> toJson() => $RemittanceDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
