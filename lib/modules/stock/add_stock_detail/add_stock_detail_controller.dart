import 'package:get/get.dart';
import 'package:ledger/config/api/order_api.dart';
import 'package:ledger/entity/order/order_detail_dto.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/warning.dart';

import 'add_stock_detail_state.dart';

class AddStockDetailController extends GetxController {
  final AddStockDetailState state = AddStockDetailState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['id'] != null) {
      state.id = arguments['id'];
    }
    await Http().network<OrderDetailDTO>(Method.get, OrderApi.order_detail,
        queryParameters: {'id': state.id}).then((result) {
      if (result.success) {
        state.orderDetailDTO = result.d;
        update([
          'sale_detail_delete','sale_detail_title','sale_detail_product','sale_detail_other'
        ]);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void toDeleteOrder() {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认作废此单吗？',
        onCancel: () {},
        onConfirm: () {//ToDo 后端内容不正确
          Http().network(Method.put, OrderApi.order_invalid, queryParameters: {
            'orderId': state.id,
          }).then((result) {
            if (result.success) {
              Toast.show('作废成功');
              Get.back(result: ProcessStatus.OK);
            } else {
              Get.back(result: ProcessStatus.FAIL);
              Toast.show(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }
}
