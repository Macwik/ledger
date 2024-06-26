import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/modules/sale/choose_custom/ledger_contacts_cell.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'package:ledger/widget/title_bar.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'choose_custom_controller.dart';

class ChooseCustomView extends StatelessWidget {
  ChooseCustomView({super.key});

  final controller = Get.find<ChooseCustomController>();
  final state = Get.find<ChooseCustomController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
            title: controller.state.customType == CustomType.CUSTOM.value ? '客户列表' : '供应商列表',
            backPressed: () {
              controller.chooseCustomGetBack();
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
                    GetBuilder<ChooseCustomController>(
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
                        child: GetBuilder<ChooseCustomController>(
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
                  child: GetBuilder<ChooseCustomController>(
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
        body: VisibilityDetector(
            key: Key('CustomRecordVisibilityKey'),
            child: GetBuilder<ChooseCustomController>(
                id: 'custom_list',
                init: controller,
                global: false,
                builder: (_) => SlidableAutoCloseBehavior(child: _body())),
            onVisibilityChanged: (visibilityInfo) {
              var visiblePercentage = visibilityInfo.visibleFraction * 100;
              if (visiblePercentage > 30) {
                controller.queryCustom();
              }
            }));
  }

  // body
  Widget _body() {
    return AzListView(
      data: controller.state.customList,
      itemCount: controller.state.customList.length,
      itemBuilder: (BuildContext context, int index) {
        CustomDTO customDTO = controller.state.customList[index];
        return LedgerContactsCell(
          model: customDTO,
          index: index,
          controller: controller,
          dataArr: controller.state.customList,
          bottomContactsCountText:
          '共 ${controller.state.customList.length-1} 位联系人',
          onClickCell: (model) {
            // 跳转个人信息页
            controller.onClick(model);
          },
          onClickTopCell: (itemData) {},
        );
      },
      physics: const BouncingScrollPhysics(),
      susItemHeight: controller.state.suspensionHeight,
      susItemBuilder: (BuildContext context, int index) {
        CustomDTO model = controller.state.customList[index];
        String tag = model.getSuspensionTag();
        if ('🔍' == model.getSuspensionTag()) {
          return Container();
        }
        return _buildSusWidget(tag, context);
      },
      indexBarData: SuspensionUtil.getTagIndexList(controller.state.customList),
      indexBarItemHeight: 24,
      indexBarOptions: const IndexBarOptions(
        needRebuild: true,
        ignoreDragCancel: true,
        selectTextStyle: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
        selectItemDecoration:
        BoxDecoration(shape: BoxShape.circle, color: Colours.primary),
        indexHintWidth: 120 / 2,
        indexHintHeight: 100 / 2,
        indexHintDecoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/wechat/contacts/ic_index_bar_bubble_gray.png'),
            fit: BoxFit.contain,
          ),
        ),
        indexHintAlignment: Alignment.centerRight,
        indexHintTextStyle: TextStyle(
            color: Colors.white70, fontSize: 30.0, fontWeight: FontWeight.w700),
        indexHintChildAlignment: Alignment(-0.25, 0.0),
        indexHintOffset: Offset(-10, 0),
      ),
    );
  }

  // 吸顶组件
  Widget _buildSusWidget(String susTag, BuildContext context) {
    return Container(
      height: controller.state.suspensionHeight * 0.5,
      width: ScreenUtil().screenWidth,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Colors.white30,
        // border: const Border(bottom: BorderSide(color: Color(0xFFE6E6E6), width: 0.5)),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        susTag,
        softWrap: false,
        style: TextStyle(
          fontSize: 26.sp,
          color: const Color(0xFFCCCCCC),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
