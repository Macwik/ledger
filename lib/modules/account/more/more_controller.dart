import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/cost_order_type.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/stock_list_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';

import 'more_state.dart';

class MoreController extends GetxController {
  final MoreState state = MoreState();

  void toSale(int index) {
    switch (index) {
      case 0:
        Get.toNamed(RouteConfig.retailBill,
            arguments: {'orderType': OrderType.SALE});
      case 1:
        Get.toNamed(RouteConfig.retailBill,
            arguments: {'orderType': OrderType.SALE_RETURN});
      case 2:
        Get.toNamed(RouteConfig.retailBill,
            arguments: {'orderType': OrderType.REFUND});
      case 3:
        Get.toNamed(RouteConfig.saleRecord, arguments: {'index': 0});
      case 4:
        Get.toNamed(RouteConfig.customRecord, arguments: {
          'customType': CustomType.CUSTOM.value,
          'isSelectCustom': false
        });
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

  void toPurchase(int index) {
    switch (index) {
      case 0:
        Get.toNamed(RouteConfig.saleBill,
            arguments: {'orderType': OrderType.PURCHASE});
      case 1:
        Get.toNamed(RouteConfig.saleBill,
            arguments: {'orderType': OrderType.PURCHASE_RETURN});
      case 2:
        Get.toNamed(RouteConfig.purchaseRecord);
      case 3:
        Get.toNamed(RouteConfig.customRecord, arguments: {
          'customType': CustomType.SUPPLIER.value,
          'isSelectCustom': false
        });
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

  void toStore(int index) {
    switch (index) {
      case 0:
        Get.toNamed(RouteConfig.stockList,
            arguments: {'select': StockListType.DETAIL});
      case 1:
        Get.toNamed(RouteConfig.saleBill, arguments: {
          'orderType': OrderType.ADD_STOCK,
        });
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
        Get.toNamed(RouteConfig.costBill,
            arguments: {'costOrderType': CostOrderType.COST});
      case 1:
        Get.toNamed(RouteConfig.costBill,
            arguments: {'costOrderType': CostOrderType.INCOME});
      case 2:
        Get.toNamed(RouteConfig.costRecord, arguments: {'index': 0});
      case 3:
        Get.toNamed(RouteConfig.addDebt);
      case 4:
        Get.toNamed(RouteConfig.repaymentRecord, arguments: {'index': 0});
      case 5:
        Get.toNamed(RouteConfig.remittance);
      case 6:
        Get.toNamed(RouteConfig.remittanceRecord);
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

  void initState() {
    StoreController.to.getPermissionCodeAsync().then((permissionList) {
      if (permissionList.isNotEmpty) {
        state.permissionList = permissionList;
        update(['app_list']);
      }
    });
  }



  final List<String> gridItemSaleNames = ['销售开单', '销售退货', '仅退款', '销售记录', '客户'];

  final List<String> gridItemSalePaths = [
    'svg/ic_sale_bill',
    'svg/ic_sale_back',
    'svg/ic_sale_refund',
    'svg/ic_sale_record',
    'svg/ic_sale_customer'
  ];

  final List<String> gridItemSalePermission = [
    PermissionCode.sales_sale_order_permission,
    PermissionCode.sales_sale_return_permission,
    PermissionCode.sales_sale_refund_permission,
    PermissionCode.sales_sale_record_permission,
    PermissionCode.custom_list_check_permission
  ];

  final List<String> gridItemPurchaseNames = ['采购开单', '采购退货', '采购记录', '供应商'];

  final List<String> gridItemPurchasePaths = [
    'svg/ic_purchase_bill1',
    'svg/ic_purchase_bill',
    'svg/ic_purchase_record',
    'svg/ic_purchase_supplier',
  ];

  final List<String> gridItemPurchasePermission = [
    PermissionCode.purchase_purchase_order_permission,
    PermissionCode.purchase_purchase_return_order_permission,
    PermissionCode.purchase_purchase_record_permission,
    PermissionCode.supplier_list_check_permission,
  ];

  final List<String> gridItemStoreNames = ['库存列表', '直接入库', '库存调整', '调整记录'];

  final List<String> gridItemStorePaths = [
    'svg/ic_stock_list',
    'svg/stock_add_stocks',
    'svg/ic_stock_change',
    'svg/ic_stock_change_record',
  ];

  final List<String> gridItemStorePermission = [
    PermissionCode.stock_page_permission,
    PermissionCode.purchase_add_stock_order_permission,
    PermissionCode.stock_stock_change_permission,
    PermissionCode.stock_stock_change_record_permission,
  ];

  final List<String> gridItemFundNames = [
    '费用开单',
    '收入开单',
    '费/收记录',
    '录入欠款',
    '还款记录',
    '汇款开单',
    '汇款记录'
  ];

  final List<String> gridItemFundPaths = [
    'svg/ic_funds_cost',
    'svg/ic_funds_income',
    'svg/ic_funds_record',
    'svg/ic_funds_debt',
    'svg/ic_funds_repayment',
    'svg/ic_purchase_remittance',
    'svg/ic_purchase_remittance_record'
  ];

  final List<List<String>> gridItemFundPermission = [
    [PermissionCode.funds_cost_order_permission],
    [PermissionCode.funds_cost_order_permission],
    [PermissionCode.funds_cost_record_permission],
    [PermissionCode.funds_add_debt_permission],
    [
      PermissionCode.funds_repayment_record_permission,
      PermissionCode.supplier_custom_repayment_record_permission
    ],
    [PermissionCode.purchase_remittance_order_permission],
    [PermissionCode.remittance_remittance_record_permission]
  ];

  final List<String> gridItemAccountNames = [
    '每日流水',
  ];

  final List<String> gridItemAccountPaths = [
    'svg/ic_account_day_to_day',
  ];

  final List<String> gridItemAccountPermission = [
    PermissionCode.account_page_permission,
  ];


}
