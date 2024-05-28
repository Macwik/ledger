import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/app_update_api.dart';
import 'package:ledger/config/api/home_api.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/entity/app/app_check_dto.dart';
import 'package:ledger/entity/home/home_statistics_dto.dart';
import 'package:ledger/entity/home/sales_credit_statistics_dto.dart';
import 'package:ledger/entity/home/sales_payment_statistics_dto.dart';
import 'package:ledger/entity/home/sales_product_statistics_dto.dart';
import 'package:ledger/entity/home/sales_repayment_statistics_dto.dart';
import 'package:ledger/enum/stock_list_type.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog_widget/update_dialog/app_update_dialog.dart';
import 'package:ledger/widget/image.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'home_state.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();

  Future<void> initState() async {
    _updatePermission();
    _queryGridWidgets();
    _queryData();
    _querySalesProductStatistics();
    _querySalesRepaymentStatistics();
    _querySalesPaymentStatistics();
    _querySalesCreditStatistics();
    update(['home_active_ledger_name']);
  }

  _updatePermission() {
    StoreController.to.updatePermissionCode().then((result) {
      if (result) {
        update(['home_head_function', 'home_common_function']);
      }
    });
  }

  ///拉取活跃账本
  String? getActiveLedger() {
    return StoreController.to.getUser()?.activeLedger?.ledgerName;
  }

  ///版本校验
  checkUpdate(BuildContext context) async {
    /// 获得服务器版本
    /// version 为android/add/build.gradle中的versionName
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Http().network<AppCheckDTO>(Method.get, AppUpdateApi.app_update_check,
        queryParameters: {
          'releaseLevel': packageInfo.buildNumber
        }).then((result) {
      if (!result.success) {
        return;
      }
      AppCheckDTO appCheckDTO = result.d!;
      if (appCheckDTO.latest ?? true) {
        return;
      } else {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) => AppUpdateDialog(
                  force: appCheckDTO.forceUpdate ?? false,
                  appCheckDTO: result.d!,
                ));
      }
    });
  }

  ///拉取净收入等
  _queryData() async {
    Http()
        .network<HomeStatisticsDTO>(
      Method.get,
      HomeApi.statistics_home,
    )
        .then((result) {
      if (result.success) {
        state.homeStatisticsDTO = result.d;
        update(['home_sum']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  ///拉取今日销售情况
  _querySalesProductStatistics() async {
    Http()
        .network<List<SalesProductStatisticsDTO>>(
      Method.post,
      HomeApi.product_statistics,
    )
        .then((result) {
      if (result.success) {
        List<SalesProductStatisticsDTO>? list = result.d;
        state.salesProductStatisticsDTO = list;
        state.todaySalesAmount = list?.isEmpty ?? true
            ? Decimal.zero
            : list?.map((e) {
                var totalAmount = e.totalAmount ?? Decimal.zero;
                var discountAmount = e.discountAmount ?? Decimal.zero;
                return totalAmount - discountAmount;
              }).reduce((value, element) => value + element);
        update(['home_product_statistics']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  ///拉取还款情况
  _querySalesRepaymentStatistics() async {
    Http()
        .network<List<SalesRepaymentStatisticsDTO>>(
      Method.post,
      HomeApi.repayment_statistics,
    )
        .then((result) {
      if (result.success) {
        List<SalesRepaymentStatisticsDTO>? list = result.d;
        state.salesRepaymentStatisticsDTO = list;
        state.todayRepaymentAmount = list?.isEmpty ?? true
            ? Decimal.zero
            : list
                ?.map((e) => e.totalAmount ?? Decimal.zero)
                .reduce((value, element) => value + element);
        update(['home_repayment_statistics']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  ///拉取收款情况
  _querySalesPaymentStatistics() async {
    Http()
        .network<List<SalesPaymentStatisticsDTO>>(
      Method.post,
      HomeApi.payment_statistics,
    )
        .then((result) {
      if (result.success) {
        List<SalesPaymentStatisticsDTO>? list = result.d;
        state.salesPaymentStatisticsDTO = list;
        state.todayPaymentAmount = list?.isEmpty ?? true
            ? Decimal.zero
            : list
                ?.map((e) => e.paymentAmount ?? Decimal.zero)
                .reduce((value, element) => value + element);
        update(['home_payment_statistics']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  ///拉取客户赊账情况
  _querySalesCreditStatistics() async {
    Http()
        .network<List<SalesCreditStatisticsDTO>>(
      Method.post,
      HomeApi.credit_statistics,
    )
        .then((result) {
      if (result.success) {
        List<SalesCreditStatisticsDTO>? list = result.d;
        state.salesCreditStatisticsDTO = list;
        state.todayCreditAmount = list?.isEmpty ?? true
            ? Decimal.zero
            : list
                ?.map((e) => e.creditAmount ?? Decimal.zero)
                .reduce((value, element) => value + element);
        update(['home_credit_statistics']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  String judgeSlaveUnit(SalesProductStatisticsDTO? salesProductStatisticsDTO) {
    if (null == salesProductStatisticsDTO) {
      return '-';
    }
    if (salesProductStatisticsDTO.unitType == UnitType.SINGLE.value) {
      return '${DecimalUtil.formatDecimalDefault(salesProductStatisticsDTO.number)} ${salesProductStatisticsDTO.unitName}';
    } else {
      return '${DecimalUtil.formatDecimalDefault(salesProductStatisticsDTO.slaveNumber)} ${salesProductStatisticsDTO.slaveUnitName ?? ''}';
    }
  }

  String judgeMasterUnit(SalesProductStatisticsDTO? salesProductStatisticsDTO) {
    if (null == salesProductStatisticsDTO) {
      return '-';
    }
    if (salesProductStatisticsDTO.unitType == UnitType.SINGLE.value) {
      return '';
    } else {
      return '${DecimalUtil.formatDecimalDefault(salesProductStatisticsDTO.masterNumber)} ${salesProductStatisticsDTO.masterUnitName ?? ''}';
    }
  }

  static const List<String> gridItemNames = [
    '销售',
    '采购',
    '库存',
    '收支',
    '还款',
    '账目',
    '更多'
  ];
  static const List<int> gridItemColors = [
    0x7C9BA9FA,
    0xFFFCEAF4,
    0x60FF8D1A,
    0x529BD4FA,
    0x4C04BFB3,
    0xFFFAD984,
    0x4C04BFB3
  ];
  static const List<String> gridItemPaths = [
    'xiaoshou',
    'caigou',
    'kucun',
    'home_cost',
    'home_repayment',
    'zhangmu',
    'more'
  ];

  final List<Function()> gridItemRoutes = [
    () => Get.toNamed(RouteConfig.saleRecord, arguments: {'index': 0}),
    () => Get.toNamed(RouteConfig.purchaseRecord, arguments: {'index': 0}),
    () => Get.toNamed(RouteConfig.stockList,
        arguments: {'select': StockListType.DETAIL}),
    () => Get.toNamed(RouteConfig.costRecord, arguments: {'index': 0}),
    () => Get.toNamed(RouteConfig.repaymentRecord, arguments: {'index': 0}),
    () => Get.toNamed(RouteConfig.dailyAccount),
    () => Get.toNamed(RouteConfig.more),
  ];

  static const List<List<String>> gridItemPermission = [
    [
      PermissionCode.sales_sale_record_permission,
      PermissionCode.sales_return_sale_record_permission,
      PermissionCode.sales_refund_sale_record_permission
    ],
    [
      PermissionCode.purchase_purchase_record_permission,
      PermissionCode.purchase_purchase_return_record_permission,
      PermissionCode.purchase_add_stock_record_permission
    ],
    [PermissionCode.stock_page_permission],
    [PermissionCode.funds_cost_record_permission],
    [
      PermissionCode.funds_repayment_record_permission,
      PermissionCode.supplier_custom_repayment_record_permission
    ],
    [PermissionCode.account_page_permission],
    [PermissionCode.common_permission],
  ];

  List<Widget> buildGridWidgets(List<String> permissionList) {
    List<Widget> result = [];
    for (int index = 0; index < gridItemPermission.length; index++) {
      var elements = gridItemPermission[index];
      if (elements.contains(PermissionCode.common_permission)) {
        result.add(buildGridWidget(index));
        continue;
      }
      if (permissionList.isEmpty) {
        continue;
      }
      if (elements.any((element) => permissionList.contains(element))) {
        result.add(buildGridWidget(index));
      }
    }
    return result;
  }

  Widget buildGridWidget(int index) {
    return InkWell(
      onTap: gridItemRoutes[index],
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: Container(
                width: double.infinity,
                color: Color(gridItemColors[index]),
                child: Center(
                  child: LoadAssetImage(
                    gridItemPaths[index],
                    width: 66.w,
                    height: 66.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Text(
              gridItemNames[index],
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Colours.text_999,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _queryGridWidgets() {
    StoreController.to.getPermissionCodeAsync().then((result) {
      if (result.isNotEmpty) {
        var widgets = buildGridWidgets(result);
        state.gridWidgets = widgets;
        state.gridWidgetCount = widgets.length;
        update(['home_head_function']);
      }
    });
  }
}
