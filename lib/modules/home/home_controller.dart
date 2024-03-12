import 'package:decimal/decimal.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/app_update_api.dart';
import 'package:ledger/config/api/home_api.dart';
import 'package:ledger/entity/app/app_check_dto.dart';
import 'package:ledger/entity/home/home_statistics_dto.dart';
import 'package:ledger/entity/home/sales_credit_statistics_dto.dart';
import 'package:ledger/entity/home/sales_payment_statistics_dto.dart';
import 'package:ledger/entity/home/sales_product_statistics_dto.dart';
import 'package:ledger/entity/home/sales_repayment_statistics_dto.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/logger_util.dart';
import 'package:ledger/util/permission_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog_widget/update_dialog/app_update_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_state.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();

  Future<void> initState() async {
    _queryData();
    _checkUpdate();
    _querySalesProductStatistics();
    _querySalesRepaymentStatistics();
    _querySalesPaymentStatistics();
    _querySalesCreditStatistics();
    updatePermission();
    update(['home_active_ledger_name']);
  }

  updatePermission() {
    StoreController.to.updatePermissionCode().then((result) {
      update(['home_head_function', 'home_common_function']);
    });
  }

  ///拉取活跃账本
  String? getActiveLedger() {
    return StoreController.to.getUser()?.activeLedger?.ledgerName;
  }

  ///版本校验
  _checkUpdate() async {
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
        //版本不符弹出对话框
        Get.dialog(
          AlertDialog(
            title: null, // 设置标题为null，
            content: SingleChildScrollView(
              child: AppUpdateDialog(
                force: appCheckDTO.forceUpdate ?? false,
                appCheckDTO: result.d!,
              ),
            ),
          ),
          barrierDismissible: false,
        );
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
            : list
                ?.map((e) => e.totalAmount ?? Decimal.zero)
                .reduce((value, element) => value + element);
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
}
