import 'package:ledger/entity/costIncome/cost_income_label_type_dto.dart';
import 'package:ledger/enum/cost_order_type.dart';

class CostTypeState {
  List<CostIncomeLabelTypeDTO>? costLabelTypeDTO;
  List<CostIncomeLabelTypeDTO>? dailyLabelTypeDTO;

  CostOrderType? costOrderType;

  CostTypeState() {
    ///Initialize variables
  }
}
