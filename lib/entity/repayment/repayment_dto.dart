import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/repayment_dto.g.dart';
import 'dart:convert';
import 'package:decimal/decimal.dart';

@JsonSerializable()
class RepaymentDTO {
  int? id;
  int? ledgerId;
  int? customId;
  String? customName;
  DateTime? repaymentDate;
  Decimal? totalAmount;
  Decimal? remainingAmount;
  Decimal? discountAmount;
  int? invalid;
  int? creator;
  String? creatorName;
  DateTime? gmtCreate;
  bool? showDateTime;


  RepaymentDTO();

  factory RepaymentDTO.fromJson(Map<String, dynamic> json) =>
      $RepaymentDTOFromJson(json);

  Map<String, dynamic> toJson() => $RepaymentDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}