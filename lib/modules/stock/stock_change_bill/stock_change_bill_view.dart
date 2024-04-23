import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_stock_adjust_request.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/will_pop.dart';

import 'stock_change_bill_controller.dart';

class StockChangeBillView extends StatelessWidget {
  StockChangeBillView({super.key});

  final controller = Get.find<StockChangeBillController>();
  final state = Get
      .find<StockChangeBillController>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(
        backPressed: ()=> controller.stockChangeGetBack(),
        title: '新增盘点单'.tr,),
      body: MyWillPop(
          onWillPop: () async {
            controller.stockChangeGetBack();
            return true;
          },
          child:CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                height: 80.w,
                margin: EdgeInsets.symmetric(vertical: 20.w,horizontal: 40.w),
                child: ElevatedButton(
                  onPressed: () => controller.addStockChange(),
                  child: Text(
                    '+ 添加货物',
                    style: TextStyle(
                      color: Colours.primary,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: Colours.primary),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    elevation: MaterialStateProperty.all(5),
                    overlayColor: MaterialStateProperty.all(
                        Colours.primary.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.w),
                    )),
                  ),
                ),
              )),
          //货物详情
          SliverToBoxAdapter(
              child: // 货物详情
              GetBuilder<StockChangeBillController>(
                  id: 'stock_change_product_title',
                  builder: (_) {
                    return Visibility(
                        visible: state.visible,
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              left: 40.w, right: 40.w, top: 32.w,bottom: 24.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    color: Colours.primary,

                                    height: 32.w,
                                    width: 8.w,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    height: 38.w,
                                    margin: EdgeInsets.only(left: 12.w),
                                    child: Text(
                                      '盘点详情',
                                      style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 34.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    );
                  })
          ),
          GetBuilder<StockChangeBillController>(
              id: 'sale_bill_product_list',
              builder: (_) {
                return state.productStockAdjustRequest.isBlank ?? true
                    ? SliverToBoxAdapter(
                  child: EmptyLayout(hintText: '什么都没有'.tr),)
                    : SliverList.separated(
                  separatorBuilder: (context, index) =>
                      Container(
                        height: 1.w,
                        color: Colours.divider,
                        width: double.infinity,
                      ),
                  itemCount: state.productStockAdjustRequest.length,
                  itemBuilder: (BuildContext context, int index) {
                    ProductStockAdjustRequest productAdjust = state
                        .productStockAdjustRequest[index];
                    return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 0.25,
                          children: [
                            SlidableAction(
                              label: '删除',
                              backgroundColor: Colors.red,
                              icon: Icons.delete_outline_rounded,
                              onPressed: (context) {
                                controller.toDeleteOrder(productAdjust);
                              },
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 30.w,
                              right: 30.w,
                              top: 20.w,
                              bottom: 20.w),
                          width: double.infinity,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(child:
                              Text(productAdjust.productName??'',
                                  style: TextStyle(
                                    color: Colours.text_333,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w500,
                                  ))),
                      Expanded(child:
                      Text(controller.judgeUnit(productAdjust),
                                  style: TextStyle(
                                    color: Colours.text_333,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w400,
                                  ))),
                            ],
                          ),
                        ));
                  },
                );
              }),
        ],
      )),

      //底部按钮
      floatingActionButton: GetBuilder<StockChangeBillController>(
          id: 'stock_change_bill_btn',
          builder: (_) {
            return Container(
              height: 100.w,
              margin: EdgeInsets.only(bottom: 3.w, right: 5.w, left: 5.w),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(right: 3.w),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.2),
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        height: 100.w,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.stockChangeGetBack();
                          },
                          style: ButtonStyle(
                            maximumSize: MaterialStateProperty.all(
                                Size(double.infinity, 60)),
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                          ),
                          child: Text(
                            '取消',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 32.sp,
                            ),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 100.w,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colours.primary.withOpacity(0.2),
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        child: ElevatedButton(
                          onPressed: () => controller.toSubmitOrder(),
                          style: ButtonStyle(
                            maximumSize: MaterialStateProperty.all(
                                Size(double.infinity, 60)),
                            backgroundColor:
                            MaterialStateProperty.all(Colours.primary),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                          ),
                          child: Text(
                            '提交',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.sp,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
