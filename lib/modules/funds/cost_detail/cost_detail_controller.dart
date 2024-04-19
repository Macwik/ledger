import 'package:get/get.dart';
import 'package:ledger/config/api/cost_income_api.dart';
import 'package:ledger/entity/costIncome/cost_income_detail_dto.dart';
import 'package:ledger/entity/order/order_payment_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/warning.dart';

import 'cost_detail_state.dart';

class CostDetailController extends GetxController {
  final CostDetailState state = CostDetailState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['costIncomeOrder'] != null) {
      state.costIncomeOrderDTO = arguments['costIncomeOrder'];
    }
    _queryData();
  }

  _queryData() async {
    Http().network<CostIncomeDetailDTO>(
        Method.get, CostIncomeApi.cost_order_detail,
        queryParameters: {'id':state.costIncomeOrderDTO?.id}).then((result) {
      if (result.success) {
        state.costIncomeDetailDTO = result.d;
        update(['cost_detail', 'cost_detail_title']);
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
        onConfirm: () {
          Http().network(Method.put, CostIncomeApi.cost_order_invalid,
              queryParameters: {
                'id': state.costIncomeOrderDTO?.id,
              }).then((result) {
            if (result.success) {
              Toast.show('作废成功');
              Get.back(result: ProcessStatus.OK);
            } else {
              Toast.show(result.m.toString());
              Get.back(result: ProcessStatus.FAIL);
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }

  checkVisible() {
    if ((null == state.costIncomeDetailDTO?.productIdList) ||
        (state.costIncomeDetailDTO!.productIdList!.isEmpty)) {
      return false;
    }
    return true;
  }

  Future<void> toSaleDetail() async {
    if (state.costIncomeDetailDTO?.salesOrderNo == null) {
      Toast.show('未绑定采购单');
    } else {
      await Get.toNamed(RouteConfig.saleDetail, arguments: {
        'id': state.costIncomeDetailDTO?.salesOrderId,
        'orderType': OrderType.PURCHASE
      })?.then((value) {
        _queryData();
      });
    }
  }

  OrderType orderType(int? orderType) {
    switch (orderType) {
      case 0:
        return OrderType.PURCHASE;
      case 1:
        return OrderType.SALE;
      case 2:
        return OrderType.SALE_RETURN;
      case 3:
        return OrderType.PURCHASE_RETURN;
      default:
        throw Exception('销售单');
    }
  }


  String orderPayment(List<OrderPaymentDTO>? orderPaymentList) {
    if (null == orderPaymentList || orderPaymentList.isEmpty) {
      return '0';
    }
    String result = '';
    for (var payment in orderPaymentList) {
      result = '$result${payment.paymentMethodName ?? ''}  ';
    }
    return result;
  }
}
