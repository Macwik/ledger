import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/home/income_repayment_total_dto.dart';
import 'package:decimal/decimal.dart';


IncomeRepaymentTotalDTO $IncomeRepaymentTotalDTOFromJson(
    Map<String, dynamic> json) {
  final IncomeRepaymentTotalDTO incomeRepaymentTotalDTO = IncomeRepaymentTotalDTO();
  final Decimal? totalIncomeAmount = jsonConvert.convert<Decimal>(
      json['totalIncomeAmount']);
  if (totalIncomeAmount != null) {
    incomeRepaymentTotalDTO.totalIncomeAmount = totalIncomeAmount;
  }
  final Decimal? totalCreditAmount = jsonConvert.convert<Decimal>(
      json['totalCreditAmount']);
  if (totalCreditAmount != null) {
    incomeRepaymentTotalDTO.totalCreditAmount = totalCreditAmount;
  }
  final Decimal? totalRepaymentAmount = jsonConvert.convert<Decimal>(
      json['totalRepaymentAmount']);
  if (totalRepaymentAmount != null) {
    incomeRepaymentTotalDTO.totalRepaymentAmount = totalRepaymentAmount;
  }
  return incomeRepaymentTotalDTO;
}

Map<String, dynamic> $IncomeRepaymentTotalDTOToJson(
    IncomeRepaymentTotalDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['totalIncomeAmount'] = entity.totalIncomeAmount?.toJson();
  data['totalCreditAmount'] = entity.totalCreditAmount?.toJson();
  data['totalRepaymentAmount'] = entity.totalRepaymentAmount?.toJson();
  return data;
}

extension IncomeRepaymentTotalDTOExtension on IncomeRepaymentTotalDTO {
  IncomeRepaymentTotalDTO copyWith({
    Decimal? totalIncomeAmount,
    Decimal? totalCreditAmount,
    Decimal? totalRepaymentAmount,
  }) {
    return IncomeRepaymentTotalDTO()
      ..totalIncomeAmount = totalIncomeAmount ?? this.totalIncomeAmount
      ..totalCreditAmount = totalCreditAmount ?? this.totalCreditAmount
      ..totalRepaymentAmount = totalRepaymentAmount ??
          this.totalRepaymentAmount;
  }
}