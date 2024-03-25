import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/util/picker_date_utils.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'repayment_record_controller.dart';

class RepaymentRecordView extends StatelessWidget {
  RepaymentRecordView({super.key});

  final controller = Get.find<RepaymentRecordController>();
  final state = Get.find<RepaymentRecordController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return DefaultTabController(
      length: 2,
      initialIndex: state.index,
      child: Scaffold(
          appBar: TitleBar(
              title: '还款列表',
            actionName:'录入欠款' ,
            actionPressed: ()=> Get.toNamed(RouteConfig.addDebt),
             ),
          endDrawer: Drawer(
            width:  MediaQuery.of(context).size.width * 0.8,
            child: Container(
                color: Colours.select_bg,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 100.w, left: 20.w, right: 20.w),
                child: Stack(children: [
                  Column(
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
                      GetBuilder<RepaymentRecordController>(
                          id: 'date_range',
                          builder: (_) {
                            return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
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
                                            if (result
                                                    .compareTo(state.endDate) >
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
                                          fontSize: 30.sp,
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
                                      fontSize: 30.sp,
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
                                                    vertical: 12,
                                                    horizontal: 10)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white), // 背景色
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        35.0), // 圆角
                                                side: BorderSide(
                                                  width: 1.0, // 边框宽度
                                                  color:
                                                      Colours.primary, // 边框颜色
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
                                                controller
                                                    .update(['date_range']);
                                              }
                                            });
                                          },
                                          child: Text(
                                            ' ${DateUtil.formatDefaultDate(state.endDate)}',
                                            style: TextStyle(
                                              color: Colours.button_text,
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ))),
                                ]);
                          }),
                      SizedBox(
                        height: 40.w,
                      ),
                      GetBuilder<RepaymentRecordController>(
                          id: 'switch',
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
                                    state.invalid == null ? '显示' : '不显示',
                                    style: TextStyle(color: Colours.text_999),
                                  ),
                                  Switch(
                                      trackOutlineColor:
                                      MaterialStateProperty.resolveWith(
                                              (states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return Colours.primary; // 设置轨道边框颜色
                                            }
                                            return Colors.grey; // 默认的轨道边框颜色
                                          }),
                                      inactiveThumbColor: Colors.grey[300],
                                      value: state.invalid == null,
                                      onChanged: (value) {
                                        state.invalid = value ? null : 0;
                                        controller.update(['switch']);
                                      }),
                                ],)
                              ],
                            );
                          })
                    ],
                  ),
                  Positioned(
                    bottom: 100.w,
                    right: 20.w,
                    left: 20.w,
                    child: GetBuilder<RepaymentRecordController>(
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
                                  onPressed: () =>
                                      controller.confirmCondition(),
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
                  color: Colors.white,
                  height: 90.w, // 调整TabBar高度
                  child: TabBar(
                    onTap:  (index) => controller.switchIndex(index),
                    tabs: [
                      Tab(text:'客户'),
                      Tab(text: '供应商',
                      ),
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
                  )),
              Expanded(
                  child: TabBarView(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Flex(direction: Axis.horizontal,
                          children: [
                            Expanded(child: Container(
                                height: 100.w,
                                padding: EdgeInsets.only(top:10.w,left: 10.w, right: 10.w),
                                child: SearchBar(
                                  leading: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 40.w,
                                  ),
                                  shadowColor:MaterialStatePropertyAll<Color>(Colors.black26),
                                  hintStyle: MaterialStatePropertyAll<TextStyle>(
                                      TextStyle(fontSize: 34.sp,  color: Colors.black26)),
                                  onChanged: (value) {
                                    controller.searchRepaymentRecord(value);
                                  },
                                  hintText: '请输入客户名称',
                                )) ),
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
                          ],),
                          //搜索框
                          Expanded(
                              child: GetBuilder<RepaymentRecordController>(
                                  id: 'custom_detail',
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
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          var repaymentOrderDTO = state.items![index];
                                          return InkWell(
                                              onTap: () => controller.toRepaymentDetail(
                                                  repaymentOrderDTO.id),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10.w,
                                                        left: 30.w,
                                                        top: 10.w),
                                                    alignment: Alignment.centerLeft,
                                                    color: Colors.white12,
                                                    child: Text(
                                                        DateUtil.formatDefaultDate2(
                                                            repaymentOrderDTO
                                                                .repaymentDate),
                                                        style: TextStyle(
                                                          color: Colours.text_ccc,
                                                          fontSize: 24.sp,
                                                          fontWeight: FontWeight.w500,
                                                        )),
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 40.w,
                                                        vertical: 20.w),
                                                    child: Column(
                                                      children: [
                                                        Flex(
                                                          direction: Axis.horizontal,
                                                          children: [
                                                            Expanded(
                                                                child: Text(
                                                                  repaymentOrderDTO
                                                                      .customName ??
                                                                      '',
                                                                  style: TextStyle(
                                                                    color: repaymentOrderDTO
                                                                        .invalid ==
                                                                        0
                                                                        ? Colours.text_333
                                                                        : Colours.text_ccc,
                                                                    fontSize: 30.sp,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                  ),
                                                                )),
                                                            Visibility(
                                                                visible: repaymentOrderDTO
                                                                    .invalid ==
                                                                    0
                                                                    ? false
                                                                    : true,
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
                                                                child:Row(
                                                                  children: [
                                                                    Text(
                                                                      '本次还款：',
                                                                      style: TextStyle(
                                                                        color: Colours
                                                                            .text_ccc,
                                                                        fontSize: 26.sp,
                                                                        fontWeight:
                                                                        FontWeight.w400,
                                                                      ),
                                                                    ) ,
                                                                    Expanded(child:  Text(
                                                                      textAlign:TextAlign.left,
                                                                      DecimalUtil.formatAmount(repaymentOrderDTO
                                                                          .totalAmount),
                                                                      style: TextStyle(
                                                                        color: repaymentOrderDTO
                                                                            .invalid ==
                                                                            0
                                                                            ? Colours
                                                                            .text_333
                                                                            : Colours
                                                                            .text_ccc,
                                                                        fontSize: 28.sp,
                                                                        fontWeight:
                                                                        FontWeight.w500,
                                                                      ),
                                                                    ))

                                                                  ],
                                                                ) ),
                                                            Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      '业务员：',
                                                                      style: TextStyle(
                                                                        color: Colours
                                                                            .text_ccc,
                                                                        fontSize: 26.sp,
                                                                        fontWeight:
                                                                        FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      repaymentOrderDTO
                                                                          .creatorName ??
                                                                          '',
                                                                      style: TextStyle(
                                                                        color: repaymentOrderDTO
                                                                            .invalid ==
                                                                            0
                                                                            ? Colours
                                                                            .text_666
                                                                            : Colours
                                                                            .text_ccc,
                                                                        fontSize: 26.sp,
                                                                        fontWeight:
                                                                        FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 16.w,
                                                        ),
                                                        Flex(
                                                          direction: Axis.horizontal,
                                                          children: [
                                                            Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      '其中优惠：',
                                                                      style: TextStyle(
                                                                        color: Colours
                                                                            .text_ccc,
                                                                        fontSize: 26.sp,
                                                                        fontWeight:
                                                                        FontWeight.w400,
                                                                      ),
                                                                    ) ,
                                                                    Text(
                                                                      DecimalUtil.formatAmount( repaymentOrderDTO
                                                                          .discountAmount),
                                                                      style: TextStyle(
                                                                        color: repaymentOrderDTO
                                                                            .invalid ==
                                                                            0
                                                                            ? Colours
                                                                            .text_666
                                                                            : Colours
                                                                            .text_ccc,
                                                                        fontSize: 26.sp,
                                                                        fontWeight:
                                                                        FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                            Expanded(child: Text(
                                                                DateUtil.formatDefaultDateTimeMinute(
                                                                    repaymentOrderDTO
                                                                        .gmtCreate),
                                                                style: TextStyle(
                                                                  color: Colours.text_ccc,
                                                                  fontSize: 28.sp,
                                                                  fontWeight: FontWeight.w400,
                                                                )),)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ));
                                        },
                                        itemCount: state.items?.length ?? 0,
                                      ),
                                    );
                                  })),
                        ],
                      ),
                      Positioned(
                          bottom: 20.w,
                          right: 20.w,
                          child: PermissionWidget(
                              permissionCode: PermissionCode.supplier_detail_repayment_order_permission,
                              child:Container(
                                  width: 210.w,
                                  height:110.w,
                                  margin: EdgeInsets.only(bottom:30.w),
                                  child: FloatingActionButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30), // 设置圆角大小
                                    ),
                                    onPressed: () => Get.toNamed(RouteConfig.repaymentBill,arguments: {'customType':CustomType.CUSTOM.value}),
                                    child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              size: 30.w,
                                            ),
                                            Text(
                                              '还款',
                                              style: TextStyle(fontSize: 32.sp),
                                            ),
                                          ],
                                        )), // 按钮上显示的图标
                                  ))))
                    ],
                  ),
                  //供应商列表
                  Stack(
                    children: [
                      //搜索框
                      Column(
                        children: [
                          Flex(direction: Axis.horizontal,
                          children: [
                            Expanded(child:
                            Container(
                                height: 100.w,
                                padding: EdgeInsets.only(top:10.w,left: 10.w, right: 10.w),
                                child: SearchBar(
                                  leading: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 40.w,
                                  ),
                                  shadowColor:MaterialStatePropertyAll<Color>(Colors.black26),
                                  hintStyle: MaterialStatePropertyAll<TextStyle>(
                                      TextStyle(fontSize: 34.sp,  color: Colors.black26)),
                                  onChanged: (value) {
                                    controller.searchRepaymentRecord(value);
                                  },
                                  hintText: '请输入供应商名称',
                                ))),
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
                          ],),
                          Expanded(
                              child: GetBuilder<RepaymentRecordController>(
                                  id: 'supplier_detail',
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
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          var repaymentOrderDTO = state.items![index];
                                          return InkWell(
                                              onTap: () => controller.toRepaymentDetail(
                                                  repaymentOrderDTO.id),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10.w,
                                                        top: 10.w,
                                                        left: 30.w),
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                        DateUtil.formatDefaultDate2(
                                                            repaymentOrderDTO
                                                                .repaymentDate),
                                                        style: TextStyle(
                                                          color: Colours.text_999,
                                                          fontSize: 24.sp,
                                                          fontWeight: FontWeight.w500,
                                                        )),
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    padding: EdgeInsets.only(
                                                        left: 40.w,
                                                        right: 40.w,
                                                        top: 20.w,
                                                        bottom: 20.w),
                                                    child: Column(
                                                      children: [
                                                        Flex(
                                                          direction: Axis.horizontal,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                repaymentOrderDTO
                                                                    .customName ??
                                                                    '',
                                                                style: TextStyle(
                                                                  color: repaymentOrderDTO
                                                                      .invalid ==
                                                                      0
                                                                      ? Colours
                                                                      .text_333
                                                                      : Colours
                                                                      .text_ccc,
                                                                  fontSize: 30.sp,
                                                                  fontWeight:
                                                                  FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Visibility(
                                                                visible: repaymentOrderDTO
                                                                    .invalid ==
                                                                    0
                                                                    ? false
                                                                    : true,
                                                                child: Container(
                                                                  padding:
                                                                  EdgeInsets.only(
                                                                      top: 2.w,
                                                                      bottom: 2.w,
                                                                      left: 4.w,
                                                                      right: 4.w),
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    border:
                                                                    Border.all(
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
                                                                      style:
                                                                      TextStyle(
                                                                        color: Colours
                                                                            .text_666,
                                                                        fontSize:
                                                                        26.sp,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                      )),
                                                                )),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: 1.w,
                                                          margin: EdgeInsets.only(
                                                              top: 16.w,
                                                              bottom: 16.w),
                                                          width: double.infinity,
                                                          color: Colours.divider,
                                                        ),
                                                        Flex(
                                                          direction: Axis.horizontal,
                                                          children: [
                                                            Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      '本次还款：',
                                                                      style: TextStyle(
                                                                        color: Colours
                                                                            .text_ccc,
                                                                        fontSize: 26.sp,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                      ),
                                                                    ),
                                                                    Expanded(child:  Text(
                                                                      DecimalUtil.formatAmount( repaymentOrderDTO
                                                                          .totalAmount),
                                                                      textAlign:TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: repaymentOrderDTO
                                                                            .invalid ==
                                                                            0
                                                                            ? Colours
                                                                            .text_333
                                                                            : Colours
                                                                            .text_ccc,
                                                                        fontSize: 30.sp,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                      ),
                                                                    ))

                                                                  ],
                                                                )),
                                                            Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      '业务员：',
                                                                      style: TextStyle(
                                                                        color: Colours
                                                                            .text_ccc,
                                                                        fontSize: 26.sp,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      repaymentOrderDTO
                                                                          .creatorName ??
                                                                          '',
                                                                      style: TextStyle(
                                                                        color: repaymentOrderDTO
                                                                            .invalid ==
                                                                            0
                                                                            ? Colours
                                                                            .text_666
                                                                            : Colours
                                                                            .text_ccc,
                                                                        fontSize: 26.sp,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 16.w,
                                                        ),
                                                        Flex(
                                                          direction: Axis.horizontal,
                                                          children: [
                                                            Expanded(
                                                                child:Row(
                                                                  children: [
                                                                    Text(
                                                                      '本次优惠：',
                                                                      style: TextStyle(
                                                                        color: Colours
                                                                            .text_ccc,
                                                                        fontSize: 26.sp,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DecimalUtil.formatAmount( repaymentOrderDTO
                                                                          .discountAmount),
                                                                      textAlign:TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: repaymentOrderDTO
                                                                            .invalid ==
                                                                            0
                                                                            ? Colours
                                                                            .text_666
                                                                            : Colours
                                                                            .text_ccc,
                                                                        fontSize: 26.sp,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                            Expanded(child: Text(
                                                                DateUtil.formatDefaultDateTimeMinute(
                                                                    repaymentOrderDTO
                                                                        .gmtCreate),
                                                                style: TextStyle(
                                                                  color: Colours.text_ccc,
                                                                  fontSize: 28.sp,
                                                                  fontWeight: FontWeight.w400,
                                                                ))),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        },
                                        //separatorBuilder是分隔符组件，可以直接拿来用
                                        itemCount: state.items?.length ?? 0,
                                        //state.customList?.length ?? 0,
                                      ),
                                    );
                                  })),
                        ],
                      ),
                      Positioned(
                          bottom: 20.w,
                          right: 20.w,
                          child: PermissionWidget(
                              permissionCode: PermissionCode.supplier_detail_repayment_order_permission,
                              child:Container(
                                  width: 210.w,
                                  height:110.w,
                                  margin: EdgeInsets.only(bottom:30.w),
                                  child: FloatingActionButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30), // 设置圆角大小
                                    ),
                                    onPressed: () => Get.toNamed(RouteConfig.repaymentBill,arguments: {'customType':CustomType.SUPPLIER.value}),
                                    child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              size: 30.w,
                                            ),
                                            Text(
                                              '还款',
                                              style: TextStyle(fontSize: 32.sp),
                                            ),
                                          ],
                                        )), // 按钮上显示的图标
                                  ))))
                    ],
                  ),
                ],
              ))
            ],
          )
      ),
    );
  }
}
