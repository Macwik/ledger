import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
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
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';

import 'sale_record_state.dart';

class SaleRecordController extends GetxController with GetSingleTickerProviderStateMixin implements DisposableInterface {
  final SaleRecordState state = SaleRecordState();

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
      state.index = tabController.index;
      tabController.animateTo(state.index);
      update(['sale_record_add_bill','sale_order_status']);
      clearCondition();
      onRefresh();
    });
    super.onInit();
  }

  Future<BasePageEntity<OrderDTO>> _queryData(int currentPage) async {
    return await Http().networkPage<OrderDTO>(Method.post, OrderApi.order_page, data: {
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


  //权限控制相关--内容body
  widgetTabBarViews() {
    List<Widget> widgetList = [];
    for (int i = 0; i < permissionCount(); i++) {
      widgetList.add(widgetSaleRecord());
    }
    return widgetList;
  }

  //权限控制相关--标签数量
  permissionCount() {
    int count = 0;
    List<String>? permissionList = StoreController.to.getPermissionCode();
    if (permissionList.contains(PermissionCode.sales_sale_return_permission)) {
      state.orderTypeList.add(OrderType.SALE);
      count++;
    }
    if (permissionList.contains(PermissionCode.sales_return_sale_record_permission)) {
      state.orderTypeList.add(OrderType.SALE_RETURN);
      count++;
    }
    if (permissionList.contains(PermissionCode.sales_refund_sale_record_permission)) {
      state.orderTypeList.add(OrderType.REFUND);
      count++;
    }
    return count;
  }

  //权限控制相关--标签
  permissionWidget() {
    List<Widget> widgetList = [];
    List<String>? permissionList = StoreController.to.getPermissionCode();
    if (permissionList.contains(PermissionCode.sales_sale_order_permission)) {
      widgetList.add(Tab(text: '销售'));
    }
    if (permissionList.contains(PermissionCode.sales_sale_return_permission)) {
      widgetList.add(Tab(text: '销售退货'));
    }
    if (permissionList.contains(PermissionCode.sales_sale_refund_permission)) {
      widgetList.add(Tab(text: '仅退款'));
    }
    return widgetList;
  }

  //权限控制相关--开单按钮
  String toAddBillsName() {
    if ((state.orderTypeList[state.index].value)==OrderType.SALE.value) {
      return '+ 销售';
    }
    if  ((state.orderTypeList[state.index].value)==OrderType.SALE_RETURN.value) {
      return '+ 退货';
    }
    if  ((state.orderTypeList[state.index].value)==OrderType.REFUND.value) {
      return '+退款';
    }
    return '';
  }

  //权限控制相关--页面跳转
  Future<void> toAddBill() async {
    if  ((state.orderTypeList[state.index].value)==OrderType.SALE.value) {
      await Get.toNamed(RouteConfig.retailBill,
          arguments: {'orderType': OrderType.SALE})
          ?.then((value) {
        onRefresh();
      });
    }
     if ((state.orderTypeList[state.index].value)==OrderType.SALE_RETURN.value) {
      await Get.toNamed(RouteConfig.retailBill,
          arguments: {'orderType': OrderType.SALE_RETURN})
          ?.then((value) async {
        await onRefresh();
      });
    }
     if ((state.orderTypeList[state.index].value)==OrderType.REFUND.value) {
      await Get.toNamed(RouteConfig.retailBill,
          arguments: {'orderType': OrderType.REFUND})
          ?.then((value) {
        onRefresh();
      });
    }
  }

  //主体布局
  widgetSaleRecord() {
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
                    shadowColor: MaterialStatePropertyAll<Color>(Colors.black26),
                    hintStyle: MaterialStatePropertyAll<TextStyle>(
                        TextStyle(fontSize: 34.sp, color: Colors.black26)),
                    onChanged: (value) {
                      searchSalesRecord(value);
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
          child: GetBuilder<SaleRecordController>(
              id: 'sales_order_list',
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
                      var salePurchaseOrderDTO = state.list![index];
                      return InkWell(
                        onTap: () =>
                            toSalesDetail(salePurchaseOrderDTO),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: 40.w, top: 10.w, bottom: 10.w),
                              color: Colors.white12,
                              child: Text(
                                DateUtil.formatDefaultDate2(
                                    salePurchaseOrderDTO.orderDate),
                                style: TextStyle(
                                  color: Colours.text_ccc,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
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
                                                salePurchaseOrderDTO
                                                    .productNameList),
                                            style: TextStyle(
                                              color: salePurchaseOrderDTO
                                                  .invalid ==
                                                  1
                                                  ? Colours.text_ccc
                                                  : Colours.text_333,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                      Visibility(
                                          visible:
                                          salePurchaseOrderDTO.invalid == 1,
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
                                            getOrderStatusDesc(salePurchaseOrderDTO),
                                            style: TextStyle(
                                              color: salePurchaseOrderDTO
                                                  .invalid ==
                                                  1
                                                  ? Colours.text_ccc
                                                  : OrderStateType.DEBT_ACCOUNT
                                                  .value ==
                                                  salePurchaseOrderDTO
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
                                            totalAmount(
                                                salePurchaseOrderDTO),
                                            style: TextStyle(
                                              color: salePurchaseOrderDTO
                                                  .invalid ==
                                                  1
                                                  ? Colours.text_ccc
                                                  : Colors.red[600],
                                              fontSize: 32.sp,
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
                                                salePurchaseOrderDTO.creatorName ??
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
                                            state.orderType ==
                                                OrderType.PURCHASE
                                                ? '${salePurchaseOrderDTO.batchNo}'
                                                : DateUtil
                                                .formatDefaultDateTimeMinute(
                                                salePurchaseOrderDTO
                                                    .gmtCreate),
                                            style: TextStyle(
                                              color:
                                              state.orderType ==
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
                                                  visible: salePurchaseOrderDTO
                                                      .customName?.isNotEmpty ??
                                                      false,
                                                  child: Text(
                                                      (state.orderType ==
                                                          OrderType.SALE) ||
                                                          (state
                                                              .orderType ==
                                                              OrderType
                                                                  .SALE_RETURN)
                                                          ? '客户：'
                                                          : '供应商：',
                                                      style: TextStyle(
                                                        color: Colours.text_ccc,
                                                        fontSize: 22.sp,
                                                        fontWeight: FontWeight.w500,
                                                      ))),
                                              Expanded(
                                                  child: Text(
                                                      salePurchaseOrderDTO
                                                          .customName ??
                                                          '',
                                                      style: TextStyle(
                                                        color: salePurchaseOrderDTO
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

  //收款状态
  bool checkOrderStatus(int? orderStatus) {
    return state.orderStatus == orderStatus;
  }
   //收款状态
  String getOrderStatusDesc(OrderDTO? salePurchaseOrderDTO) {
    if (salePurchaseOrderDTO?.orderType == OrderType.SALE.value) {
      var list = OrderStateType.values;
      for (var value in list) {
        if (value.value == salePurchaseOrderDTO?.orderStatus) {
          return value.desc;
        }
      }
      return '';
    }
    return '';
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    await _queryData(state.currentPage).then((result) {
      if (true == result.success) {
        state.list!.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['sales_order_list']);
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
      if (true == result.success) {
        state.list = result.d?.result;
        state.hasMore = result.d?.hasMore;
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
        update(['sales_order_list']);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
      Loading.dismiss();
    });
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
    state.startDate = DateTime.now().subtract(Duration(days: 90));
    state.endDate = DateTime.now();
    state.selectEmployeeIdList = null;
    state.orderStatus = null;
    state.invalid = 0;
    update([
      'screen_btn',
      'switch',
      'sale_order_status',
      'employee_button',
      'sale_record_order_type',
      'date_range'
    ]);
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

  void searchSalesRecord(String value) {
    state.searchContent = value;
    onRefresh();
  }

  void toSalesDetail(OrderDTO? salePurchaseOrderDTO) {
    Get.toNamed(RouteConfig.saleDetail, arguments: {
      'id': salePurchaseOrderDTO?.id,
      'orderType': orderType(salePurchaseOrderDTO?.orderType)
    })?.then((value) {
      if (ProcessStatus.OK == value) {
        onRefresh();
      }
    });
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

  String totalAmount(OrderDTO salePurchaseOrderDTO) {
    if (salePurchaseOrderDTO.orderType == OrderType.SALE.value) {
      return DecimalUtil.formatAmount(
          (salePurchaseOrderDTO.totalAmount ?? Decimal.zero) -
              (salePurchaseOrderDTO.discountAmount ?? Decimal.zero));
    } else {
      return '￥- ${(salePurchaseOrderDTO.totalAmount ?? Decimal.zero) - (salePurchaseOrderDTO.discountAmount ?? Decimal.zero)}';
    }
  }

}
