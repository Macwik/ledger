import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/cost_income_api.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/entity/costIncome/cost_income_order_dto.dart';
import 'package:ledger/entity/costIncome/external_order_count_dto.dart';
import 'package:ledger/entity/user/user_base_dto.dart';
import 'package:ledger/enum/cost_order_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/enum/stock_list_type.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/loading.dart';

import 'cost_record_state.dart';

class CostRecordController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements DisposableInterface {
  final CostRecordState state = CostRecordState();

  late TabController tabController;

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['index'] != null) {
      state.index = arguments['index'];
    }
    onRefresh();
    _queryLedgerUserList();
    _queryStatistics();
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      state.index = index;
      update(['cost_record_add_bill']);
      clearCondition();
      state.searchContent = '';
      onRefresh();
      _queryStatistics();
    });
    super.onInit();
  }

  Future<void> _queryStatistics() async {
    final result = await Http().network<ExternalOrderCountDTO>(
        Method.post, CostIncomeApi.cost_record_statistic,
        data: {
          'startDate': DateUtil.formatDefaultDate(state.startDate),
          'endDate': DateUtil.formatDefaultDate(state.endDate),
          'searchContent': state.searchContent,
          'discount': state.orderStatus,
          'invalid': state.invalid,
          'orderType': state.index,
          'userIdList': state.selectEmployeeIdList,
          'labelList': state.costLabel == null ? null : [state.costLabel?.id],
          'bindProduct': state.bindProduct,
          'productList':
              state.productDTO == null ? null : [state.productDTO?.id]
        });
    if (result.success) {
      state.externalOrderCountDTO = result.d;
      update(['cost_record_statistic']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  Future<void> selectDateRange(BuildContext context) async {
    await showDateRangePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDateRange: DateTimeRange(
        start: state.startDate,
        end: state.endDate,
      ),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    ).then((value) {
      if (value != null) {
        state.startDate = value.start;
        state.endDate = value.end;
        update(['date_range']);
      }
    });
  }

  bool isSelectedStoreType(int index) {
    return state.selectedStore == index;
  }

  Future<BasePageEntity<CostIncomeOrderDTO>> _queryData(int currentPage) async {
    return await Http().networkPage<CostIncomeOrderDTO>(
        Method.post, CostIncomeApi.cost_order_list,
        data: {
          'page': currentPage,
          'startDate': DateUtil.formatDefaultDate(state.startDate),
          'endDate': DateUtil.formatDefaultDate(state.endDate),
          'searchContent': state.searchContent,
          'discount': state.orderStatus,
          'invalid': state.invalid,
          'orderType': state.index,
          'userIdList': state.selectEmployeeIdList,
          'labelList': state.costLabel == null ? null : [state.costLabel?.id],
          'bindProduct': state.bindProduct,
          'productList':
              state.productDTO == null ? null : [state.productDTO?.id]
        });
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        result.d?.result?.forEach((element) {
          element.showDateTime =
              showDate(DateUtil.formatDefaultDate2(element.orderDate));
        });
        state.items?.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['costRecord']);
        state.refreshController.finishLoad(state.hasMore ?? false
            ? IndicatorResult.success
            : IndicatorResult.noMore);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishLoad(IndicatorResult.fail);
      }
    });
  }

  Future<void> onRefresh() async {
    state.currentPage = 1;
    Loading.showDuration();
    _queryData(state.currentPage).then((result) {
      state.datetimeSet = {};
      Loading.dismiss();
      if (result.success) {
        state.items = result.d?.result;
        state.items?.forEach((element) {
          element.showDateTime =
              showDate(DateUtil.formatDefaultDate2(element.orderDate));
        });
        state.hasMore = result.d?.hasMore;
        update(['costRecord','cost_record_statistic']);
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  bool selectedProfitType(int? orderStatus) {
    return state.orderStatus == orderStatus;
  }

  Future<void> _queryLedgerUserList() async {
    final result = await Http()
        .network<List<UserBaseDTO>>(Method.get, LedgerApi.ledger_user_list);
    if (result.success) {
      state.employeeList = result.d;
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

  showDate(String? dateTimeStr) {
    if (dateTimeStr?.isEmpty ?? true) {
      return false;
    }
    var contains = state.datetimeSet.contains(dateTimeStr);
    state.datetimeSet.add(dateTimeStr!);
    return contains;
  }


  //筛选里清空条件
  void clearCondition() {
    state.startDate = DateTime.now().subtract(Duration(days: 90));
    state.endDate = DateTime.now();
    state.selectEmployeeIdList = null;
    state.orderStatus = null;
    state.costLabel = null;
    state.invalid = 0;
    state.bindProduct = null;
    state.productDTO = null;
    update([
      'screen_btn',
      'invalid_visible',
      'sale_order_status',
      'employee_button',
      'date_range',
      'costType',
      'productType'
          'switch',
      'unbinding_visible'
    ]);
  }

  //筛选里‘确定’
  void confirmCondition() {
    onRefresh();
    _queryStatistics();
    Get.back();
  }

  void selectEmployee(int? id) {
    if ((state.selectEmployeeIdList != null) &&
        state.selectEmployeeIdList!.contains(id)) {
      state.selectEmployeeIdList!.remove(id);
      if (state.selectEmployeeIdList!.isEmpty) {
        state.selectEmployeeIdList = null;
      }
    } else {
      state.selectEmployeeIdList = state.selectEmployeeIdList ?? [];
      state.selectEmployeeIdList!.add(id!);
    }
    update(['employee_button']);
  }

  void toCostDetail(CostIncomeOrderDTO? costIncomeOrderDTO) {
    Get.toNamed(RouteConfig.costDetail, arguments: {
      'id': costIncomeOrderDTO?.id,
      'orderType': costIncomeOrderDTO?.orderType
    })?.then((result) {
      if (ProcessStatus.OK == result) {
        onRefresh();
      }
    });
  }

  void searchCostRecord(String value) {
    state.searchContent = value;
    onRefresh();
  }

  Future<void> selectCostType() async {
    if (state.index == 0) {
      var result = await Get.toNamed(RouteConfig.costType,
          arguments: {'costOrderType': CostOrderType.COST});
      if (result != null) {
        state.costLabel = result;
        update(['costType']);
      }
    } else {
      var result = await Get.toNamed(RouteConfig.costType,
          arguments: {'costOrderType': CostOrderType.INCOME});
      if (result != null) {
        state.costLabel = result;
        update(['costType']);
      }
    }
  }

  Future<void> selectProductType() async {
    var result = await Get.toNamed(RouteConfig.stockList,
        arguments: {'select': StockListType.SELECT_PRODUCT});
    if (result != null) {
      state.productDTO = result;
      update(['productType']);
    }
  }

  void toAddBill() {
    if (state.index == 0) {
      Get.toNamed(RouteConfig.costBill,
          arguments: {'costOrderType': CostOrderType.COST})?.then((value) {
        onRefresh();
      });
    } else {
      Get.toNamed(RouteConfig.costBill,
          arguments: {'costOrderType': CostOrderType.INCOME})?.then((value) {
        onRefresh();
      });
    }
  }
}
