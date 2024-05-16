import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'custom_record_controller.dart';

class CustomRecordView extends StatelessWidget {
  final controller = Get.find<CustomRecordController>();

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
            title: controller.state.customType == CustomType.CUSTOM.value ? '客户列表' : '供应商列表',
            backPressed: () {
              controller.customRecordGetBack();
            },
            actionWidget: PermissionWidget(
                permissionCode:controller.state.customType == CustomType.CUSTOM.value
                    ? PermissionCode.custom_record_add_custom_permission
                    :PermissionCode.supplier_custom_record_add_custom_permission,
                child: IconButton(
                  onPressed: () {
                    controller.toAddCustom(context);
                  },
                  icon: Icon(Icons.add),
                  color: Colours.primary,
                ))),
        endDrawer: Drawer(
          width: ScreenUtil().screenWidth * 0.8,
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
                      builder: (controller) => OverflowBar(
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
                                        style:
                                            TextStyle(color: Colours.text_999),
                                      ),
                                      Switch(
                                          trackOutlineColor:
                                              WidgetStateProperty.resolveWith(
                                                  (states) {
                                            if (states.contains(
                                                WidgetState.selected)) {
                                              return Colours
                                                  .primary; // 设置轨道边框颜色
                                            }
                                            return Colors.grey; // 默认的轨道边框颜色
                                          }),
                                          inactiveThumbColor: Colors.grey[300],
                                          value:
                                              controller.state.invalid == null,
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
        body: Column(
          children: [
            Flex(direction: Axis.horizontal, children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white30,
                  height: 100.w,
                  padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                  child: SearchBar(
                    onChanged: (value) => controller.searchCustom(value),
                    leading: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 40.w,
                    ),
                    shadowColor: WidgetStatePropertyAll<Color>(Colors.black26),
                    hintStyle: WidgetStatePropertyAll<TextStyle>(
                        TextStyle(fontSize: 34.sp, color: Colors.black26)),
                    hintText: '请输入客户名称',
                    //onChanged: (value) => controller.searchCustom(value),
                  ),
                ),
              ),
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
                        style: TextStyle(fontSize: 30.sp, color: Colours.text_666),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.w),
              width: double.infinity,
              color: Colors.white30,
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
                            style: TextStyle(color: Colours.text_ccc, fontSize: 24.w),
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
            ),
            Expanded(child: GetBuilder<CustomRecordController>(
                id: 'custom_list',
                init: controller,
                global: false,
                builder: (_) =>  controller.state.customList.isEmpty
                    ? EmptyLayout(hintText: '什么都没有'.tr)
                    : ListView.separated(
                  itemBuilder: (context, index) {
                    var custom = controller.state.customList[index];
                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.w,horizontal: 40.w),
                      child: Row(
                        children: [
                          Expanded(child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(custom.customName??'',
                                style: TextStyle(fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colours.text_333
                                ),),
                              SizedBox(height: 16.w,),
                              Text('欠款：${DecimalUtil.formatAmount(custom.creditAmount)}',
                                style: TextStyle(fontSize: 28.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colours.text_999
                                ),)
                            ],
                          )),
                                    IconButton(
                                        onPressed: () =>controller.showBottomSheet(context, custom),
                                        icon: Icon(Icons.more_vert,
                                            color: Colors.grey))
                                  ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    height: 2.w,
                    color: Colours.divider,
                    width: double.infinity,
                  ),
                  itemCount: controller.state.customList.length,
                ))),
          ],
        )

        );
  }

  // body
  // Widget _body() {
  //   return AzListView(
  //     data: controller.state.customList,
  //     itemCount: controller.state.customList.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       CustomDTO customDTO = controller.state.customList[index];
  //       return LedgerContactsCell(
  //         model: customDTO,
  //         index: index,
  //         controller: controller,
  //         dataArr: controller.state.customList,
  //         bottomContactsCountText:
  //             '共 ${controller.state.customList.length-1} 位联系人',
  //         onClickCell: (model) {
  //           // 跳转个人信息页
  //           controller.onClick(model);
  //         },
  //         onClickTopCell: (itemData) {},
  //       );
  //     },
  //     physics: const BouncingScrollPhysics(),
  //     susItemHeight: controller.state.suspensionHeight,
  //     indexBarData: SuspensionUtil.getTagIndexList(controller.state.customList),
      // indexBarOptions: const IndexBarOptions(
      //   needRebuild: true,
      //   ignoreDragCancel: true,
      //   selectTextStyle: TextStyle(
      //       fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
      //   selectItemDecoration:
      //       BoxDecoration(shape: BoxShape.circle, color: Colours.primary),
      //   indexHintWidth: 120 / 2,
      //   indexHintHeight: 100 / 2,
      //   indexHintDecoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage(
      //           'assets/wechat/contacts/ic_index_bar_bubble_gray.png'),
      //       fit: BoxFit.contain,
      //     ),
      //   ),
      //   indexHintAlignment: Alignment.centerRight,
      //   indexHintTextStyle: TextStyle(
      //       color: Colors.white70, fontSize: 30.0, fontWeight: FontWeight.w700),
      //   indexHintChildAlignment: Alignment(-0.25, 0.0),
      //   indexHintOffset: Offset(-10, 0),
      // ),
  //   );
  // }

}
