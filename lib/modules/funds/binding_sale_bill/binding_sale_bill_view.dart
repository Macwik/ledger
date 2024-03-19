import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/order_state_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/picker_date_utils.dart';
import 'package:ledger/util/text_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/custom_easy_refresh.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/lottie_indicator.dart';

import 'binding_sale_bill_controller.dart';

class BindingSaleBillView extends StatelessWidget {
  BindingSaleBillView({super.key});

  final controller = Get.find<BindingSaleBillController>();
  final state = Get.find<BindingSaleBillController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(title:'绑定采购单'),
        endDrawer: Drawer(
          width:  MediaQuery.of(context).size.width * 0.8,
          backgroundColor: Colours.bg,
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
                    GetBuilder<BindingSaleBillController>(
                        id: 'date_range',
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
                                              if (result.compareTo(state.endDate) >
                                                  0) {
                                                Toast.show('起始时间需要小于结束时间');
                                                return;
                                              }
                                              state.startDate = result;
                                              controller.update(['date_range']);
                                            }
                                          });
                                    },
                                    child: Text(
                                      ' ${DateUtil.formatDefaultDate(state.startDate)}',
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
                                                  if (result.compareTo(
                                                      state.startDate) <
                                                      0) {
                                                    Toast.show('结束时间需要大于起始时间');
                                                    return;
                                                  }
                                                  state.endDate = result;
                                                  controller.update(['date_range']);
                                                }
                                              });
                                        },
                                        child: Text(
                                          ' ${DateUtil.formatDefaultDate(state.endDate)}',
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
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    GetBuilder<BindingSaleBillController>(
                      id: 'employee_button',
                      builder: (controller) => state.employeeList?.isEmpty ?? true
                          ? EmptyLayout(hintText: '什么都没有')
                          : Wrap(
                          spacing: 12.0, // 设置标签之间的水平间距
                          runSpacing: 12.0, // 设置标签之间的垂直间距
                          children: [
                            InkWell(
                                onTap: () {
                                  state.selectEmployeeIdList = null;
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
                                      color:
                                      state.selectEmployeeIdList == null
                                          ? Colors.white
                                          : Colours.text_333,
                                    ),
                                  ),
                                  backgroundColor:
                                  state.selectEmployeeIdList == null
                                      ? Colours.primary
                                      : Colors.white,
                                )),
                            ...List.generate(
                              state.itemCount!, // itemCount 是标签的数量
                                  (index) {
                                var employee = state.employeeList![index];
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
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    GetBuilder<BindingSaleBillController>(
                      id: 'sale_order_status',
                      builder: (controller) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.checkOrderStatus(null)
                                  ? Colours.primary
                                  : Colors.white,
                              foregroundColor: controller.checkOrderStatus(null)
                                  ? Colors.white
                                  : Colors.black,
                              side: BorderSide(
                                color: Colours.primary, // 添加边框颜色，此处为灰色
                                width: 1.0, // 设置边框宽度
                              ),
                            ),
                            onPressed: () {
                              state.orderStatus = null;
                              controller.update(['sale_order_status']);
                            },
                            child: Text('全部'),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              state.orderStatus = 1;
                              controller.update(['sale_order_status']);
                            },
                            child: Text('已结清'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.checkOrderStatus(1)
                                  ? Colours.primary
                                  : Colors.white,
                              foregroundColor: controller.checkOrderStatus(1)
                                  ? Colors.white
                                  : Colors.black,
                              side: BorderSide(
                                color: Colours.primary, // 添加边框颜色，此处为灰色
                                width: 1.0, // 设置边框宽度
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              state.orderStatus = 0;
                              controller.update(['sale_order_status']);
                            },
                            child: Text('未结清'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.checkOrderStatus(0)
                                  ? Colours.primary
                                  : Colors.white,
                              foregroundColor: controller.checkOrderStatus(0)
                                  ? Colors.white
                                  : Colors.black,
                              side: BorderSide(
                                color: Colours.primary, // 添加边框颜色，此处为灰色
                                width: 1.0, // 设置边框宽度
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 100.w,
                  right: 20.w,
                  left: 20.w,
                  child: GetBuilder<BindingSaleBillController>(
                      id: 'screen_btn',
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
        body: Column(
          children: [
            Container(
                height: 100.w,
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                margin: EdgeInsets.only(bottom: 10.w),
                child: SearchBar(
                    leading: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: '请输入货物名称')),
            Expanded(
              child: GetBuilder<BindingSaleBillController>(
                  id: 'order_detail',
                  builder: (_) {
                    return CustomEasyRefresh(
                      controller: state.refreshController,
                      onLoad: controller.onLoad,
                      onRefresh: controller.onRefresh,
                      emptyWidget: state.items == null
                          ? LottieIndicator()
                          : state.items!.isEmpty
                              ? EmptyLayout(hintText: '什么都没有'.tr)
                              : null,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var salePurchaseOrderDTO = state.items![index];
                          return Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only( right: 20,top: 24.w,bottom: 24.w),
                                    child: Flex(
                                        direction: Axis.horizontal,
                                        children: [
                                          Container(
                                            color: Colors.white,
                                            child:  Radio(
                                              value: state.orderDTO?.id,
                                              groupValue: salePurchaseOrderDTO.id,
                                              onChanged: (value) => controller
                                                  .selectOrder(salePurchaseOrderDTO),
                                            ),
                                          ),
                                          Expanded(child:Column(
                                            children: [
                                              Flex(
                                                direction: Axis.horizontal,
                                        children: [
                                          ///不支持绑定采购退货
                                          // Visibility(
                                          //     visible: (salePurchaseOrderDTO
                                          //         .orderType ==
                                          //         OrderType.SALE_RETURN
                                          //             .value) ||
                                          //         (salePurchaseOrderDTO
                                          //             .orderType ==
                                          //             OrderType
                                          //                 .PURCHASE_RETURN
                                          //                 .value),
                                          //     child: Container(
                                          //       margin: EdgeInsets.symmetric(
                                          //           horizontal: 8.w),
                                          //       padding: EdgeInsets.symmetric(
                                          //           horizontal: 8.w,
                                          //           vertical: 4.w),
                                          //       decoration: (BoxDecoration(
                                          //           borderRadius:
                                          //           BorderRadius.circular(
                                          //               (36)),
                                          //           border: Border.all(
                                          //               color: Colors.orange,
                                          //               width: 3.w),
                                          //           color: Colors.white)),
                                          //       child: Text(
                                          //         '退',
                                          //         style: TextStyle(
                                          //           fontSize: 28.sp,
                                          //           color: Colors.orange,
                                          //         ),
                                          //       ),
                                          //     )),
                                          Expanded(
                                              child:
                                                  Text(
                                                      TextUtil.listToStr(
                                                          salePurchaseOrderDTO
                                                              .productNameList),
                                                      style: TextStyle(
                                                        color: Colours.text_333,
                                                        fontSize: 28.sp,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                      ))
                                              ),
                                                  Expanded(child:   Text(
                                                      textAlign:TextAlign.right,
                                                      controller.getOrderStatusDesc(salePurchaseOrderDTO.orderStatus),
                                                      style: TextStyle(
                                                        color:OrderStateType.DEBT_ACCOUNT.value == salePurchaseOrderDTO.orderStatus ?  Colors.orange:Colours.text_999,
                                                        fontSize: 28.sp,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ))),
                                                ],
                                              ),
                                              SizedBox(height: 10.w,),
                                              Flex(
                                                direction: Axis.horizontal,
                                                children: [
                                                  Expanded(child:  Text(
                                                      DateUtil.formatDefaultDate2(
                                                          salePurchaseOrderDTO
                                                              .orderDate),
                                                      style: TextStyle(
                                                        color: Colours.text_999,
                                                        fontSize: 26.sp,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                      )) ),
                                                  Expanded(child:   Text(
                                                      textAlign:TextAlign.right,
                                                      DecimalUtil.formatAmount(salePurchaseOrderDTO.totalAmount),
                                                      style: TextStyle(
                                                        color: Colours.primary,
                                                        fontSize: 30.sp,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ))),
                                                ],
                                              ),
                                              SizedBox(height: 10.w,),
                                              Flex(
                                                direction: Axis.horizontal,
                                                children: [
                                                  Expanded(child: Text(
                                                      salePurchaseOrderDTO
                                                          .creatorName ??
                                                          '',
                                                      style: TextStyle(
                                                        color: Colours.text_999,
                                                        fontSize: 28.sp,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      )) ),
                                                  Expanded(child: Text(
                                                      textAlign:TextAlign.right,
                                                      salePurchaseOrderDTO
                                                          .batchNo ??
                                                          '',
                                                      style: TextStyle(
                                                        color: Colours.text_999,
                                                        fontSize: 26.sp,
                                                        fontWeight:
                                                        FontWeight.w300,
                                                      ))),
                                                ],
                                              ),
                                            ],
                                          ))
                                        ]),
                                  )
                                ],
                              );
                        },
                        separatorBuilder: (context, index) => Container(
                          height: 2.w,
                          color: Colours.divider,
                          width: double.infinity,
                        ),
                        itemCount: state.items?.length ?? 0,
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
