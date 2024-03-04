import 'package:get/get.dart';

import 'daily_account_cost_detail_state.dart';

class DailyAccountCostDetailController extends GetxController {
  final DailyAccountCostDetailState state = DailyAccountCostDetailState();


  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['externalOrderBase'] != null) {
      state.externalOrderBaseDTOList = arguments['externalOrderBase'];
    }
  }
}
