import 'package:get/get.dart';
import 'package:ledger/enum/cost_order_type.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/stock_list_type.dart';
import 'package:ledger/res/export.dart';

import 'more_state.dart';

class MoreController extends GetxController {
  final MoreState state = MoreState();

  void toSale(int index) {
    switch (index) {
      case 0:
         Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE});
      case 1:
          Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE_RETURN});
      case 2:
         Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.REFUND});
      case 3:
           Get.toNamed(RouteConfig.saleRecord, arguments: {'orderType': OrderType.SALE,'index': 0});
      case 4:
           Get.toNamed(RouteConfig.customRecord,arguments: {'initialIndex': 0, 'isSelectCustom': false});
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

  void toPurchase(int index) {
    switch (index) {
      case 0:
         Get.toNamed(RouteConfig.saleBill, arguments: {'orderType': OrderType.PURCHASE});
      case 1:
          Get.toNamed(RouteConfig.saleBill, arguments: {'orderType': OrderType.PURCHASE_RETURN});
      case 2:
           Get.toNamed(RouteConfig.saleRecord, arguments: {'orderType': OrderType.PURCHASE});
      case 3:
           Get.toNamed(RouteConfig.customRecord,arguments: {'initialIndex': 1, 'isSelectCustom': false});
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

  void toStore(int index) {
    switch (index) {
      case 0:
        Get.toNamed(RouteConfig.stockList, arguments: {'select': StockListType.DETAIL});
      case 1:
        Get.toNamed(RouteConfig.saleBill, arguments: {'orderType':OrderType.ADD_STOCK,});
      case 2:
        Get.toNamed(RouteConfig.stockChangeBill);
      case 3:
        Get.toNamed(RouteConfig.stockChangeRecord);
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

  void toFund(int index) {
    switch (index) {
      case 0:
         Get.toNamed(RouteConfig.costBill, arguments: {'costOrderType': CostOrderType.COST});
      case 1:
          Get.toNamed(RouteConfig.costBill, arguments: {'costOrderType': CostOrderType.INCOME});
      case 2:
         Get.toNamed(RouteConfig.costRecord);
      case 3:
           Get.toNamed(RouteConfig.repaymentBill,arguments: {'customType':CustomType.CUSTOM.value});
      case 4:
           Get.toNamed(RouteConfig.repaymentRecord, arguments: {'customType': CustomType.CUSTOM.value});
      case 5:
         Get.toNamed(RouteConfig.remittance);
      case 6:
         Get.toNamed(RouteConfig.remittanceRecord);
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

}
