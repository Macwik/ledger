import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/config/api/order_api.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/entity/order/order_dto.dart';
import 'package:ledger/entity/user/user_base_dto.dart';
import 'package:ledger/enum/order_state_type.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/util/text_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/custom_easy_refresh.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/loading.dart';
import 'package:ledger/widget/lottie_indicator.dart';

import 'purchase_record_state.dart';

class PurchaseRecordController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements DisposableInterface {
  final PurchaseRecordState state = PurchaseRecordState();

  late TabController tabController;

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['index'] != null) {
      state.index = arguments['index'];
    }
    onRefresh();
    _queryLedgerUserList();
  }

  @override
  void onInit() {
    tabController = TabController(length: permissionCount(), vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      state.index = index;
      update(['purchase_record_add_bill']);
      clearCondition();
      state.searchContent = '';
      onRefresh();
    });
    super.onInit();
  }

  //筛选里拉取业务员信息
  Future<void> _queryLedgerUserList() async {
    final result = await Http()
        .network<List<UserBaseDTO>>(Method.get, LedgerApi.ledger_user_list);
    if (result.success) {
      state.employeeList = result.d;
      update(['employee_button']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  Future<BasePageEntity<OrderDTO>> _queryData(int currentPage) async {
    return await Http()
        .networkPage<OrderDTO>(Method.post, OrderApi.order_page, data: {
      'page': currentPage,
      'orderTypeList': [state.orderTypeList[state.index].value],
      'userIdList': state.selectEmployeeIdList,
      'orderStatus': state.orderStatus,
      'invalid': state.invalid,
      'searchContent': state.searchContent,
      'startDate': DateUtil.formatDefaultDate(state.startDate),
      'endDate': DateUtil.formatDefaultDate(state.endDate),
    });
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    await _queryData(state.currentPage).then((result) {
      if (true == result.success) {
        state.list?.forEach((element) {
          element.showDateTime =
              showDate(DateUtil.formatDefaultDate2(element.orderDate));
        });
        state.list!.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['purchase_order_list']);
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
    await _queryData(state.currentPage).then((result) {
      state.datetimeSet = {};
      Loading.dismiss();
      if (result.success) {
        state.list = result.d?.result;
        state.list?.forEach((element) {
          element.showDateTime =
              showDate(DateUtil.formatDefaultDate2(element.orderDate));
        });
        state.hasMore = result.d?.hasMore;
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
        update(['purchase_order_list']);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  showDate(String? dateTimeStr) {
    if (dateTimeStr?.isEmpty ?? true) {
      return false;
    }
    var contains = state.datetimeSet.contains(dateTimeStr);
    state.datetimeSet.add(dateTimeStr!);
    return contains;
  }

  void toPurchaseDetail(OrderDTO? purchasePurchaseOrderDTO) {
    if (purchasePurchaseOrderDTO?.orderType == OrderType.ADD_STOCK.value) {
      Get.toNamed(RouteConfig.addStockDetail, arguments: {
        'id': purchasePurchaseOrderDTO?.id,
      })?.then((value) {
        if (ProcessStatus.OK == value) {
          onRefresh();
        }
      });
    } else {
      Get.toNamed(RouteConfig.saleDetail, arguments: {
        'id': purchasePurchaseOrderDTO?.id,
        'orderType': orderType(purchasePurchaseOrderDTO?.orderType)
      })?.then((value) {
        if (ProcessStatus.OK == value) {
          onRefresh();
        }
      });
    }
  }

  String getOrderStatusDesc(OrderDTO? purchasePurchaseOrderDTO) {
    if (purchasePurchaseOrderDTO?.orderType == OrderType.PURCHASE.value) {
      var list = OrderStateType.values;
      for (var value in list) {
        if (value.value == purchasePurchaseOrderDTO?.orderStatus) {
          return value.desc;
        }
      }
      return '';
    }
    return '';
  }

  String totalAmountOrNumber(OrderDTO? purchasePurchaseOrderDTO) {
    if (purchasePurchaseOrderDTO?.orderType ==
        OrderType.PURCHASE_RETURN.value) {
      return '￥- ${(purchasePurchaseOrderDTO?.totalAmount ?? Decimal.zero) - (purchasePurchaseOrderDTO?.discountAmount ?? Decimal.zero)}';
    } else if (purchasePurchaseOrderDTO?.orderType ==
        OrderType.PURCHASE.value) {
      return DecimalUtil.formatAmount(
          (purchasePurchaseOrderDTO?.totalAmount ?? Decimal.zero) -
              (purchasePurchaseOrderDTO?.discountAmount ?? Decimal.zero));
    } else {
      return '${purchasePurchaseOrderDTO?.productNameList?.length}种';
    }
  }

  OrderType orderType(int? orderType) {
    switch (orderType) {
      case 0:
        return OrderType.PURCHASE;
      case 1:
        return OrderType.SALE;
      case 2:
        return OrderType.SALE_RETURN;
      case 3:
        return OrderType.PURCHASE_RETURN;
      case 9:
        return OrderType.ADD_STOCK;
      case 10:
        return OrderType.REFUND;
      default:
        throw Exception('销售记录页无此OrderType');
    }
  }

  //选择业务员
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

  //筛选里选择业务员
  bool isEmployeeSelect(int? employeeId) {
    if (employeeId == null) {
      return false;
    }
    return (state.selectEmployeeIdList != null) &&
        state.selectEmployeeIdList!.contains(employeeId);
  }

  //收款状态
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
    update([
      'screen_btn',
      'switch',
      'purchase_order_status',
      'employee_button',
      'purchase_record_order_type',
      'date_range'
    ]);
  }

  //筛选里‘确定’
  void confirmCondition() {
    onRefresh();
    Get.back();
  }

  //权限控制相关--页面跳转
  Future<void> toAddBill() async {
    List<String>? permissionList = StoreController.to.getPermissionCode();
    if (((state.orderTypeList[state.index].value) ==
            OrderType.PURCHASE.value) &&
        (permissionList
            .contains(PermissionCode.purchase_purchase_order_permission))) {
      await Get.toNamed(RouteConfig.saleBill,
          arguments: {'orderType': OrderType.PURCHASE})?.then((value) {
        onRefresh();
      });
    }
    if (((state.orderTypeList[state.index].value) ==
            OrderType.PURCHASE_RETURN.value) &&
        (permissionList.contains(
            PermissionCode.purchase_purchase_return_order_permission))) {
      await Get.toNamed(RouteConfig.saleBill,
          arguments: {'orderType': OrderType.PURCHASE_RETURN})?.then((value) {
        onRefresh();
      });
    }
    if (((state.orderTypeList[state.index].value) ==
            OrderType.ADD_STOCK.value) &&
        (permissionList
            .contains(PermissionCode.purchase_add_stock_order_permission))) {
      await Get.toNamed(RouteConfig.saleBill,
          arguments: {'orderType': OrderType.ADD_STOCK})?.then((value) {
        onRefresh();
      });
    }
  }

  //权限控制相关--开单按钮是否展示
  String showAddBillsName() {
    if ((state.orderTypeList[state.index].value) == OrderType.PURCHASE.value) {
      return PermissionCode.purchase_purchase_order_permission;
    }
    if ((state.orderTypeList[state.index].value) ==
        OrderType.PURCHASE_RETURN.value) {
      return PermissionCode.purchase_purchase_return_order_permission;
    }
    if ((state.orderTypeList[state.index].value) == OrderType.ADD_STOCK.value) {
      return PermissionCode.purchase_add_stock_order_permission;
    }
    return '';
  }

  //权限控制相关--开单按钮
  String toAddBillsName() {
    if ((state.orderTypeList[state.index].value) == OrderType.PURCHASE.value) {
      return '+ 采购';
    }
    if ((state.orderTypeList[state.index].value) ==
        OrderType.PURCHASE_RETURN.value) {
      return '+ 退货';
    }
    if ((state.orderTypeList[state.index].value) == OrderType.ADD_STOCK.value) {
      return '+ 入库';
    }
    return '';
  }

  void searchPurchaseRecord(String value) {
    state.searchContent = value;
    onRefresh();
  }

  //权限控制相关--标签
  permissionWidget() {
    List<Widget> widgetList = [];
    List<String>? permissionList = StoreController.to.getPermissionCode();
    if (permissionList
        .contains(PermissionCode.purchase_purchase_record_permission)) {
      widgetList.add(Tab(text: '采购'));
    }
    if (permissionList
        .contains(PermissionCode.purchase_purchase_return_record_permission)) {
      widgetList.add(Tab(text: '采购退货'));
    }
    if (permissionList
        .contains(PermissionCode.purchase_add_stock_record_permission)) {
      widgetList.add(Tab(text: '直接入库'));
    }
    return widgetList;
  }

  //权限控制相关--内容body
  widgetTabBarViews() {
    List<Widget> widgetList = [];
    for (int i = 0; i < permissionCount(); i++) {
      widgetList.add(widgetPurchaseRecord());
    }
    return widgetList;
  }

  //权限控制相关--标签数量
  permissionCount() {
    int count = 0;
    List<String>? permissionList = StoreController.to.getPermissionCode();
    if (permissionList
        .contains(PermissionCode.purchase_purchase_record_permission)) {
      state.orderTypeList.add(OrderType.PURCHASE);
      count++;
    }
    if (permissionList
        .contains(PermissionCode.purchase_purchase_return_record_permission)) {
      state.orderTypeList.add(OrderType.PURCHASE_RETURN);
      count++;
    }
    if (permissionList
        .contains(PermissionCode.purchase_add_stock_record_permission)) {
      state.orderTypeList.add(OrderType.ADD_STOCK);
      count++;
    }
    return count;
  }

  widgetPurchaseRecord() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                child: Container(
              height: 100.w,
              padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
              child: SearchBar(
                leading: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 40.w,
                ),
                shadowColor: WidgetStatePropertyAll<Color>(Colors.black26),
                hintStyle: WidgetStatePropertyAll<TextStyle>(
                    TextStyle(fontSize: 34.sp, color: Colors.black26)),
                onChanged: (value) {
                  searchPurchaseRecord(value);
                },
                hintText: '请输入货物名称',
              ),
            )),
            Builder(
              builder: (context) => GestureDetector(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoadAssetImage(
                      'screen',
                      format: ImageFormat.png,
                      color: Colours.text_999,
                      height: 40.w,
                      width: 40.w,
                    ), // 导入的图像
                    SizedBox(width: 8.w), // 图像和文字之间的间距
                    Text(
                      '筛选',
                      style:
                          TextStyle(fontSize: 30.sp, color: Colours.text_666),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: GetBuilder<PurchaseRecordController>(
              id: 'purchase_order_list',
              init: this,
              global: false,
              builder: (_) {
                return CustomEasyRefresh(
                  controller: state.refreshController,
                  onLoad: onLoad,
                  onRefresh: onRefresh,
                  emptyWidget: state.list == null
                      ? LottieIndicator()
                      : state.list?.isEmpty ?? true
                          ? EmptyLayout(hintText: '什么都没有'.tr)
                          : null,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var purchasePurchaseOrderDTO = state.list![index];
                      return InkWell(
                        onTap: () => toPurchaseDetail(purchasePurchaseOrderDTO),
                        child: Column(
                          children: [
                            Offstage(
                              offstage:
                                  purchasePurchaseOrderDTO.showDateTime ?? true,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                    left: 40.w, top: 10.w, bottom: 10.w),
                                color: Colors.white12,
                                child: Text(
                                  DateUtil.formatDefaultDate2(
                                      purchasePurchaseOrderDTO.orderDate),
                                  style: TextStyle(
                                    color: Colours.text_ccc,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                  left: 40.w,
                                  right: 40.w,
                                  top: 20.w,
                                  bottom: 20.w),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            TextUtil.listToStr(
                                                purchasePurchaseOrderDTO
                                                    .productNameList),
                                            style: TextStyle(
                                              color: purchasePurchaseOrderDTO
                                                          .invalid ==
                                                      1
                                                  ? Colours.text_ccc
                                                  : Colours.text_333,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ),
                                      Visibility(
                                          visible: purchasePurchaseOrderDTO
                                                  .invalid ==
                                              1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 2.w,
                                                bottom: 2.w,
                                                left: 4.w,
                                                right: 4.w),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colours.text_999,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Text('已作废',
                                                style: TextStyle(
                                                  color: Colours.text_999,
                                                  fontSize: 26.sp,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          )),
                                      Expanded(
                                        child: Text(
                                            textAlign: TextAlign.right,
                                            getOrderStatusDesc(
                                                purchasePurchaseOrderDTO),
                                            style: TextStyle(
                                              color: purchasePurchaseOrderDTO
                                                          .invalid ==
                                                      1
                                                  ? Colours.text_ccc
                                                  : OrderStateType.DEBT_ACCOUNT
                                                              .value ==
                                                          purchasePurchaseOrderDTO
                                                              .orderStatus
                                                      ? Colors.orange
                                                      : Colours.text_ccc,
                                              fontSize: 26.sp,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 1.w,
                                    margin: EdgeInsets.only(
                                        top: 16.w, bottom: 16.w),
                                    width: double.infinity,
                                    color: Colours.divider,
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            totalAmountOrNumber(
                                                purchasePurchaseOrderDTO),
                                            style: TextStyle(
                                              color: purchasePurchaseOrderDTO
                                                          .invalid ==
                                                      1
                                                  ? Colours.text_ccc
                                                  : Colours.text_333,
                                              fontSize: 34.sp,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                      Expanded(
                                          child: Row(children: [
                                        Text('业务员：',
                                            style: TextStyle(
                                              color: Colours.text_ccc,
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        Text(
                                            purchasePurchaseOrderDTO
                                                    .creatorName ??
                                                '',
                                            style: TextStyle(
                                              color: Colours.text_666,
                                              fontSize: 26.sp,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ])),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.w,
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            (purchasePurchaseOrderDTO
                                                            .orderType ==
                                                        OrderType
                                                            .PURCHASE.value ||
                                                    purchasePurchaseOrderDTO
                                                            .orderType ==
                                                        OrderType
                                                            .ADD_STOCK.value)
                                                ? '${purchasePurchaseOrderDTO.batchNo}'
                                                : DateUtil
                                                    .formatDefaultDateTimeMinute(
                                                        purchasePurchaseOrderDTO
                                                            .gmtCreate),
                                            style: TextStyle(
                                              color: state.orderType ==
                                                      OrderType.PURCHASE
                                                  ? Colours.text_999
                                                  : Colours.text_ccc,
                                              fontSize: 26.sp,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Visibility(
                                              visible: purchasePurchaseOrderDTO
                                                      .customName?.isNotEmpty ??
                                                  false,
                                              child: Text('供应商：',
                                                  style: TextStyle(
                                                    color: Colours.text_ccc,
                                                    fontSize: 22.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ))),
                                          Expanded(
                                              child: Text(
                                                  purchasePurchaseOrderDTO
                                                          .customName ??
                                                      '',
                                                  style: TextStyle(
                                                    color:
                                                        purchasePurchaseOrderDTO
                                                                    .invalid ==
                                                                1
                                                            ? Colours.text_ccc
                                                            : Colours.text_666,
                                                    fontSize: 26.sp,
                                                    fontWeight: FontWeight.w400,
                                                  )))
                                        ],
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Container(
                      height: 2.w,
                      color: Colors.white12,
                      width: double.infinity,
                    ),
                    itemCount: state.list?.length ?? 0,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
