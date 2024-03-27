import 'package:ledger/entity/costIncome/cost_income_detail_dto.dart';
import 'package:ledger/entity/costIncome/cost_income_order_dto.dart';

class CostDetailState {

  CostIncomeDetailDTO ? costIncomeDetailDTO;

  //int ? id;

  CostDetailState() {
    ///Initialize variables
  }
//上页面带过来的
  CostIncomeOrderDTO? costIncomeOrderDTO;

}
