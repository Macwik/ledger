import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/empty_layout.dart';

import 'shopping_car_list_controller.dart';

class ShoppingCarListView extends StatelessWidget {
  ShoppingCarListView({super.key});

  final controller = Get.find<ShoppingCarListController>();
  final state = Get.find<ShoppingCarListController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        title: Text('销售开单',
            style: TextStyle(color: Colors.white)),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 160.w,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 24.w),
            margin: EdgeInsets.only(bottom: 24.w),
            child: GetBuilder<ShoppingCarListController>(
                id: 'shopping_car_list_title',
                builder: (_) {
                  return Flex(
                    direction: Axis.horizontal,
              children: [
                Expanded(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('数量合计',
                        style: TextStyle(color: Colours.text_666)),
                    Text('999件',
                        style: TextStyle(color:Colours.text_333)),
                  ],
                ) ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('金额合计',
                        style: TextStyle(color: Colours.text_666)),
                    Text('888元',
                        style: TextStyle(color: Colours.text_333)),
                  ],
                ))
              ],
            );})
          ),
          Expanded(child:
              GetBuilder<ShoppingCarListController>(
                  id: 'shopping_car_list_detail',
                  builder: (_) {
                    return controller.state.shoppingCarList.isEmpty
                        ?  EmptyLayout(hintText: '请添加货物')
                        : ListView.separated(
                      separatorBuilder: (context, index) => Container(
                        height: 1.w,
                        color: Colours.divider,
                        width: double.infinity,
                      ),
                      itemCount:
                      controller.state.shoppingCarList.length,
                      itemBuilder: (BuildContext context, int index) {
                        ProductShoppingCarDTO productDTO =
                        controller.state.shoppingCarList[index];
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
                                    controller.toDeleteOrder(productDTO);
                                  },
                                ),
                              ],
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 24.w,
                                  horizontal: 40.w),
                              width: double.infinity,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                              productDTO.productName ?? '',
                                              style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 32.sp,
                                                fontWeight:
                                                FontWeight.w500,
                                              ))),
                                      Text(
                                          '数量：',
                                          style: TextStyle(
                                            color: Colours.text_999,
                                            fontSize: 30.sp,
                                            fontWeight:
                                            FontWeight.w500,
                                          )),
                                      Text(controller.getNum(productDTO.unitDetailDTO!) ?? '',
                                          style: TextStyle(
                                            color: Colours.text_333,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w500,
                                          )),

                                    ],
                                  ),
                                  SizedBox(
                                    height: 24.w,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          '单价：',
                                          style: TextStyle(
                                            color: Colours.text_999,
                                            fontSize: 30.sp,
                                            fontWeight:
                                            FontWeight.w500,
                                          )),
                                      Text(controller.getPrice(productDTO.unitDetailDTO!) ?? '',
                                          style: TextStyle(
                                            color: Colours.text_333,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Expanded(child: Text(
                                          DecimalUtil.formatAmount(productDTO.unitDetailDTO?.totalAmount),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colours.primary,
                                            fontSize: 36.sp,
                                            fontWeight:
                                            FontWeight.w500,
                                          ))),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      },
                    );
                  }),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedBtn(
                    margin: EdgeInsets.only(top: 80.w),
                    size: Size(double.infinity, 90.w),
                    onPressed: (){},
                    radius: 15.w,
                    backgroundColor: Colors.white,
                    text: '继续添加',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedBtn(
                    margin: EdgeInsets.only(top: 80.w),
                    size: Size(double.infinity, 90.w),
                    onPressed: () =>Get.back(),
                    radius: 15.w,
                    backgroundColor: Colours.primary,
                    text: '选好了',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ]

      ),
    );
  }
}
