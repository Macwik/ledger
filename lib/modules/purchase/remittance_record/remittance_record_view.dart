import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/util/picker_date_utils.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'remittance_record_controller.dart';

class RemittanceRecordView extends StatelessWidget {
  RemittanceRecordView({super.key});

  final controller = Get.find<RemittanceRecordController>();
  final state = Get.find<RemittanceRecordController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          title:'汇款记录'.tr,
        ),
        endDrawer: Drawer(
          width: ScreenUtil().screenWidth * 0.8,
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
                    GetBuilder<RemittanceRecordController>(
                        id: 'date_range',
                        builder: (_) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12, horizontal: 10)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white), // 背景色
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
                                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12, horizontal: 10)),
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
                      '汇款账户',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    GetBuilder<RemittanceRecordController>(
                      id: 'payment_method_button',
                      builder: (controller) => Wrap(
                        spacing: 20.0, // 设置标签之间的水平间距
                        runSpacing: 2.0,
                        children: [
                          InkWell(
                              onTap: () {
                                state.selectPaymentMethodIdList = null;
                                controller.update(['payment_method_button']);
                              },
                              child: Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(35),
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
                                        state.selectPaymentMethodIdList == null
                                            ? Colors.white
                                            : Colours.text_333,
                                  ),
                                ),
                                backgroundColor:
                                    state.selectPaymentMethodIdList == null
                                        ? Colours.primary
                                        : Colors.white,
                              )),
                          ...List.generate(
                            state.itemCount, // itemCount 是标签的数量
                            (index) {
                              var paymentMethod =
                                  state.paymentMethodList![index];
                              return Builder(
                                builder: (BuildContext context) {
                                  return InkWell(
                                    onTap: () => controller
                                        .selectEmployee(paymentMethod.id),
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
                                                  paymentMethod.id)
                                              ? Colours.primary
                                              : Colors.white,
                                      label: Text(
                                        paymentMethod.name ?? '',
                                        style: TextStyle(
                                          fontSize: 30.sp,
                                          color: controller.isEmployeeSelect(
                                                  paymentMethod.id)
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.w,
                    ),
                    InkWell(
                      onTap: () => controller.selectProduct(),
                      child: Row(
                        children: [
                          Text(
                            '货物',
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          GetBuilder<RemittanceRecordController>(
                              id: 'remittance_record_product',
                              builder: (_) {
                                return Text(
                                    state.productDTO?.productName ?? '请选择',
                                    style: TextStyle(
                                      color:
                                          state.productDTO?.productName != null
                                              ? Colours.text_333
                                              : Colours.hint,
                                    ));
                              }),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colours.text_ccc,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.w,
                    ),
                    GetBuilder<RemittanceRecordController>(
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
                                            if (states
                                                .contains(MaterialState.selected)) {
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
                  child: GetBuilder<RemittanceRecordController>(
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
            Row(
              children: [
                Expanded(
                  child: Container(
                      height: 100.w,
                      padding: EdgeInsets.only(top:10.w,left: 10.w, right: 10.w),
                      child: SearchBar(
                          onChanged: (value){
                            controller.searchRemittanceRecord(value);
                          },
                          leading: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 40.w,
                          ),
                          shadowColor:MaterialStatePropertyAll<Color>(Colors.black26),
                          hintStyle: MaterialStatePropertyAll<TextStyle>(
                              TextStyle(fontSize: 34.sp,
                                color: Colors.black26
                              )),
                          hintText: '请输入汇款人姓名')),
                ),
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
            GetBuilder<RemittanceRecordController>(
                id: 'remittance_record_total_amount',
                builder: (_){
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 16.w,horizontal: 40.w),
                    child:  Row(
                      children: [
                        Text(
                          '所选日期合计：',
                          style: TextStyle(
                            color: Colours.text_999,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 16.w,),
                        Text(
                          DecimalUtil.formatAmount(state.totalRemittanceAmount),
                          style: TextStyle(
                            color: Colours.primary,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            Expanded(
              child: GetBuilder<RemittanceRecordController>(
                  id: 'remittance_record',
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
                          var remittanceDTO = state.items![index];
                          return InkWell(
                            onTap: () => controller.toRemittanceDetail(remittanceDTO),
                            child: Container(
                              width: double.infinity,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.w,
                                  vertical: 20.w),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(child: Text(remittanceDTO.receiver ??'',
                                          style: TextStyle(
                                            color: remittanceDTO.invalid == 0 ?  Colours.text_333 : Colours.text_999,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w500,
                                          ))),
                                    Visibility(
                                      visible: remittanceDTO.invalid == 0 ? false :true,
                                      child:Container(
                                        padding: EdgeInsets.only(top:2.w,bottom:2.w,left: 4.w,right: 4.w),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colours.text_ccc,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Text(
                                            '已作废',
                                            style: TextStyle(
                                              color: Colours
                                                  .text_666,
                                              fontSize: 26.sp,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ) ),
                                      Expanded(child:
                                      Text('￥${remittanceDTO.amount??''}',
                                          textAlign:TextAlign.right,
                                          style: TextStyle(
                                            color: remittanceDTO.invalid == 0 ?  Colours.text_333 : Colours.text_999,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w500,
                                          )),)

                                    ],
                                  ),
                                  SizedBox(height: 16.w,),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(child:  Text(
                                          DateUtil.formatDefaultDate2(
                                              remittanceDTO.remittanceDate!),
                                          style: TextStyle(
                                            color: Colours.text_ccc,
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w500,
                                          )),),
                                      Expanded(child:  Text(TextUtil.listToStr(
                                          remittanceDTO.productNameList),
                                          textAlign:TextAlign.right,
                                          style: TextStyle(
                                            color: Colours.text_999,
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w500,
                                          )),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
        ),
        floatingActionButton: PermissionWidget(
            permissionCode: PermissionCode.purchase_remittance_order_permission,
            child:Container(
            width: 210.w,
            height:110.w,
            margin: EdgeInsets.only(bottom:30.w),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // 设置圆角大小
              ),
          onPressed:()=> Get.offNamed(RouteConfig.remittance),
          child: Container(
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add,
                    size: 30.w,),
                  Text('汇款',
                    style: TextStyle(
                        fontSize: 32.sp
                    ),),
                ],)
          ), // 按钮上显示的图标
        ))),
    floatingActionButtonLocation: FloatingActionButtonLocation.endContained ,);
  }


}
