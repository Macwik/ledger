import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/enum/is_deleted.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/share_utils.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'add_stock_detail_controller.dart';

class AddStockDetailView extends StatelessWidget {
  AddStockDetailView({super.key});

  final GlobalKey salesDetailKey = GlobalKey();

  final controller = Get.find<AddStockDetailController>();
  final state = Get.find<AddStockDetailController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          '入库单详情',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
        )),
        actions: [
          GetBuilder<AddStockDetailController>(
              id: 'sale_detail_delete',
              builder: (_) {
                return PermissionWidget(
                    permissionCode:  PermissionCode.purchase_detail_delete_permission,
                    child: Visibility(
                        visible: state.orderDetailDTO?.invalid == IsDeleted.NORMAL.value,
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert, color: Colors.white),
                          onSelected: (String value) {
                            // 处理选择的菜单项
                            if (value == 'delete') {
                              // 执行删除操作
                              controller.toDeleteOrder();
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('强制作废'),
                              ),
                            ),
                          ],
                        )));
              })
        ],
      ),
      body: SingleChildScrollView(
          child: RepaintBoundary(
              key: salesDetailKey,
              child: Column(children: [
                GetBuilder<AddStockDetailController>(
                    id: 'sale_detail_title',
                    builder: (_){
                      return Container(
                        padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 30.w),
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
                              margin: EdgeInsets.only(left: 6.w,right:32.w ),
                              child: Text(
                                '货物明细',
                                style: TextStyle(
                                    color: Colours.text_666,
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Visibility(
                                visible: state.orderDetailDTO?.invalid == IsDeleted.DELETED.value,
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
                                  child: Text('已作废',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                          ],
                        ),
                      );
                    }),
                GetBuilder<AddStockDetailController>(
                    id: '',
                    builder: (_) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Container(
                          height: 2.w,
                          color: Colours.divider,
                          width: double.infinity,
                        ),
                        itemCount: state.orderDetailDTO?.orderProductDetailList
                            ?.length ??
                            0,
                        itemBuilder: (BuildContext context, int index) {
                          var orderProductDetail = state
                              .orderDetailDTO?.orderProductDetailList![index];
                          return Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                left: 40.w,
                                right: 40.w,
                                top: 32.w,
                                bottom: 16.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                        child: Text(
                                            orderProductDetail?.productName ??
                                                '',
                                            style: TextStyle(
                                              color: Colours.text_333,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500,
                                            ))),
                                    Expanded(
                                      child: Text(
                                         '',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colours.text_333,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    )
                                  ],
                                ),

                                //),
                              ],
                            ),
                          );
                        },
                      );
                    }),

                //收款情况
                Container(
                    padding: EdgeInsets.only(
                        right: 40.w, left: 40.w, top: 30.w, bottom: 20.w),
                    color: Colors.white,
                    child: GetBuilder<AddStockDetailController>(
                        id: '',
                        builder: (_) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    color: Colours.primary,
                                    height: 38.w,
                                    width: 8.w,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(left: 6),
                                    child: Text(
                                      '付款信息',
                                      style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 36.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 32.w,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '实付金额',
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
                                      '',
                                      style: TextStyle(
                                        color: Colours.text_333,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                color: Colours.divider,
                                height: 1.w,
                                margin: EdgeInsets.only(top: 16, bottom: 16),
                                width: double.infinity,
                              ),
                              Visibility(
                                  visible: state.orderDetailDTO?.creditAmount !=
                                      Decimal.zero,
                                  child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '赊账：',
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '',
                                            // DecimalUtil.formatAmount(state.orderDetailDTO?.creditAmount),
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ))),
                              Visibility(
                                  visible: state.orderDetailDTO?.creditAmount !=
                                      Decimal.zero,
                                  child: Container(
                                    color: Colours.divider,
                                    height: 1.w,
                                    margin:
                                    EdgeInsets.only(top: 16, bottom: 16),
                                    width: double.infinity,
                                  )),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    '抹零金额',
                                    style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        DecimalUtil.formatAmount(
                                            state.orderDetailDTO?.discountAmount),
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          );
                        })),
                Column(
                  children: [
                    Container(
                      height: 32.w,
                      color: Colors.white12,
                    ),
                    GetBuilder<AddStockDetailController>(
                        id: '',
                        builder: (_) {
                          return Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                  left: 40.w,
                                  right: 40.w,
                                  top: 30.w,
                                  bottom: 20.w),
                              child: Column(
                                children: [
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                          child: Text(
                                            '日期',
                                            style: TextStyle(
                                              color: Colours.text_666,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                      Expanded(
                                          child: Text(
                                            textAlign: TextAlign.right,
                                            DateUtil.formatDefaultDate2(
                                                state.orderDetailDTO?.gmtCreate),
                                            style: TextStyle(
                                              color: Colours.text_333,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ))
                                    ],
                                  ),
                                  Container(
                                    color: Colours.divider,
                                    height: 1.w,
                                    margin:
                                    EdgeInsets.only(top: 16, bottom: 16),
                                    width: double.infinity,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        state.orderType == OrderType.SALE
                                            ? '客户'
                                            : '供应商',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        state.orderDetailDTO?.customName ??
                                            '默认${state.orderType == OrderType.SALE ? '客户' : '供应商'}',
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    color: Colours.divider,
                                    height: 1.w,
                                    margin:
                                    EdgeInsets.only(top: 16, bottom: 16),
                                    width: double.infinity,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '业务员',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        state.orderDetailDTO?.creatorName ?? '',
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    color: Colours.divider,
                                    height: 1.w,
                                    margin:
                                    EdgeInsets.only(top: 16, bottom: 16),
                                    width: double.infinity,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 100.w),
                                    child: LimitedBox(
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
                                                  state.orderDetailDTO
                                                      ?.remark ??
                                                      '',
                                                  style: TextStyle(
                                                    color: Colours.text_333,
                                                    fontSize: 32.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )),
                                          ],
                                        )),
                                  ),
                                ],
                              ));
                        }),
                  ],
                ),
              ]))),
      //底部按钮
      floatingActionButton: PermissionWidget(
          permissionCode: (state.orderType == OrderType.SALE)
              ? PermissionCode.sales_detail_share_permission
              : PermissionCode.purchase_detail_share_permission,
          child: Builder(builder: (BuildContext buildContext) {
            return ElevatedBtn(
              margin: EdgeInsets.only(top: 80.w),
              size: Size(double.infinity, 90.w),
              onPressed: () {
                ShareUtils.onSharePlusShare(buildContext, salesDetailKey);
              },
              radius: 15.w,
              backgroundColor: Colours.primary,
              text: '分享单据',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.sp,
                fontWeight: FontWeight.w500,
              ),
            );
          })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
