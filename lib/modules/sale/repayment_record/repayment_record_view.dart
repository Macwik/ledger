import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/picker_date_utils.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'package:ledger/widget/will_pop.dart';

import 'repayment_record_controller.dart';

class RepaymentRecordView extends StatelessWidget {
  RepaymentRecordView({super.key});

  final controller = Get.find<RepaymentRecordController>();
  final state = Get.find<RepaymentRecordController>().state;
  @override
  Widget build(BuildContext context) {
    controller.initState();
    return  Scaffold(
          appBar: TitleBar(
              title: '还款列表',
            actionWidget: PermissionWidget(
                permissionCode:PermissionCode.funds_add_debt_permission,
                child:
              InkWell(
                  onTap: ()=>Get.toNamed(RouteConfig.addDebt),
                child:Container(
                    margin: EdgeInsets.only(right: 16.w),
                    child:Text('录入欠款')) ,
                )),
            // actionPressed: ()=>
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
                                            padding: WidgetStateProperty.all(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 10)),
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.white), // 背景色
                                            shape: WidgetStateProperty.all(
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
                                      WidgetStateProperty.resolveWith(
                                              (states) {
                                            if (states.contains(
                                                WidgetState.selected)) {
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
          body:  MyWillPop(
              onWillPop: () async {
                EasyLoading.dismiss();
                Get.until((route) {
                  return (route.settings.name == RouteConfig.main)||(route.settings.name == RouteConfig.more);
                });
                return Future(() => true);
              },
              child:DefaultTabController(
              length: controller.permissionCount(),
              initialIndex: 0,
              child:Column(
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
                    indicatorColor: Colours.primary,
                    dividerColor: Colours.bg,
                    unselectedLabelColor: Colours.text_999,
                    unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(fontWeight: FontWeight.w500),
                    labelColor: Colours.primary,
                  )),
              Expanded(
                  child: TabBarView(
                      controller: controller.tabController,
                      children: controller.widgetTabBarViews()
              ))
            ],
          )))
      );
  }

}


