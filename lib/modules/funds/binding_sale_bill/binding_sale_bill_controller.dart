import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/config/api/order_api.dart';
import 'package:ledger/entity/order/order_dto.dart';
import 'package:ledger/entity/user/user_base_dto.dart';
import 'package:ledger/enum/order_state_type.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/toast_util.dart';

import 'binding_sale_bill_state.dart';

class BindingSaleBillController extends GetxController {
  final BindingSaleBillState state = BindingSaleBillState();

  Future<void> initState() async {
    onRefresh();
    _queryLedgerUserList();
  }

  String getOrderTypeDesc(int type) {
    var list = OrderStateType.values;
    for (var value in list) {
      if (value.value == type) {
        return value.desc;
      }
    }
    return '';
  }

  String getOrderStatusDesc(int? orderStatus) {
    var list = OrderStateType.values;
    for (var value in list) {
      if (value.value == orderStatus) {
        return value.desc;
      }
    }
    return '';
  }

  void selectOrder(OrderDTO? orderDTO) {
    Get.back(result: orderDTO);
  }

  Future<BasePageEntity<OrderDTO>> _query(int currentPage) async {
    return await Http()
        .networkPage<OrderDTO>(Method.post, OrderApi.order_page, data: {
      'page': currentPage,
      'orderTypeList': [
        OrderType.PURCHASE.value,
        //OrderType.PURCHASE_RETURN.value  不支持绑定采购退货单
      ],
      'userIdList': state.selectEmployeeIdList,
      'orderStatus': state.orderStatus,
      'startDate': DateUtil.formatDefaultDate(state.startDate),
      'endDate': DateUtil.formatDefaultDate(state.endDate),
      'invalid': 0,
    });
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    _query(state.currentPage).then((result) {
      if (result.success) {
        state.items?.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['order_detail']);
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
    _query(state.currentPage).then((result) {
      if (result.success) {
        state.items = result.d?.result;
        state.hasMore = result.d?.hasMore;
        update(['order_detail']);
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  bool checkOrderStatus(int? orderStatus) {
    return state.orderStatus == orderStatus;
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

  //筛选里清空条件
  void clearCondition() {
    state.startDate = DateTime.now().subtract(Duration(days: 7));
    state.endDate = DateTime.now();
    state.selectEmployeeIdList = null;
    state.orderStatus = null;
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
}
