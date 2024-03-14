import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/order_state_type.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/picker_date_utils.dart';
import 'package:ledger/util/text_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/custom_easy_refresh.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/lottie_indicator.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'package:ledger/widget/will_pop.dart';
import 'sale_record_controller.dart';

class SaleRecordView extends StatelessWidget {
  final controller = Get.find<SaleRecordController>();

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:100.w,
        leading: BackButton(
            onPressed: () {
              Get.until((route) {
                return (route.settings.name == RouteConfig.purchase) ||
                    (route.settings.name == RouteConfig.sale) ||
                    (route.settings.name == RouteConfig.main);
              });
            },
            color: Colors.white),
        backgroundColor: Colours.primary,
        title: Text(
          (controller.state.orderType == OrderType.SALE) ||
                  (controller.state.orderType == OrderType.SALE_RETURN)
              ? '销售记录'
              : '采购记录',
          style: TextStyle(color: Colors.white,fontSize: 42.sp),
        ),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Container(
            color: Colours.select_bg,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 100.w, left: 20.w, right: 20.w),
            child: Stack(children: [
              Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                onPressed: () => Get.back(),
                                icon: Icon(
                                  Icons.close_sharp,
                                  size: 40.w,
                                )),
                          )),
                      Text(
                        '筛选',
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Expanded(flex: 1, child: Container())
                    ],
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                  GetBuilder<SaleRecordController>(
                      id: 'date_range',
                      init: controller,
                      global: false,
                      builder: (_) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 10)),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    // 背景色
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(35.0), // 圆角
                                        side: BorderSide(
                                          width: 1.0, // 边框宽度
                                          color: Colours.primary, // 边框颜色
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    PickerDateUtils.pickerDate(context,
                                        (result) {
                                      if (null != result) {
                                        if (result.compareTo(
                                                controller.state.endDate) >
                                            0) {
                                          Toast.show('起始时间需要小于结束时间');
                                          return;
                                        }
                                        controller.state.startDate = result;
                                        controller.update(['date_range']);
                                      }
                                    });
                                  },
                                  child: Text(
                                    DateUtil.formatDefaultDate(
                                        controller.state.startDate),
                                    style: TextStyle(
                                      color: Colours.button_text,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                ' 至',
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 10)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white), // 背景色
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                35.0), // 圆角
                                            side: BorderSide(
                                              width: 1.0, // 边框宽度
                                              color: Colours.primary, // 边框颜色
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        PickerDateUtils.pickerDate(context,
                                            (result) {
                                          if (null != result) {
                                            if (result.compareTo(controller
                                                    .state.startDate) <
                                                0) {
                                              Toast.show('结束时间需要大于起始时间');
                                              return;
                                            }
                                            controller.state.endDate = result;
                                            controller.update(['date_range']);
                                          }
                                        });
                                      },
                                      child: Text(
                                        DateUtil.formatDefaultDate(
                                            controller.state.endDate),
                                        style: TextStyle(
                                          color: Colours.button_text,
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ))),
                            ]);
                      }),
                  SizedBox(
                    height: 40.w,
                  ),
                  Text(
                    '业务员',
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  GetBuilder<SaleRecordController>(
                    id: 'employee_button',
                    init: controller,
                    global: false,
                    builder: (controller) => controller
                                .state.employeeList?.isEmpty ??
                            true
                        ? EmptyLayout(hintText: '什么都没有')
                        : Wrap(
                            spacing: 12.0, // 设置标签之间的水平间距
                            runSpacing: 12.0, // 设置标签之间的垂直间距
                            children: [
                                InkWell(
                                    onTap: () {
                                      controller.state.selectEmployeeIdList =
                                          null;
                                      controller.update(['employee_button']);
                                    },
                                    child: Chip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(35),
                                        // 设置圆角半径
                                        side: BorderSide(
                                            color: Colours.primary,
                                            width: 1), // 设置边框颜色和宽度
                                      ),
                                      label: Text(
                                        '全部',
                                        style: TextStyle(
                                          fontSize: 30.sp,
                                          color: controller.state
                                                      .selectEmployeeIdList ==
                                                  null
                                              ? Colors.white
                                              : Colours.text_333,
                                        ),
                                      ),
                                      backgroundColor: controller
                                                  .state.selectEmployeeIdList ==
                                              null
                                          ? Colours.primary
                                          : Colors.white,
                                    )),
                                ...List.generate(
                                  controller
                                      .state.itemCount!, // itemCount 是标签的数量
                                  (index) {
                                    var employee =
                                        controller.state.employeeList![index];
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return InkWell(
                                          onTap: () => controller
                                              .selectEmployee(employee.id),
                                          child: Chip(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              // 设置圆角半径
                                              side: BorderSide(
                                                  color: Colours.primary,
                                                  width: 1), // 设置边框颜色和宽度
                                            ),
                                            backgroundColor:
                                                controller.isEmployeeSelect(
                                                        employee.id)
                                                    ? Colours.primary
                                                    : Colors.white,
                                            label: Text(
                                              employee.username ?? '',
                                              style: TextStyle(
                                                fontSize: 30.sp,
                                                color:
                                                    controller.isEmployeeSelect(
                                                            employee.id)
                                                        ? Colors.white
                                                        : Colours.text_333,
                                              ),
                                            ),
                                            // 添加额外的样式、点击事件等
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ]),
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                  Text(
                    '收款状态',
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  GetBuilder<SaleRecordController>(
                    id: 'sale_order_status',
                    init: controller,
                    global: false,
                    builder: (controller) => Wrap(
                      children: [
                        TextButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.checkOrderStatus(null)
                                ? Colours.primary
                                : Colors.white,
                            foregroundColor: controller.checkOrderStatus(null)
                                ? Colors.white
                                : Colours.text_333,
                            side: BorderSide(
                              color: Colours.primary, // 添加边框颜色，此处为灰色
                              width: 1.0, // 设置边框宽度
                            ),
                          ),
                          onPressed: () {
                            controller.state.orderStatus = null;
                            controller.update(['sale_order_status']);
                          },
                          child: Text(
                            '全部',
                            style: TextStyle(
                              fontSize: 30.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        TextButton(
                          onPressed: () {
                            controller.state.orderStatus = 1;
                            controller.update(['sale_order_status']);
                          },
                          child: Text(
                            '已结清',
                            style: TextStyle(
                              fontSize: 30.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.checkOrderStatus(1)
                                ? Colours.primary
                                : Colors.white,
                            foregroundColor: controller.checkOrderStatus(1)
                                ? Colors.white
                                : Colours.text_333,
                            side: BorderSide(
                              color: Colours.primary, // 添加边框颜色，此处为灰色
                              width: 1.0, // 设置边框宽度
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        TextButton(
                          onPressed: () {
                            controller.state.orderStatus = 0;
                            controller.update(['sale_order_status']);
                          },
                          child: Text(
                            '未结清',
                            style: TextStyle(
                              fontSize: 30.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.checkOrderStatus(0)
                                ? Colours.primary
                                : Colors.white,
                            foregroundColor: controller.checkOrderStatus(0)
                                ? Colors.white
                                : Colours.text_333,
                            side: BorderSide(
                              color: Colours.primary, // 添加边框颜色，此处为灰色
                              width: 1.0, // 设置边框宽度
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                  Text(
                    '单据类型',
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  GetBuilder<SaleRecordController>(
                    id: 'sale_record_order_type',
                    init: controller,
                    global: false,
                    builder: (controller) => Wrap(
                      children: [
                        TextButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SalesRecordSelectType.ALL ==
                                    controller.checkSelectOrderType()
                                ? Colours.primary
                                : Colors.white,
                            foregroundColor: SalesRecordSelectType.ALL ==
                                    controller.checkSelectOrderType()
                                ? Colors.white
                                : Colours.text_333,
                            side: BorderSide(
                              color: Colours.primary, // 添加边框颜色，此处为灰色
                              width: 1.0, // 设置边框宽度
                            ),
                          ),
                          onPressed: () {
                            (controller.state.orderType == OrderType.SALE)
                                ? controller.state.typeList = [
                                    OrderType.SALE_RETURN.value,
                                    OrderType.SALE.value
                                  ]
                                : controller.state.typeList = [
                                    OrderType.PURCHASE_RETURN.value,
                                    OrderType.PURCHASE.value
                                  ];
                            controller.update(['sale_record_order_type']);
                          },
                          child: Text(
                            '全部',
                            style: TextStyle(
                              fontSize: 30.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        TextButton(
                          onPressed: () {
                            (controller.state.orderType == OrderType.SALE)
                                ? controller.state.typeList = [
                                    OrderType.SALE.value
                                  ]
                                : controller.state.typeList = [
                                    OrderType.PURCHASE.value
                                  ];
                            controller.update(['sale_record_order_type']);
                          },
                          child: Text(
                            controller.state.orderType == OrderType.SALE
                                ? '销售单'
                                : '采购单',
                            style: TextStyle(
                              fontSize: 30.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SalesRecordSelectType.COMMON ==
                                    controller.checkSelectOrderType()
                                ? Colours.primary
                                : Colors.white,
                            foregroundColor: SalesRecordSelectType.COMMON ==
                                    controller.checkSelectOrderType()
                                ? Colors.white
                                : Colours.text_333,
                            side: BorderSide(
                              color: Colours.primary, // 添加边框颜色，此处为灰色
                              width: 1.0, // 设置边框宽度
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        TextButton(
                          onPressed: () {
                            (controller.state.orderType == OrderType.SALE)
                                ? controller.state.typeList = [
                                    OrderType.SALE_RETURN.value
                                  ]
                                : controller.state.typeList = [
                                    OrderType.PURCHASE_RETURN.value
                                  ];
                            controller.update(['sale_record_order_type']);
                          },
                          child: Text(
                            '退货单',
                            style: TextStyle(
                              fontSize: 30.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SalesRecordSelectType.RETURN ==
                                    controller.checkSelectOrderType()
                                ? Colours.primary
                                : Colors.white,
                            foregroundColor: SalesRecordSelectType.RETURN ==
                                    controller.checkSelectOrderType()
                                ? Colors.white
                                : Colours.text_333,
                            side: BorderSide(
                              color: Colours.primary, // 添加边框颜色，此处为灰色
                              width: 1.0, // 设置边框宽度
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                  GetBuilder<SaleRecordController>(
                      id: 'switch',
                      init: controller,
                      global: false,
                      builder: (_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '已作废单据',
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  controller.state.invalid == null
                                      ? '显示'
                                      : '不显示',
                                  style: TextStyle(color: Colours.text_999),
                                ),
                                Switch(
                                    trackOutlineColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Colours.primary; // 设置轨道边框颜色
                                      }
                                      return Colors.grey; // 默认的轨道边框颜色
                                    }),
                                    inactiveThumbColor: Colors.grey[300],
                                    value: controller.state.invalid == null,
                                    onChanged: (value) {
                                      controller.state.invalid =
                                          value ? null : 0;
                                      controller.update(['switch']);
                                    })
                              ],
                            )
                          ],
                        );
                      })
                ],
              ),
              Positioned(
                bottom: 100.w,
                right: 20.w,
                left: 20.w,
                child: GetBuilder<SaleRecordController>(
                    id: 'screen_btn',
                    init: controller,
                    global: false,
                    builder: (logic) {
                      return Row(
                        children: [
                          Expanded(
                            child: ElevatedBtn(
                              elevation: 2,
                              margin: EdgeInsets.only(top: 80.w),
                              size: Size(double.infinity, 90.w),
                              onPressed: () => controller.clearCondition(),
                              radius: 15.w,
                              backgroundColor: Colors.white,
                              text: '重置',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: ElevatedBtn(
                              onPressed: () => controller.confirmCondition(),
                              elevation: 2,
                              margin: EdgeInsets.only(top: 80.w),
                              size: Size(double.infinity, 90.w),
                              radius: 15.w,
                              backgroundColor: Colours.primary,
                              text: '确定',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              )
            ])),
      ),
      body: MyWillPop(
          onWillPop: () async {
            Get.until((route) {
              return ((route.settings.name == RouteConfig.sale) ||
                  (route.settings.name == RouteConfig.purchase) ||
                  (route.settings.name == RouteConfig.main));
            });
            return Future(() => true);
          },
          child: DefaultTabController(
            initialIndex: 0,
            length: controller.state.orderType == OrderType.PURCHASE ? 2 : 3,
            child:  Column(
                children: [
                  Container(
                    color: Colors.white,
                      height: 90.w, // 调整TabBar高度
                      child: TabBar(
                       // controller:_tabController(),
                    tabs: [
                      Tab(text:  controller.state.orderType == OrderType.PURCHASE
                      ?'采购':'销售',),
                      Tab(text: controller.state.orderType == OrderType.PURCHASE
                      ?'采购退货':'销售退货',),
                      if (controller.state.orderType == OrderType.SALE)
                        Tab(text: '退款'),
                    ],
                    indicatorWeight: 3.w,
                    indicatorPadding: EdgeInsets.all(0),
                    labelPadding: EdgeInsets.all(0),
                    isScrollable: false,
                    indicatorColor: Colours.primary,
                    unselectedLabelColor: Colours.text_999,
                    unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(fontWeight: FontWeight.w500),
                    labelColor: Colours.primary,
                  )
                  ),
                  Expanded(
                      child: TabBarView(children: [
                        widgetSaleRecord(),
                        widgetSaleRecord(),
                        if (controller.state.orderType == OrderType.SALE)widgetSaleRecord(),
                      ]))
                ],
              ),
          )
      ),
      floatingActionButton: PermissionWidget(
          permissionCode: PermissionCode.sales_sale_order_permission,
          child: GetBuilder(
              id: 'sale_record_add_bill',
              builder: (_){
            return  Container(
                width: 90.0,
                height: 66.0,
                margin: EdgeInsets.all(30.w),
                child: FloatingActionButton(
                  onPressed: () =>controller.toAddBill(),
                  child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(controller.toRetailBillName(),
                            style: TextStyle(fontSize: 32.sp),
                          ),
                        ],
                      )), // 按钮上显示的图标
                ));
          })
         ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }

  widgetSaleRecord() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          height: 120.w,
          margin: EdgeInsets.only(
               left: 10.w, right: 10.w),
          padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
          child: SearchBar(
            leading: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            onChanged: (value) {
              controller.searchSalesRecord(value);
            },
            hintText: '请输入货物名称',
          ),
        ),
        Expanded(
          child: GetBuilder<SaleRecordController>(
              id: 'sales_order_list',
              init: controller,
              global: false,
              builder: (_) {
                return CustomEasyRefresh(
                  controller: controller.state.refreshController,
                  onLoad: controller.onLoad,
                  onRefresh: controller.onRefresh,
                  emptyWidget: controller.state.list == null
                      ? LottieIndicator()
                      : controller.state.list?.isEmpty ?? true
                      ? EmptyLayout(hintText: '什么都没有'.tr)
                      : null,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var salePurchaseOrderDTO =
                      controller.state.list![index];
                      return InkWell(
                        onTap: () => controller.toSalesDetail(salePurchaseOrderDTO),
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
                                      Visibility(
                                          visible: (salePurchaseOrderDTO
                                              .orderType ==
                                              OrderType.SALE_RETURN
                                                  .value) ||
                                              (salePurchaseOrderDTO
                                                  .orderType ==
                                                  OrderType
                                                      .PURCHASE_RETURN
                                                      .value),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16.w),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 4.w),
                                            decoration: (BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    (36)),
                                                border: Border.all(
                                                    color: Colors.orange,
                                                    width: 3.w),
                                                color: Colors.white)),
                                            child: Text(
                                              '退',
                                              style: TextStyle(
                                                fontSize: 28.sp,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          )),
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
                                          visible: salePurchaseOrderDTO
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
                                              BorderRadius.circular(
                                                  8.0),
                                            ),
                                            child: Text('已作废',
                                                style: TextStyle(
                                                  color: Colours.text_999,
                                                  fontSize: 26.sp,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                )),
                                          )),
                                      Expanded(
                                        child: Text(
                                            textAlign: TextAlign.right,
                                            controller.getOrderStatusDesc(
                                                salePurchaseOrderDTO
                                                    .orderStatus),
                                            style: TextStyle(
                                              color: salePurchaseOrderDTO
                                                  .invalid ==
                                                  1
                                                  ? Colours.text_ccc
                                                  : OrderStateType
                                                  .DEBT_ACCOUNT
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
                                            controller.totalAmount(
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
                                                salePurchaseOrderDTO
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
                                            controller.state.orderType == OrderType.PURCHASE
                                                ? '${salePurchaseOrderDTO.batchNo}'
                                                : DateUtil.formatDefaultDateTimeMinute(
                                                salePurchaseOrderDTO.gmtCreate),
                                            style: TextStyle(
                                              color:  controller.state.orderType == OrderType.PURCHASE
                                                  ?Colours.text_999
                                                  :Colours.text_ccc,
                                              fontSize: 26.sp,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                      Expanded(
                                          child: Row(
                                            children: [
                                              Visibility(
                                                  visible:
                                                  salePurchaseOrderDTO
                                                      .customName
                                                      ?.isNotEmpty ??
                                                      false,
                                                  child: Text(
                                                      (controller.state.orderType == OrderType.SALE) ||
                                                          (controller.state.orderType == OrderType.SALE_RETURN)
                                                          ? '客户：'
                                                          :  '供应商：',
                                                      style: TextStyle(
                                                        color:
                                                        Colours.text_ccc,
                                                        fontSize: 22.sp,
                                                        fontWeight:
                                                        FontWeight.w500,
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
                                                            : Colours
                                                            .text_666,
                                                        fontSize: 26.sp,
                                                        fontWeight:
                                                        FontWeight.w400,
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
                    itemCount: controller.state.list?.length ?? 0,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
