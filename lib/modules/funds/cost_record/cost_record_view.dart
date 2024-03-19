import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/cost_order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/picker_date_utils.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'cost_record_controller.dart';

class CostRecordView extends StatelessWidget {
  CostRecordView({super.key});

  final controller = Get.find<CostRecordController>();
  final state = Get.find<CostRecordController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          title:'费用收入记录',
        ),
        endDrawer: Drawer(
          width:  MediaQuery.of(context).size.width * 0.8,
          child: Container(
              color: Colours.select_bg,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 100.w, left: 20.w, right: 20.w,bottom: 8.w),
              child: Stack(children: [
                SingleChildScrollView(
                  child:Column(
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
                    GetBuilder<CostRecordController>(
                        id: 'date_range',
                        builder: (_) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 24.w, horizontal: 20.w)),
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
                                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 24.w, horizontal: 20.w)),
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
                    GetBuilder<CostRecordController>(
                      id: 'employee_button',
                      builder: (controller) => Wrap(
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
                                      color: state.selectEmployeeIdList == null
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
                                        backgroundColor: controller
                                            .isEmployeeSelect(employee.id)
                                            ? Colours.primary
                                            : Colors.white,
                                        label: Text(
                                          employee.username ?? '',
                                          style: TextStyle(
                                            fontSize: 30.sp,
                                            color: controller.isEmployeeSelect(
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
                      '在哪里支付',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GetBuilder<CostRecordController>(
                      id: 'sale_order_status',
                      builder: (controller) => ButtonBar(
                        overflowDirection:VerticalDirection.down,
                        alignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              controller.selectedProfitType(null)
                                  ? Colours.primary
                                  : Colors.white,
                              foregroundColor:
                              controller.selectedProfitType(null)
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
                          TextButton(
                            onPressed: () {
                              state.orderStatus = 1;
                              controller.update(['sale_order_status']);
                            },
                            child: Text('销售地'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.selectedProfitType(1)
                                  ? Colours.primary
                                  : Colors.white,
                              foregroundColor: controller.selectedProfitType(1)
                                  ? Colors.white
                                  : Colors.black,
                              side: BorderSide(
                                color: Colours.primary, // 添加边框颜色，此处为灰色
                                width: 1.0, // 设置边框宽度
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              state.orderStatus = 0;
                              controller.update(['sale_order_status']);
                            },
                            child: Text('产地'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.selectedProfitType(0)
                                  ? Colours.primary
                                  : Colors.white,
                              foregroundColor: controller.selectedProfitType(0)
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
                    SizedBox(
                      height: 40.w,
                    ),
                    InkWell(
                      onTap: () => controller.selectCostType(),
                      child: Row(
                        children: [
                          Text(
                            '费用类型',
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          GetBuilder<CostRecordController>(
                              id: 'costType',
                              builder: (_) {
                                return Text(
                                    state.costLabel?.labelName ?? '请选择',
                                    style: TextStyle(
                                      color:
                                      state.costLabel?.labelName != null
                                          ? Colours.text_333
                                          : Colours.hint,
                                    )
                                );
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
                    GetBuilder<CostRecordController>(
                        id: 'switch',
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
                        }),
                    SizedBox(
                      height: 40.w,
                    ),
                    GetBuilder<CostRecordController>(
                        id: 'unbinding_visible',
                        builder: (_) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '未绑定货物单据',
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
                                    state.bindProduct == 0 ? '未绑定货物':'全部' ,
                                    style: TextStyle(color: Colours.text_999),
                                  ),
                                  Switch(
                                      trackOutlineColor:
                                      MaterialStateProperty.resolveWith(
                                              (states) {
                                            if (states.contains(MaterialState.selected)) {
                                              return Colours.primary; // 设置轨道边框颜色
                                            }
                                            return Colors.grey; // 默认的轨道边框颜色
                                          }),
                                      inactiveThumbColor: Colors.grey[300],
                                      value: state.bindProduct == 0,
                                      onChanged: (value) {
                                        state.bindProduct = value ? 0 : null;
                                        controller.update(['unbinding_visible']);
                                      }),
                                ],
                              )

                            ],
                          );
                        }),
                  ],
                ) ,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GetBuilder<CostRecordController>(
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
                height: 120.w,
                padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                margin: EdgeInsets.only(bottom: 20.w),
                child: SearchBar(
                    onChanged: (value){
                      controller.searchCostRecord(value);
                    },
                    leading: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: '请输入费用、收入名称')),
            Expanded(
              child: GetBuilder<CostRecordController>(
                  id: 'costRecord',
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
                          //shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var costIncomeOrderDTO = state.items![index];
                            return InkWell(
                                onTap: () {controller.toCostDetail(costIncomeOrderDTO.id);},
                                child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(
                                            left: 40.w, top: 10.w, bottom: 10.w),
                                        color: Colors.white12,
                                        child: Text(
                                          DateUtil.formatDefaultDate2(
                                              costIncomeOrderDTO.orderDate),
                                          style: TextStyle(
                                            color: Colours.text_ccc,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.only(left: 40.w, right: 40.w,top: 20.w,bottom: 20.w),
                                        child: Column(
                                          children: [
                                            Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                Expanded(child:
                                                Text(
                                                costIncomeOrderDTO
                                                .costIncomeName ?? '',
                                                style: TextStyle(
                                                  color: costIncomeOrderDTO.invalid == 0 ?  Colours.text_333 : Colours.text_ccc,
                                                  fontSize: 32.sp,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ))),
                                                Visibility(
                                                  visible: costIncomeOrderDTO.invalid == 0 ? false :true,
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
                                                Expanded(
                                                    child:
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children:[
                                                          Text( costIncomeOrderDTO.orderType ==CostOrderType.COST.value ?  '（费）':'（收）',
                                                              style: TextStyle(
                                                                color: costIncomeOrderDTO.invalid == 0
                                                                    ?  costIncomeOrderDTO.orderType == CostOrderType.COST.value ? Colours.primary :Colors.orange
                                                                    : Colours.text_ccc,
                                                                fontSize: 28.sp,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                              )),
                                                        ])
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 1.w,
                                              margin: EdgeInsets.only(top: 16.w,bottom: 16.w),
                                              width: double.infinity,
                                              color: Colours.divider,
                                            ),
                                            Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '￥${costIncomeOrderDTO.totalAmount??''}',
                                                      style: TextStyle(
                                                        color: costIncomeOrderDTO.invalid == 0 ?  Colors.red[600] : Colours.text_999,
                                                        fontSize: 30.sp,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      )),),
                                                Expanded(child:
                                                    Row(
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
                                                        Expanded(child:
                                                        Text(
                                                            costIncomeOrderDTO
                                                                .creatorName ??
                                                                '',
                                                            style: TextStyle(
                                                              color: Colours.text_999,
                                                              fontSize: 26.sp,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                            ))),
                                                      ],
                                                    )

                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16.w,),
                                            Flex(direction: Axis.horizontal,
                                              children: [
                                                Expanded(child:
                                                  Text(
                                                      DateUtil.formatDefaultDateTimeMinute(
                                                          costIncomeOrderDTO.gmtCreate),
                                                      style: TextStyle(
                                                        color: Colours.text_ccc,
                                                        fontSize: 26.sp,
                                                        fontWeight: FontWeight.w400,
                                                      )),
                                                 ),
                                          Visibility(
                                            visible:costIncomeOrderDTO.productNameList?.isNotEmpty??false ,
                                            child:  Expanded(
                                              child: Row(children: [
                                                Text(
                                                    '绑定：',
                                                    style: TextStyle(
                                                      color: Colours.text_ccc,
                                                      fontSize: 26.sp,
                                                      fontWeight: FontWeight.w400,
                                                    )),
                                                Expanded(child:
                                                Text(
                                                    TextUtil.listToStr(
                                                        costIncomeOrderDTO.productNameList),
                                                    style: TextStyle(
                                                      color: Colours.text_999,
                                                      fontSize: 26.sp,
                                                      fontWeight: FontWeight.w500,
                                                    )))
                                              ]
                                              )

                                          ),)

                                              ],)
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
                          itemCount: state.items?.length ?? 0,
                        ));
                  }),
            )
          ],
        ),
      floatingActionButton:PermissionWidget(
          permissionCode: PermissionCode.funds_cost_order_permission,
          child:Container(
          width: 90.0,
          height: 66.0,
          margin: EdgeInsets.all(30.w),
          child: FloatingActionButton(
            onPressed:()=> Get.offNamed(RouteConfig.costBill, arguments:{'costOrderType': CostOrderType.COST} ),
            child: Container(
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add,
                      size: 30.w,),
                    Text('费用',
                      style: TextStyle(
                          fontSize: 32.sp
                      ),),
                  ],)
            ), // 按钮上显示的图标
          ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained ,);
  }
}
