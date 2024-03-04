import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/custom_api.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';

import 'custom_list_state.dart';

class CustomListController extends GetxController {
  final CustomListState state = CustomListState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['initialIndex'] != null) {
      state.orderType = arguments['initialIndex'];
    }
    queryCustom();
  }

  void searchCustom(String searchValue) {
    state.customName = searchValue;
    queryCustom();
  }

  void toAddCustom() {
    Get.toNamed(RouteConfig.addCustom, arguments: {'customType':state.orderType})
        ?.then((value) {
      if (ProcessStatus.OK == value) {
        queryCustom();
      }
    });
  }

  //拉数据
  void queryCustom() {
    Http().network<List<CustomDTO>>(Method.post, CustomApi.getCustomList,
        queryParameters: {
          'customType': state.orderType,
          'name': state.customName,
          'invalid':0,
        }).then((result) {
      if (result.success) {
        state.customList = result.d;
        if (state.orderType == 0) {
          state.customList?.insert(
              0,
              CustomDTO(
                  customName: '默认客户',
                  used: 1,
                  creditAmount: Decimal.zero,
                  tradeAmount: Decimal.zero,
                  invalid: 0));
        } else if((state.orderType == 1)){
          state.customList?.insert(0,
              CustomDTO(
                  customName: '默认供应商',
                  used: 1,
                  creditAmount: Decimal.zero,
                  tradeAmount: Decimal.zero,
                  invalid: 0));
        }else{


        }
        update(['custom_list']);
      }
    });
  }
}
