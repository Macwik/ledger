import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/entity/product/stock_change_record_dto.dart';
import 'package:ledger/entity/user/user_base_dto.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';

import 'stock_change_record_state.dart';

class StockChangeRecordController extends GetxController {
  final StockChangeRecordState state = StockChangeRecordState();

  int get itemCount => state.employeeList?.length ?? 0; //筛选里chip的数量

  Future<void> initState() async {
    onRefresh();
    _queryLedgerUserList();
  }

  String afterCount(StockChangeRecordDTO? afterStock) {
    if (null == afterStock) {
      return '-';
    }
    if (afterStock.unitType == UnitType.SINGLE.value) {
      return '${afterStock.afterStock!} ${afterStock.unitName}';
    } else {
      return '${afterStock.afterMasterStock!} ${afterStock.masterUnitName}| ${afterStock.afterSlaveStock!} ${afterStock.slaveUnitName}';
    }
  }

  String beforeCount(StockChangeRecordDTO? beforeStock) {
    if (null == beforeStock) {
      return '-';
    }
    if (beforeStock.unitType == UnitType.SINGLE.value) {
      return '${DecimalUtil.subtract(beforeStock.afterStock, beforeStock.beforeStock)} ${beforeStock.unitName}';
    } else {
      return '${DecimalUtil.subtract(beforeStock.afterMasterStock, beforeStock.beforeMasterStock)} ${beforeStock.masterUnitName} | ${DecimalUtil.subtract(beforeStock.afterSlaveStock, beforeStock.beforeSlaveStock)} ${beforeStock.slaveUnitName}';
    }
  }

  Color beforeCountColor(StockChangeRecordDTO? beforeStock) {
    if (null == beforeStock) {
      return Colours.primary;
    }
    if (beforeStock.unitType == UnitType.SINGLE.value) {
      if (beforeStock.beforeStock! > beforeStock.afterStock!) {
        return Colours.primary;
      } else {
        return Colors.orange;
      }
    } else {
      if (beforeStock.beforeMasterStock! > beforeStock.afterMasterStock!) {
        return Colours.primary;
      } else {
        return Colors.orange;
      }
    }
  }

  Future<void> _queryData(int currentPage) async {
    await Http().networkPage<StockChangeRecordDTO>(
        Method.post, ProductApi.stockChangeRecord,
        data: {
          'page': currentPage,
          'searchContent': state.searchContent,
          'startDate': DateUtil.formatDefaultDate(state.startDate),
          'endDate': DateUtil.formatDefaultDate(state.endDate),
          'employeeIdList': state.selectEmployeeIdList,
        }).then((result) {
      if (result.success) {
        if (currentPage == 1) {
          state.items = result.d!.result!;
        } else {
          state.items!.addAll(result.d!.result!);
        }
        state.hasMore = result.d!.hasMore;
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    _queryData(state.currentPage).then((value) {
      update(['stock_change']);
      state.refreshController.finishLoad(state.hasMore ?? false
          ? IndicatorResult.success
          : IndicatorResult.noMore);
    });
  }

  Future<void> onRefresh() async {
    state.currentPage = 1;
    _queryData(state.currentPage).then((value) {
      update(['stock_change']);
      state.refreshController.finishRefresh();
      state.refreshController.resetFooter();
    });
  }

  //筛选里拉取业务员信息
  Future<void> _queryLedgerUserList() async {
    final result = await Http()
        .network<List<UserBaseDTO>>(Method.get, LedgerApi.ledger_user_list);
    if (result.success) {
      state.employeeList = result.d;
      update();
    } else {
      Toast.show(result.m.toString());
    }
  }

  //筛选里选择业务员
  bool isEmployeeSelect(int? employeeId) {
    if (employeeId == null) {
      return false;
    }
    return (state.selectEmployeeIdList != null) &&
        state.selectEmployeeIdList!.contains(employeeId);
  }

  //选择调整状态
  bool checkOrderStatus(int? orderStatus) {
    return state.orderStatus == orderStatus;
  }

  //筛选里清空条件
  void clearCondition() {
    state.startDate = DateTime.now().subtract(Duration(days: 90));
    state.endDate = DateTime.now();
    state.selectEmployeeIdList = null;
    state.orderStatus = null;
    state.invalid = 0;
    update(
        ['screen_btn', 'sale_order_status', 'employee_button', 'date_range']);
  }

  //筛选里‘确定’
  void confirmCondition() {
    onRefresh();
    Get.back();
  }

  void selectEmployee(int? id) {
    if ((state.selectEmployeeIdList != null) &&
        state.selectEmployeeIdList!.contains(id)) {
      state.selectEmployeeIdList!.remove(id);
      if (state.selectEmployeeIdList!.isEmpty) {
        state.selectEmployeeIdList = null;
        update(['employee_button']);
      }
    } else {
      state.selectEmployeeIdList = state.selectEmployeeIdList ?? [];
      state.selectEmployeeIdList!.add(id!);
    }
    update(['employee_button']);
  }

  void searchStockChangeRecord(String value) {
    state.searchContent = value;
    onRefresh();
  }
}
