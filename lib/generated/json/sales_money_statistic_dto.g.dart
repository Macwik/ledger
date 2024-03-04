import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/statistics/sales_money_statistic_dto.dart';
import 'package:ledger/entity/statistics/money_payment_dto.dart';

import 'package:decimal/decimal.dart';


SalesMoneyStatisticDTO $SalesMoneyStatisticDTOFromJson(
    Map<String, dynamic> json) {
  final SalesMoneyStatisticDTO salesMoneyStatisticDTO = SalesMoneyStatisticDTO();
  final Decimal? totalSalesMoney = jsonConvert.convert<Decimal>(
      json['totalSalesMoney']);
  if (totalSalesMoney != null) {
    salesMoneyStatisticDTO.totalSalesMoney = totalSalesMoney;
  }
  final List<MoneyPaymentDTO>? paymentList = (json['paymentList'] as List<
      dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MoneyPaymentDTO>(e) as MoneyPaymentDTO)
      .toList();
  if (paymentList != null) {
    salesMoneyStatisticDTO.paymentList = paymentList;
  }
  return salesMoneyStatisticDTO;
}

Map<String, dynamic> $SalesMoneyStatisticDTOToJson(
    SalesMoneyStatisticDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['totalSalesMoney'] = entity.totalSalesMoney?.toJson();
  data['paymentList'] = entity.paymentList?.map((v) => v.toJson()).toList();
  return data;
}

extension SalesMoneyStatisticDTOExtension on SalesMoneyStatisticDTO {
  SalesMoneyStatisticDTO copyWith({
    Decimal? totalSalesMoney,
    List<MoneyPaymentDTO>? paymentList,
  }) {
    return SalesMoneyStatisticDTO()
      ..totalSalesMoney = totalSalesMoney ?? this.totalSalesMoney
      ..paymentList = paymentList ?? this.paymentList;
  }
}