import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/purchase_money_statistics_dto.g.dart';
import 'package:ledger/entity/order/order_dto.dart';
import 'package:ledger/entity/statistics/external_order_base_dto.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()//采购资金统计
class PurchaseMoneyStatisticsDTO {
  OrderDTO? orderDTO;
  List<ExternalOrderBaseDTO>?	externalOrderBaseDTOList;


  PurchaseMoneyStatisticsDTO();

  factory PurchaseMoneyStatisticsDTO.fromJson(Map<String, dynamic> json) =>
      $PurchaseMoneyStatisticsDTOFromJson(json);

  Map<String, dynamic> toJson() => $PurchaseMoneyStatisticsDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

}