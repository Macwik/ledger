import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/home/home_statistics_dto.dart';
import 'package:decimal/decimal.dart';


HomeStatisticsDTO $HomeStatisticsDTOFromJson(Map<String, dynamic> json) {
  final HomeStatisticsDTO homeStatisticsDTO = HomeStatisticsDTO();
  final Decimal? totalSalesAmount = jsonConvert.convert<Decimal>(
      json['totalSalesAmount']);
  if (totalSalesAmount != null) {
    homeStatisticsDTO.totalSalesAmount = totalSalesAmount;
  }
  final Decimal? totalCostAmount = jsonConvert.convert<Decimal>(
      json['totalCostAmount']);
  if (totalCostAmount != null) {
    homeStatisticsDTO.totalCostAmount = totalCostAmount;
  }
  final Decimal? totalIncomeAmount = jsonConvert.convert<Decimal>(
      json['totalIncomeAmount']);
  if (totalIncomeAmount != null) {
    homeStatisticsDTO.totalIncomeAmount = totalIncomeAmount;
  }
  final Decimal? totalCreditAmount = jsonConvert.convert<Decimal>(
      json['totalCreditAmount']);
  if (totalCreditAmount != null) {
    homeStatisticsDTO.totalCreditAmount = totalCreditAmount;
  }
  final Decimal? totalRepaymentAmount = jsonConvert.convert<Decimal>(
      json['totalRepaymentAmount']);
  if (totalRepaymentAmount != null) {
    homeStatisticsDTO.totalRepaymentAmount = totalRepaymentAmount;
  }
  return homeStatisticsDTO;
}

Map<String, dynamic> $HomeStatisticsDTOToJson(HomeStatisticsDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['totalSalesAmount'] = entity.totalSalesAmount?.toJson();
  data['totalCostAmount'] = entity.totalCostAmount?.toJson();
  data['totalIncomeAmount'] = entity.totalIncomeAmount?.toJson();
  data['totalCreditAmount'] = entity.totalCreditAmount?.toJson();
  data['totalRepaymentAmount'] = entity.totalRepaymentAmount?.toJson();
  return data;
}

extension HomeStatisticsDTOExtension on HomeStatisticsDTO {
  HomeStatisticsDTO copyWith({
    Decimal? totalSalesAmount,
    Decimal? totalCostAmount,
    Decimal? totalIncomeAmount,
    Decimal? totalCreditAmount,
    Decimal? totalRepaymentAmount,
  }) {
    return HomeStatisticsDTO()
      ..totalSalesAmount = totalSalesAmount ?? this.totalSalesAmount
      ..totalCostAmount = totalCostAmount ?? this.totalCostAmount
      ..totalIncomeAmount = totalIncomeAmount ?? this.totalIncomeAmount
      ..totalCreditAmount = totalCreditAmount ?? this.totalCreditAmount
      ..totalRepaymentAmount = totalRepaymentAmount ??
          this.totalRepaymentAmount;
  }
}