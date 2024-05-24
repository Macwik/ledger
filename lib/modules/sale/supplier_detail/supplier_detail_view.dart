import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/util/picker_date_utils.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'supplier_detail_controller.dart';

class SupplierDetailView extends StatelessWidget {
  SupplierDetailView({super.key});

  final controller = Get.find<SupplierDetailController>();
  final state = Get.find<SupplierDetailController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
        backPressed:() => Get.back(result: ProcessStatus.OK),
        title:state.customType == CustomType.CUSTOM.value
              ?'客户详情'
              :'供应商详情',
      ),
      endDrawer: Drawer(
        width: ScreenUtil().screenWidth * 0.8,
        child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 100.w, left: 20.w, right: 10.w),
            child: Stack(children: [
              Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        '筛选',
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.close_sharp,
                            size: 50.w,
                          )),
                      SizedBox(
                        width: 20.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                  GetBuilder<SupplierDetailController>(
                      id: 'date_range',
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
                                    backgroundColor: WidgetStateProperty.all(
                                        Colors.white), // 背景色
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
                    '账单类型',
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.w),
                  GetBuilder<SupplierDetailController>(
                      id: 'supplier_detail_order_type',
                      builder: (controller) => Wrap(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    state.orderType = null;
                                    controller
                                        .update(['supplier_detail_order_type']);
                                  },
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
                                  child: Text('全部')),
                              SizedBox(
                                width: 10.w,
                              ),
                              TextButton(
                                  onPressed: () {
                                    state.customDTO?.customType == CustomType.CUSTOM.value
                                    ?state.orderType = 1
                                    :state.orderType = 0;
                                    controller.update(['supplier_detail_order_type']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: state.customDTO?.customType == CustomType.CUSTOM.value
                                        ? controller.checkOrderStatus(1)
                                            ? Colours.primary
                                            : Colors.white
                                        : controller.checkOrderStatus(0)
                                            ? Colours.primary
                                            : Colors.white,
                                    foregroundColor: state.customDTO?.customType == CustomType.CUSTOM.value
                                      ?controller.checkOrderStatus(1)
                                            ? Colors.white
                                            : Colours.text_333
                                      :controller.checkOrderStatus(0)
                                          ? Colors.white
                                          : Colours.text_333,
                                    side: BorderSide(
                                      color: Colours.primary, // 添加边框颜色，此处为灰色
                                      width: 1.0, // 设置边框宽度
                                    ),
                                  ),
                                  child: Text( state.customDTO?.customType == CustomType.CUSTOM.value
                                      ?'销售单':'采购单')),
                              SizedBox(
                                width: 10.w,
                              ),
                              TextButton(
                                  onPressed: () {
                                    state.orderType = 4;
                                    controller
                                        .update(['supplier_detail_order_type']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.checkOrderStatus(4)
                                            ? Colours.primary
                                            : Colors.white,
                                    foregroundColor:
                                        controller.checkOrderStatus(4)
                                            ? Colors.white
                                            : Colours.text_333,
                                    side: BorderSide(
                                      color: Colours.primary, // 添加边框颜色，此处为灰色
                                      width: 1.0, // 设置边框宽度
                                    ),
                                  ),
                                  child: Text('还款单')),
                              SizedBox(
                                width: 10.w,
                              ),
                              TextButton(
                                  onPressed: () {
                                    state.orderType = 5;
                                    controller
                                        .update(['supplier_detail_order_type']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.checkOrderStatus(5)
                                            ? Colours.primary
                                            : Colors.white,
                                    foregroundColor:
                                        controller.checkOrderStatus(5)
                                            ? Colors.white
                                            : Colours.text_333,
                                    side: BorderSide(
                                      color: Colours.primary, // 添加边框颜色，此处为灰色
                                      width: 1.0, // 设置边框宽度
                                    ),
                                  ),
                                  child: Text('欠款单')),
                              SizedBox(
                                width: 10.w,
                              ),
                              TextButton(
                                  onPressed: () {
                                    state.customDTO?.customType == CustomType.CUSTOM.value
                                        ?state.orderType = 2:state.orderType = 3;
                                    controller
                                        .update(['supplier_detail_order_type']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:state.customDTO?.customType == CustomType.CUSTOM.value
                                        ? controller.checkOrderStatus(2)
                                            ? Colours.primary
                                            : Colors.white
                                        : controller.checkOrderStatus(3)
                                            ? Colours.primary
                                            : Colors.white,
                                    foregroundColor:state.customDTO?.customType == CustomType.CUSTOM.value
                                        ? controller.checkOrderStatus(2)
                                            ? Colors.white
                                            : Colours.text_333
                                        : controller.checkOrderStatus(3)
                                            ? Colors.white
                                            : Colours.text_333,
                                    side: BorderSide(
                                      color: Colours.primary, // 添加边框颜色，此处为灰色
                                      width: 1.0, // 设置边框宽度
                                    ),
                                  ),
                                  child: Text( state.customDTO?.customType == CustomType.CUSTOM.value
                                      ?'销售退货单':'采购退货单')),
                              SizedBox(
                                width: 10.w,
                              ),
                              TextButton(
                                  onPressed: () {
                                    state.customDTO?.customType == CustomType.CUSTOM.value
                                        ?state.orderType = OrderType.REFUND.value
                                        :state.orderType = OrderType.ADD_STOCK.value;
                                    controller.update(['supplier_detail_order_type']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:state.customDTO?.customType == CustomType.CUSTOM.value
                                        ? controller.checkOrderStatus(OrderType.REFUND.value)
                                        ? Colours.primary
                                        : Colors.white
                                        : controller.checkOrderStatus(OrderType.ADD_STOCK.value)
                                        ? Colours.primary
                                        : Colors.white,
                                    foregroundColor:state.customDTO?.customType == CustomType.CUSTOM.value
                                        ? controller.checkOrderStatus(OrderType.REFUND.value)
                                        ? Colors.white
                                        : Colours.text_333
                                        : controller.checkOrderStatus(OrderType.ADD_STOCK.value)
                                        ? Colors.white
                                        : Colours.text_333,
                                    side: BorderSide(
                                      color: Colours.primary, // 添加边框颜色，此处为灰色
                                      width: 1.0, // 设置边框宽度
                                    ),
                                  ),
                                  child: Text( state.customDTO?.customType == CustomType.CUSTOM.value
                                      ?'仅退款单':'直接入库单')),
                            ],
                          )),
                  SizedBox(height: 40.w),
                  GetBuilder<SupplierDetailController>(
                      id: 'invalid_visible',
                      builder: (_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '已作废单据',
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  state.invalid == null ? '显示' : '不显示',
                                  style: TextStyle(color: Colours.text_999),
                                ),
                                Switch(
                                    trackOutlineColor:
                                    WidgetStateProperty.resolveWith(
                                            (states) {
                                          if (states.contains(WidgetState.selected)) {
                                            return Colours.primary; // 设置轨道边框颜色
                                          }
                                          return Colors.grey; // 默认的轨道边框颜色
                                        }),
                                    inactiveThumbColor: Colors.grey[300],
                                    value: state.invalid == null,
                                    onChanged: (value) {
                                      state.invalid = value ? null : 0;
                                      controller.update(['invalid_visible']);
                                    }),
                              ],
                            )
                          ],
                        );
                      }),
                ],
              ),
              Positioned(
                bottom: 100.w,
                right: 20.w,
                left: 20.w,
                child: GetBuilder<SupplierDetailController>(
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
                              elevation: 2,
                              margin: EdgeInsets.only(top: 80.w),
                              size: Size(double.infinity, 90.w),
                              onPressed: () => controller.confirmCondition(),
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
              padding: EdgeInsets.only(top: 20, right: 20, left: 40.w, bottom: 32.w),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  GetBuilder<SupplierDetailController>(
                      id: 'supplier_name',
                      builder: (_) {
                        return Row(
                          children: [
                            Text(state.customDTO?.customName ?? '-',
                                style: TextStyle(
                                  color: state.customDTO?.invalid == 1
                                      ? Colours.text_ccc
                                      : Colours.text_333,
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(
                              width: 200.w,
                            ),
                            Visibility(
                              visible: state.customDTO?.invalid == 1,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 2.w,
                                    bottom: 2.w,
                                    left: 4.w,
                                    right: 4.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text('已停用',
                                    style: TextStyle(
                                      color: Colors.red[600],
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            )
                          ],
                        );
                      }),
                  SizedBox(height: 32.w),
                  GetBuilder<SupplierDetailController>(
                      id: 'supplier_detail_sum',
                      builder: (_) {
                        return InkWell(
                            onTap: () {
                              controller.customDetail();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('欠款',
                                    style: TextStyle(
                                      color: Colours.text_999,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Text('￥${state.customDTO?.creditAmount ?? ''}',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w700,
                                    )),
                                const Spacer(),
                                Text(
                                    state.customDTO?.customType == 0
                                        ? '客户资料'
                                        : '供应商资料',
                                    style: TextStyle(
                                      color: Colours.text_999,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(width: 20.w),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 25.w,
                                  color: Colours.text_999,
                                ),
                              ],
                            ));
                      }),
                ],
              )),
          SizedBox(height: 16.w),
          PermissionWidget(
              permissionCode:controller.state.customType == CustomType.CUSTOM.value
                  ? PermissionCode.supplier_detail_check_bill_permission
                  :PermissionCode.supplier_supplier_detail_check_bill_permission,
              child: Container(
            padding: EdgeInsets.only(left: 20, top: 20.w,bottom: 20.w),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  color: Colours.primary,
                  height: 38.w,
                  width: 8.w,
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 6),
                  child: Text('对账单',
                    style: TextStyle(
                        color: Colours.text_666,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LoadAssetImage(
                          'screen',
                          format: ImageFormat.png,
                          color: Colours.text_999,
                          height: 40.w,
                          width: 40.w,
                        ),// 导入的图像
                        SizedBox(width: 8.w), // 图像和文字之间的间距
                        Text('筛选',
                          style: TextStyle(fontSize: 30.sp,
                              color: Colours.text_666),),
                        SizedBox(width: 24.w,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
          Expanded(
              child: GetBuilder<SupplierDetailController>(
                  id: 'custom_record',
                  init: controller,
                  builder: (_) {
                    return PermissionWidget(
                        permissionCode:controller.state.customType == CustomType.CUSTOM.value
                            ? PermissionCode.supplier_detail_check_bill_permission
                             :PermissionCode.supplier_supplier_detail_check_bill_permission,
                        child: CustomEasyRefresh(
                            controller: state.refreshController,
                            onLoad: controller.onLoad,
                            onRefresh: controller.onRefresh,
                            emptyWidget: controller.state.list == null
                                ? LottieIndicator()
                                : state.list?.isEmpty ?? true
                                    ? EmptyLayout(hintText: '什么都没有'.tr)
                                    : null,
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                var statisticsCustomOrderDTO =
                                    state.list![index];
                                return Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: InkWell(
                                      onTap: () => controller.toBillDetail(
                                          statisticsCustomOrderDTO),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(child:
                                              Text(
                                                  DateUtil.formatDefaultDate2(
                                                      statisticsCustomOrderDTO
                                                          .gmtCreate),
                                                  style: TextStyle(
                                                    color: Colours.text_ccc,
                                                    fontSize: 26.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ))),
                                              Visibility(
                                                  visible: statisticsCustomOrderDTO.invalid != 0,
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets.only(
                                                        top: 2.w,
                                                        bottom: 2.w,
                                                        left: 4.w,
                                                        right: 4.w),
                                                    decoration:
                                                    BoxDecoration(
                                                      border: Border.all(
                                                        color: Colours
                                                            .text_ccc,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.0),
                                                    ),
                                                    child: Text('已作废',
                                                        style: TextStyle(
                                                          color: Colours
                                                              .text_666,
                                                          fontSize: 26.sp,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                        )),
                                                  )),
                                              Expanded(child:
                                              Text(
                                                  controller.getOrderTypeDesc(
                                                      statisticsCustomOrderDTO.orderType!),
                                                  textAlign:TextAlign.right,
                                                  style: TextStyle(
                                                    color: statisticsCustomOrderDTO.invalid != 0
                                                        ? Colours.text_ccc
                                                        : Colors.orange,
                                                    fontSize: 26.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16.w,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  Text(controller.totalName(statisticsCustomOrderDTO),
                                                      style: TextStyle(
                                                        color: Colours.text_ccc,
                                                        fontSize: 26.sp,
                                                        fontWeight: FontWeight.w400,
                                                      )),
                                                  Expanded(
                                                    child: Text(
                                                      controller.totalAmount(statisticsCustomOrderDTO),
                                                        style: TextStyle(
                                                          color:statisticsCustomOrderDTO.invalid == 0
                                                          ?Colours.text_333
                                                          :Colours.text_ccc,
                                                          fontSize: 28.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                  ),
                                                ],
                                              )),
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  Text('业务员：',
                                                      style: TextStyle(
                                                        color: Colours.text_ccc,
                                                        fontSize: 26.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      )),
                                                  Expanded(
                                                    child: Text(
                                                        statisticsCustomOrderDTO
                                                                .creatorName ??
                                                            '',
                                                        style: TextStyle(
                                                          color:statisticsCustomOrderDTO.invalid == 0
                                                              ?Colours.text_666
                                                              :Colours.text_ccc,
                                                          fontSize: 26.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16.w,
                                          ),
                                              ///暂时不展示
                                              // Expanded(
                                              //     child: Row(
                                              //   children: [
                                              //     Text(controller.creditName(statisticsCustomOrderDTO),
                                              //         style: TextStyle(
                                              //           color: Colours.text_ccc,
                                              //           fontSize: 26.sp,
                                              //           fontWeight:
                                              //               FontWeight.w400,
                                              //         )),
                                              //     Expanded(
                                              //       child: Text(
                                              //         controller.creditAmount(statisticsCustomOrderDTO),
                                              //           style: TextStyle(
                                              //             color:statisticsCustomOrderDTO.invalid == 0
                                              //                 ?Colours.text_666
                                              //                 :Colours.text_ccc,
                                              //             fontSize: 28.sp,
                                              //             fontWeight:
                                              //                 FontWeight.w500,
                                              //           )),
                                              //     )
                                              //   ],
                                              // )),
                                              Offstage(
                                                  offstage:statisticsCustomOrderDTO.productNameList?.isEmpty??false,
                                                      child: Row(
                                                        children: [
                                                          Text('货  物：',
                                                              style: TextStyle(
                                                                color: Colours.text_ccc,
                                                                fontSize: 26.sp,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                              )),
                                                          Expanded(child:
                                                          Text(statisticsCustomOrderDTO.productNameList?.isEmpty??true
                                                              ? '-' :TextUtil.listToStr(statisticsCustomOrderDTO.productNameList),
                                                              style: TextStyle(
                                                                color: Colours.text_666,
                                                                fontSize: 26.sp,
                                                                fontWeight: FontWeight.w500,
                                                              ))),
                                                        ],
                                                      )
                                                  )
                                        ],
                                      ),
                                    ));
                              },
                              separatorBuilder: (context, index) => Container(
                                height: 2.w,
                                color: Colours.divider,
                                width: double.infinity,
                              ),
                              itemCount: state.list?.length ?? 0,
                            )));
                  })),
          Container(
            height: 100.w,
          )
        ],
      ),
      //底部按钮
      floatingActionButton: GetBuilder<SupplierDetailController>(
          id: 'supplier_btn',
          builder: (_) {
            return PermissionWidget(
                permissionCode: state.customType == CustomType.CUSTOM.value
                ?PermissionCode.supplier_detail_repayment_order_permission
                :PermissionCode.supplier_repayment_order_permission,
                child:Visibility(
                visible: state.customDTO?.invalid == 0,
                child:Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(1, 1),
                      blurRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colours.primary,
                ),
                height: 100.w,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                            child:  TextButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colours.primary, // 设置背景色
                                    side: BorderSide(
                                        color: Colours.primary,
                                        width: 0), // 设置边框样式
                                  ),
                                  onPressed: () => controller.toRepayment(),
                                  child: Text('还  款',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                  ],
                ))));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
