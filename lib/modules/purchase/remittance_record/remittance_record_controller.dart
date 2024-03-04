import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/payment_api.dart';
import 'package:ledger/config/api/remittance_api.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/remittance/remittance_dto.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/modules/purchase/stock_list/stock_list_state.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/toast_util.dart';

import 'remittance_record_state.dart';

class RemittanceRecordController extends GetxController {
  final RemittanceRecordState state = RemittanceRecordState();

  Future<void> initState() async {
    onRefresh();
    _queryPaymentMethodList();
    _queryTotalRemittance();
  }

  Future<BasePageEntity<RemittanceDTO>> _queryData(
      int currentPage) async {
    return await Http().networkPage<RemittanceDTO>(
        Method.post, RemittanceApi.remittance_record,
        data: {
          'page': currentPage,
          'receiverMethodIdList': state.selectPaymentMethodIdList,
          'searchContent': state.searchContent,
          'startDate': DateUtil.formatDefaultDate(state.startDate),
          'endDate': DateUtil.formatDefaultDate(state.endDate),
          'productIdList':
              (state.productDTO == null || state.productDTO!.id == null)
                  ? null
                  : [state.productDTO!.id],
          'invalid': state.invalid
        });
  }

  //拉取汇款金额合计
  Future<void> _queryTotalRemittance() async {
    final result = await Http()
        .network<Decimal>(Method.post, RemittanceApi.remittance_total, data: {
      'receiverMethodIdList': state.selectPaymentMethodIdList,
      'searchContent': state.searchContent,
      'startDate': DateUtil.formatDefaultDate(state.startDate),
      'endDate': DateUtil.formatDefaultDate(state.endDate),
      'productIdList':
          (state.productDTO == null || state.productDTO!.id == null)
              ? null
              : [state.productDTO!.id],
      'invalid': state.invalid
    });
    if (result.success) {
      state.totalRemittanceAmount = result.d;
      update(['remittance_record_total_amount']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.items?.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['remittance_record']);
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
        update(['remittance_record']);
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

//拉取账户name
  Future<void> _queryPaymentMethodList() async {
    final result = await Http().network<List<PaymentMethodDTO>>(
        Method.get, PaymentApi.LEDGER_PAYMENT_METHOD_LIST);
    if (result.success) {
      state.paymentMethodList = result.d!;
      update(['payment_method_button']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  //筛选里选择账户
  bool isEmployeeSelect(int? employeeId) {
    if (employeeId == null) {
      return false;
    }
    return (state.selectPaymentMethodIdList != null) &&
        state.selectPaymentMethodIdList!.contains(employeeId);
  }

  Future<void> selectProduct() async {
    await Get.toNamed(RouteConfig.stockList,
        arguments: {'select': StockListType.SELECT_PRODUCT})?.then((result) {
      if (result != null) {
        state.productDTO = result;
        update(['remittance_record_product']);
      }
    });
  }

  //筛选里清空条件
  void clearCondition() {
    _queryTotalRemittance();
    state.startDate = DateTime.now().subtract(Duration(days: 7));
    state.endDate = DateTime.now();
    state.selectPaymentMethodIdList = null;
    state.productDTO = null;
    state.invalid = 0;
    update([
      'payment_method_button',
      'switch',
      'remittance_record_product',
      'screen_btn',
      'date_range'
    ]);
  }

  //筛选里‘确定’
  void confirmCondition() {
    onRefresh();
    _queryTotalRemittance();
    Get.back();
  }

  void selectEmployee(int? id) {
    if ((state.selectPaymentMethodIdList != null) &&
        state.selectPaymentMethodIdList!.contains(id)) {
      state.selectPaymentMethodIdList!.remove(id);
      if (state.selectPaymentMethodIdList!.isEmpty) {
        state.selectPaymentMethodIdList = null;
        update(['payment_method_button']);
      }
    } else {
      state.selectPaymentMethodIdList = state.selectPaymentMethodIdList ?? [];
      state.selectPaymentMethodIdList!.add(id!);
    }
    update(['payment_method_button']);
  }

  void toRemittanceDetail(RemittanceDTO remittanceDTO) {
    Get.toNamed(RouteConfig.remittanceDetail,
        arguments: {'remittanceDTO': remittanceDTO})?.then((value) {
      if (ProcessStatus.OK == value) {
        onRefresh();
        _queryTotalRemittance();
      }
    });
  }

  void searchRemittanceRecord(String value) {
    state.searchContent = value;
    onRefresh();
  }
}
