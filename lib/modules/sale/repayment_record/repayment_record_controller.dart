import 'package:easy_refresh/easy_refresh.dart';
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

class RepaymentRecordController extends GetxController {
  final RepaymentRecordState state = RepaymentRecordState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['customType'] != null) {
      state.customType = arguments['customType'];
    }
    if (CustomType.CUSTOM.value == state.customType) {
      state.initialIndex = 0;
    } else {
      state.initialIndex = 1;
    }
    onRefresh();
  }

  void switchIndex(int tabIndex) {
    state.searchContent = '';
    state.initialIndex = tabIndex;
    update(['title']);
    onRefresh();
  }

  void searchCustom(String searchValue) {}

  Future<BasePageEntity<RepaymentDTO>> _queryData(int currentPage) async {
    return await Http().networkPage<RepaymentDTO>(
        Method.post, RepaymentApi.repayment_record,
        data: {
          'page': currentPage,
          'customType': state.initialIndex,
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
    state.startDate = DateTime.now().subtract(Duration(days: 7));
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
    Get.toNamed(RouteConfig.repaymentDetail, arguments: {'id': id})
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
}
