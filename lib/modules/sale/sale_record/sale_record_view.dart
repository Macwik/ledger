import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/picker_date_utils.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'package:ledger/widget/will_pop.dart';
import 'sale_record_controller.dart';

class SaleRecordView extends StatelessWidget {
  final controller = Get.find<SaleRecordController>();

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
          backPressed: () {
            Get.until((route) {
              return (route.settings.name == RouteConfig.main)|| (route.settings.name == RouteConfig.more);
            });
          },
          title: '销售记录'),
      endDrawer: Drawer(
        width: ScreenUtil().screenWidth * 0.8,
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
                                    padding: WidgetStateProperty.all(
                                        EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 10)),
                                    backgroundColor:
                                    WidgetStateProperty.all(Colors.white),
                                    // 背景色
                                    shape: WidgetStateProperty.all(
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
                                        padding: WidgetStateProperty.all(
                                            EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 10)),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white), // 背景色
                                        shape: WidgetStateProperty.all(
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
                  GetBuilder<SaleRecordController>(
                      id: 'sale_order_status',
                      init: controller,
                      global: false,
                      builder: (controller) => Visibility(
                          visible: controller.state.index == 0,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 20.w),
                            child: Text(
                              '收款状态',
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ))),
                  GetBuilder<SaleRecordController>(
                      id: 'sale_order_status',
                      init: controller,
                      global: false,
                      builder: (controller) => Visibility(
                            visible: controller.state.index == 0,
                            child: Wrap(
                              children: [
                                TextButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.checkOrderStatus(null)
                                            ? Colours.primary
                                            : Colors.white,
                                    foregroundColor:
                                        controller.checkOrderStatus(null)
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
                                    backgroundColor:
                                        controller.checkOrderStatus(1)
                                            ? Colours.primary
                                            : Colors.white,
                                    foregroundColor:
                                        controller.checkOrderStatus(1)
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
                                    backgroundColor:
                                        controller.checkOrderStatus(0)
                                            ? Colours.primary
                                            : Colors.white,
                                    foregroundColor:
                                        controller.checkOrderStatus(0)
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
                          )),
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
                                    WidgetStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
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
            EasyLoading.dismiss();
            Get.until((route) {
              return (route.settings.name == RouteConfig.main)|| (route.settings.name == RouteConfig.more);
            });
            return Future(() => true);
          },
          child: DefaultTabController(
            initialIndex: 0,
            length: controller.permissionCount(),
            child: Column(
              children: [
                Container(
                    color: Colors.white,
                    height: 90.w, // 调整TabBar高度
                    child: TabBar(
                      controller: controller.tabController,
                      tabs:controller. permissionWidget(),
                      indicatorWeight: 3.w,
                      indicatorPadding: EdgeInsets.all(0),
                      labelPadding: EdgeInsets.all(0),
                      isScrollable: false,
                      dividerColor: Colours.bg,
                      indicatorColor: Colours.primary,
                      unselectedLabelColor: Colours.text_999,
                      unselectedLabelStyle:
                          const TextStyle(fontWeight: FontWeight.w500),
                      labelStyle: TextStyle(fontWeight: FontWeight.w500),
                      labelColor: Colours.primary,
                    )),
                Expanded(
                    child: TabBarView(
                        controller: controller.tabController,
                        children: controller.widgetTabBarViews()))
              ],
            ),
          )),
      floatingActionButton:
     GetBuilder<SaleRecordController>(
              id: 'sale_record_add_bill',
              init: controller,
              global: false,
              builder: (_) {
                return   PermissionWidget(
                    permissionCode: controller.showAddBillsName(),
                    child:Container(
                    width: 210.w,
                    height: 110.w,
                    margin: EdgeInsets.only(bottom: 30.w),
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // 设置圆角大小
                      ),
                      onPressed: () => controller.toAddBill(),
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.toAddBillsName(),
                            style: TextStyle(fontSize: 32.sp),
                          ),
                        ],
                      )), // 按钮上显示的图标
                    )));
              }),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
