import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/statistics/purchase_money_statistics_dto.dart';
import 'package:ledger/entity/order/order_dto.dart';

import 'package:ledger/entity/statistics/external_order_base_dto.dart';

import 'package:decimal/decimal.dart';


PurchaseMoneyStatisticsDTO $PurchaseMoneyStatisticsDTOFromJson(
    Map<String, dynamic> json) {
  final PurchaseMoneyStatisticsDTO purchaseMoneyStatisticsDTO = PurchaseMoneyStatisticsDTO();
  final OrderDTO? orderDTO = jsonConvert.convert<OrderDTO>(json['orderDTO']);
  if (orderDTO != null) {
    purchaseMoneyStatisticsDTO.orderDTO = orderDTO;
  }
  final List<
      ExternalOrderBaseDTO>? externalOrderBaseDTOList = (json['externalOrderBaseDTOList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ExternalOrderBaseDTO>(e) as ExternalOrderBaseDTO)
      .toList();
  if (externalOrderBaseDTOList != null) {
    purchaseMoneyStatisticsDTO.externalOrderBaseDTOList =
        externalOrderBaseDTOList;
  }
  return purchaseMoneyStatisticsDTO;
}

Map<String, dynamic> $PurchaseMoneyStatisticsDTOToJson(
    PurchaseMoneyStatisticsDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderDTO'] = entity.orderDTO?.toJson();
  data['externalOrderBaseDTOList'] =
      entity.externalOrderBaseDTOList?.map((v) => v.toJson()).toList();
  return data;
}

extension PurchaseMoneyStatisticsDTOExtension on PurchaseMoneyStatisticsDTO {
  PurchaseMoneyStatisticsDTO copyWith({
    OrderDTO? orderDTO,
    List<ExternalOrderBaseDTO>? externalOrderBaseDTOList,
  }) {
    return PurchaseMoneyStatisticsDTO()
      ..orderDTO = orderDTO ?? this.orderDTO
      ..externalOrderBaseDTOList = externalOrderBaseDTOList ??
          this.externalOrderBaseDTOList;
  }
}