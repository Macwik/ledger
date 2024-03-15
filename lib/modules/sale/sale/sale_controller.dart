import 'package:get/get.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/route/route_config.dart';

import 'sale_state.dart';

class SaleController extends GetxController {
  final SaleState state = SaleState();

  toSaleBill() {
    Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE});
  }

  toSaleReturnBill() {
    Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE_RETURN});
  }
}
