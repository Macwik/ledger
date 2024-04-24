import 'package:ledger/entity/statistics/external_order_base_dto.dart';

class DailyAccountCostDetailState {
  DailyAccountCostDetailState() {
    ///Initialize variables
  }

  List<ExternalOrderBaseDTO> discountExternalOrderDTO = []; //销售地扣除

  List<ExternalOrderBaseDTO> externalOrderDTO = []; //产地扣除
}
