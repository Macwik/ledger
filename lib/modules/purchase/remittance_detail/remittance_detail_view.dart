import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/is_deleted.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/share_utils.dart';
import 'package:ledger/util/text_util.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'remittance_detail_controller.dart';

class RemittanceDetailView extends StatelessWidget {
  RemittanceDetailView({super.key});

  final GlobalKey remittanceDetailKey = GlobalKey();

  final controller = Get.find<RemittanceDetailController>();
  final state = Get.find<RemittanceDetailController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        title: Text('汇款详情'.tr,
        style: TextStyle(color: Colors.white)),
        actions:[GetBuilder<RemittanceDetailController>(
          id: 'remittance_detail_title',
          builder: (_){
          return PermissionWidget(
              permissionCode: PermissionCode.remittance_detail_delete_permission,
              child:Visibility(
              visible: state.remittanceDetailDTO?.invalid == IsDeleted.NORMAL.value,
              child: PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (String value) {
              // 处理选择的菜单项
              if (value == 'delete') {
                // 执行删除操作
                controller.toDeleteOrder();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('强制作废'),
                ),
              ),
            ],
          )))
            ;
        },)],
      ),
      body:  RepaintBoundary(
          key: remittanceDetailKey,
          child:CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: GetBuilder<RemittanceDetailController>(
              id: 'remittance_detail',
              builder: (_){
                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(32.w),
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(child: Text(
                            '日期',
                            style: TextStyle(
                              color: Colours.text_666,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ), ),
                          Visibility(
                              visible:state.remittanceDetailDTO?.invalid == IsDeleted.DELETED.value,
                              child: Container(
                                padding: EdgeInsets.only(top:2.w,bottom:2.w,left: 4.w,right: 4.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                    '已作废',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ) ),
                          Expanded(
                            child: Text(DateUtil.formatDefaultDate2(state.remittanceDetailDTO?.remittanceDate),
                            textAlign:TextAlign.right,
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w500,
                            ),), ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colours.divider,
                      height: 1.w,
                      width: double.infinity,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(32.w),
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Text(
                            '收款人姓名',
                            style: TextStyle(
                              color: Colours.text_666,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Text(state.remittanceDetailDTO?.receiver ?? '',
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w500,
                            ),)
                        ],
                      ),
                    ),
                    Container(
                      color: Colours.divider,
                      height: 1.w,
                      width: double.infinity,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(32.w),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.bottomCenter,
                                    child:  Row(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '* ',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Text(
                                             '汇款金额',
                                            style: TextStyle(
                                              color: Colours.text_666,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w400,),
                                          ),
                                        ],
                                      ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(top: 16.w),
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      state.remittanceDetailDTO?.amount.toString() ??
                                          '',
                                      style: TextStyle(
                                        color: Colours.text_333,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w500,
                                      ),)),
                              ],
                            ),
                          ),
                          Container(
                            color: Colours.divider,
                            margin: EdgeInsets.only(top: 10.0),
                            width: 2.w,
                            height: 100.w,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                             '* ',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Text(
                                            '汇款账户',
                                            style: TextStyle(
                                              color: Colours.text_666,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w400,),
                                          ),
                                        ],
                                      ),
                                    ),
                                Container(
                                  padding: EdgeInsets.only(top: 16.w),
                                  alignment: Alignment.bottomCenter,
                                  child: Text(controller.formatPayment(state.remittanceDetailDTO?.paymentDTOList),
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                );
              },),
          ),
          SliverToBoxAdapter(
            child: GetBuilder<RemittanceDetailController>(
              id:'remittance_product',
              builder: (_){
              return  Column(
                children: [
                  Container(
                    color: Colors.white10,
                    height: 32.w,
                    width: double.infinity,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(32.w),
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Text(
                          '采购品种',
                          style: TextStyle(
                            color: Colours.text_666,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        Text(TextUtil.listToStr(state.remittanceDetailDTO?.productNameList),
                          style: TextStyle(
                            color: Colours.text_333,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w500,
                          ),),
                      ],
                    ),
                  ),
                  Container(
                    color: Colours.divider,
                    height: 1.w,
                    width: double.infinity,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(32.w),
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child:
                    LimitedBox(
                        maxHeight: 200.0, // 设置容器的最大高度
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '备注',
                                style: TextStyle(
                                  color: Colours.text_666,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  textAlign: TextAlign.right,
                                  softWrap: true, // 允许文本自动换行
                                  state.remittanceDetailDTO?.remark ?? '',
                                  style: TextStyle(
                                    color: Colours.text_333,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ],
                        )),
                  ),
                  Container(
                    color: Colours.divider,
                    height: 1.w,
                    width: double.infinity,
                  ),
                ],
              );
            },),
          ),
        ],
      )),
      floatingActionButton: GetBuilder<RemittanceDetailController>(
          id: 'remittance_btn',
          builder: (_) {
            return GetBuilder<RemittanceDetailController>(
                id: 'export_btn',
                builder: (logic) {
                  return  PermissionWidget(
                      permissionCode: PermissionCode.remittance_detail_share_permission,
                      child:Container(
                    width: double.infinity,
                    height: 100.w,
                    child: ElevatedBtn(
                      onPressed: () {
                        ShareUtils.onSharePlusShare(context, remittanceDetailKey);
                      },
                      size: Size(double.infinity, 90.w),
                      radius: 15.w,
                      backgroundColor: Colours.primary,
                      text: '分享',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ));
                });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
