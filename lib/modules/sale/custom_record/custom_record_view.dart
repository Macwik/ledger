import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'package:ledger/widget/will_pop.dart';

import 'custom_record_controller.dart';

class CustomRecordView extends StatelessWidget {
  final controller = Get.find<CustomRecordController>();

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<CustomRecordController>(
            id: 'title',
            init: controller,
            global: false,
            builder: (_) {
              return Text(
                  controller.state.initialIndex == 0 ? '客户列表' : '供应商列表');
            }),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
        ),
        leading: BackButton(
            onPressed: () {
              controller.customRecordGetBack();
            },
            color: Colors.white),
        backgroundColor: Colours.primary,
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.8,
        backgroundColor: Colours.bg,
        child: Container(
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
                  Text(
                    '欠款情况',
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  GetBuilder<CustomRecordController>(
                    id: 'custom_status',
                    init: controller,
                    global: false,
                    builder: (controller) => ButtonBar(
                      overflowDirection: VerticalDirection.down,
                      alignment: MainAxisAlignment.start,
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
                            controller.state.debtStatus = null;
                            controller.update(['custom_status']);
                          },
                          child: Text('全部'),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.state.debtStatus = 1;
                            controller.update(['custom_status']);
                          },
                          child: Text('有欠款'),
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
                        TextButton(
                          onPressed: () {
                            controller.state.debtStatus = 0;
                            controller.update(['custom_status']);
                          },
                          child: Text('无欠款'),
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
                  Visibility(
                      visible: controller.state.isSelectCustom != true,
                      child: GetBuilder<CustomRecordController>(
                          id: 'switch',
                          init: controller,
                          global: false,
                          builder: (_) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '停用客户/供应商',
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
                                          if (states.contains(
                                              MaterialState.selected)) {
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
                                        }),
                                  ],
                                )
                              ],
                            );
                          })),
                ],
              ),
              Positioned(
                bottom: 100.w,
                right: 20.w,
                left: 20.w,
                child: GetBuilder<CustomRecordController>(
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
      body: MyWillPop(
          onWillPop: () async {
            controller.customRecordGetBack();
            return true;
          },
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 120.w,
                      color: Colors.white60,
                      padding: EdgeInsets.all(10.w),
                      child: SearchBar(
                        leading: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: '请输入客户名称',
                        onChanged: (value) => controller.searchCustom(value),
                      ),
                    ),
                  ),
                  PermissionWidget(
                      permissionCode:
                          PermissionCode.custom_record_add_custom_permission,
                      child: Container(
                          color: Colors.white60,
                          height: 120.w,
                          child: IconButton(
                            onPressed: () {
                              controller.toAddCustom();
                            },
                            icon: Icon(Icons.add),
                            color: Colors.redAccent,
                          )))
                ],
              ),
              GetBuilder<CustomRecordController>(
                  id: 'custom_custom_header',
                  init: controller,
                  global: false,
                  builder: (_) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      width: double.infinity,
                      color: Colors.white12,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                //height: 90.w,
                                padding: EdgeInsets.only(left: 40.w),
                                child: Row(children: [
                                  Text(
                                    '欠款人数： ',
                                    style: TextStyle(
                                      color: Colours.text_ccc,
                                      fontSize: 26.w,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.state.totalCreditCustom
                                          .toString(),
                                      style: TextStyle(
                                          color: Colours.primary,
                                          fontSize: 28.w,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ])),
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              Text(
                                '欠款金额： ',
                                style: TextStyle(
                                    color: Colours.text_ccc, fontSize: 24.w),
                              ),
                              Expanded(
                                child: Text(
                                  DecimalUtil.formatDecimal(
                                      controller.state.totalCreditAmount,
                                      scale: 0),
                                  style: TextStyle(
                                      color: Colours.primary,
                                      fontSize: 28.w,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ])),
                          ),
                        ],
                      ),
                    );
                  }),
              //合计欠款人数&金额
              GetBuilder<CustomRecordController>(
                  id: 'custom_list',
                  global: false,
                  init: controller,
                  builder: (_) {
                    return Flexible(
                      child: controller.state.customList?.isEmpty ?? true
                          ? EmptyLayout(hintText: '什么都没有'.tr)
                          : ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                CustomDTO customDTO =
                                    controller.state.customList![index];
                                return InkWell(
                                  onTap: () => controller.onClick(customDTO),
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40.w, vertical: 20.w),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.w),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          customDTO
                                                                  .customName ??
                                                              '',
                                                          style: TextStyle(
                                                            color: customDTO
                                                                        .invalid ==
                                                                    1
                                                                ? Colours
                                                                    .text_ccc
                                                                : Colours
                                                                    .text_333,
                                                            fontSize: 32.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          )),
                                                      SizedBox(
                                                        width: 15.w,
                                                      ),
                                                      Visibility(
                                                        visible:
                                                            customDTO.invalid ==
                                                                1,
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
                                                          child: Text('已停用',
                                                              style: TextStyle(
                                                                color: Colours
                                                                    .text_999,
                                                                fontSize: 26.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              )),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                              Row(
                                                children: [
                                                  Text(
                                                    '欠款：',
                                                    style: TextStyle(
                                                      color: Colours.text_ccc,
                                                      fontSize: 26.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    DecimalUtil.formatAmount(
                                                        customDTO.creditAmount),
                                                    style: TextStyle(
                                                      color:
                                                          customDTO.invalid == 1
                                                              ? Colours.text_ccc
                                                              : Colours
                                                                  .text_666,
                                                      fontSize: 26.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                            visible: controller
                                                    .state.isSelectCustom !=
                                                true,
                                            child: IconButton(
                                                onPressed: () =>
                                                    controller.showBottomSheet(
                                                        context, customDTO),
                                                icon: Icon(Icons.more_vert,
                                                    color: Colors.grey)))
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
                              itemCount:
                                  controller.state.customList?.length ?? 0,
                            ),
                    );
                  }),
            ],
          )),
    );
  }
}
