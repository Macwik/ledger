import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/repayment_api.dart';
import 'package:ledger/entity/repayment/repayment_dto.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/toast_util.dart';

import 'repayment_record_state.dart';

class RepaymentRecordController extends GetxController  with GetSingleTickerProviderStateMixin implements DisposableInterface {
  final RepaymentRecordState state = RepaymentRecordState();

  late TabController tabController;

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['customType'] != null) {
      state.customType = arguments['customType'];
    }
    if (CustomType.CUSTOM.value == state.customType) {
      state.index = 0;
    } else {
      state.index = 1;
    }
    onRefresh();
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      state.index = index;
      clearCondition();
      onRefresh();
    });
    super.onInit();
  }

  Future<BasePageEntity<RepaymentDTO>> _queryData(int currentPage) async {
    return await Http().networkPage<RepaymentDTO>(
        Method.post, RepaymentApi.repayment_record,
        data: {
          'page': currentPage,
          'customType': state.index,
          'searchContent': state.searchContent,
          'startDate': DateUtil.formatDefaultDate(state.startDate),
          'endDate': DateUtil.formatDefaultDate(state.endDate),
          'invalid': state.invalid
        });
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.items?.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['custom_detail', 'supplier_detail']);
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
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.items = result.d?.result;
        state.hasMore = result.d?.hasMore;
        update(['custom_detail', 'supplier_detail']);
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  //筛选里清空条件
  void clearCondition() {
    state.startDate = DateTime.now().subtract(Duration(days: 90));
    state.endDate = DateTime.now();
    state.invalid = 0;
    update(['date_range', 'switch']);
  }

  //筛选里‘确定’
  void confirmCondition() {
    onRefresh();
    Get.back();
  }

  void toRepaymentDetail(int? id) {
    Get.toNamed(RouteConfig.repaymentDetail, arguments: {'id': id,'index':state.index})
        ?.then((value) {
      if (ProcessStatus.OK == value) {
        onRefresh();
      }
    });
  }

  void searchRepaymentRecord(String value) {
    state.searchContent = value;
    onRefresh();
  }

  void toRepaymentBill() {
    Get.toNamed(RouteConfig.repaymentBill,arguments: {'customType':CustomType.SUPPLIER.value})?.then((value) {
      if(CustomType.SUPPLIER.value == value){
        state.customType = value;
      }
      onRefresh();
    });
  }
}
