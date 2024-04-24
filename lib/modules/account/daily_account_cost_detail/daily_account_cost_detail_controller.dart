import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/statistics/external_order_base_dto.dart';
import 'package:ledger/util/decimal_util.dart';

import 'daily_account_cost_detail_state.dart';

class DailyAccountCostDetailController extends GetxController {
  final DailyAccountCostDetailState state = DailyAccountCostDetailState();


  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['externalOrderBase'] != null) {
      List<ExternalOrderBaseDTO>? argument = arguments['externalOrderBase'];
      if(argument?.isNotEmpty ?? false){
        for (var element in argument!) {
          if(element.discount == 0){
            state.externalOrderDTO.add(element);
          }
          if(element.discount == 1){
            state.discountExternalOrderDTO.add(element);
          }
        }
      }
    }
  }

  String totalExternalOrderAmount() {
    return state.externalOrderDTO.isNotEmpty
        ? DecimalUtil.formatAmount(state.externalOrderDTO.map((e) => e.totalAmount).reduce((value, element) => (value??Decimal.zero) + (element??Decimal.zero)))
        : '0.00';
  }

  String totalDiscountExternalOrderAmount() {
    return state.discountExternalOrderDTO.isNotEmpty
        ? DecimalUtil.formatAmount(state.discountExternalOrderDTO.map((e) => e.totalAmount).reduce((value, element) => (value??Decimal.zero) + (element??Decimal.zero)))
        : '0.00';
  }
}
