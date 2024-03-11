import 'package:get/get.dart';
import 'package:ledger/config/api/custom_api.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/http/http_util.dart';

import 'custom_list_state.dart';

class CustomListController extends GetxController {
  final CustomListState state = CustomListState();

  Future<void> initState() async {
    // var arguments = Get.arguments;
    // if ((arguments != null) && arguments['initialIndex'] != null) {
    //   state.orderType = arguments['initialIndex'];
    // }
    queryCustom();
  }

  //拉数据
  void queryCustom() {
    Http().network<List<CustomDTO>>(Method.post, CustomApi.getCustomList,
        queryParameters: {

        }).then((result) {
      if (result.success) {
        state.customList = result.d;
    }});
  }
}
