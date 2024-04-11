import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'product_credit_controller.dart';

class ProductCreditView extends StatelessWidget {
  ProductCreditView({super.key});

  final controller = Get.find<ProductCreditController>();
  final state = Get.find<ProductCreditController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
        title: '赊账情况'.tr,
      ),
      body: Column(
        children: [
         Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: 32.w, left: 40.w, right: 40.w, bottom: 10.w),
              child: Row(
                children: [
                  LoadSvg(
                    'svg/ic_mine_accounts',
                    width: 48.w,
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    height: 80.w,
                    alignment: Alignment.center,
                    child: Text(
                      '赊账情况',
                      style: TextStyle(
                          color: Colours.text_666,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('合计：',
                  style: TextStyle(
                      color: Colours.text_ccc,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600),
                  ),
                      Text(DecimalUtil.formatDecimalNumber(state.creditAmount),
                        style: TextStyle(
                            color: Colors.orange[600],
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ))
                ],
              ),
            ),
          Container(
            height: 1.w,
            color: Colors.orange[700],
          ),
          Expanded(child:
          GetBuilder<ProductCreditController>(
            id: 'goods_detail_product_credit_statistics',
              builder: (_) {
                return CustomEasyRefresh(
                  controller: state.refreshController,
                  onLoad: controller.onLoad,
                  onRefresh: controller.onRefresh,
                  emptyWidget: state.items == null
                      ? LottieIndicator()
                      : state.items!.isEmpty
                    ?  EmptyLayout(hintText: '什么都没有')
                       : null,
                    child: ListView.separated(
                    itemBuilder: (context, index) {
                      var productSalesCredit = controller.state.items![index];
                      return Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: InkWell(
                            onTap: ()=> controller.toSalesDetail(productSalesCredit),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                 children: [
                                   Expanded(
                                     child: Container(
                                       alignment: Alignment.centerLeft,
                                       child:  Text(
                                           DateUtil.formatDefaultDate2(
                                               productSalesCredit.gmtCreate),
                                           style: TextStyle(
                                             color: Colours.text_ccc,
                                             fontSize: 28.sp,
                                             fontWeight: FontWeight.w400,
                                           )),
                                     ),
                                   ),
                                   // Visibility(
                                   //     visible:productSalesCredit.orderStatus ==1,
                                   //     child: Container(
                                   //       padding: EdgeInsets.only(
                                   //           top: 2.w,
                                   //           bottom: 2.w,
                                   //           left: 4.w,
                                   //           right: 4.w),
                                   //       decoration: BoxDecoration(
                                   //         border: Border.all(
                                   //           color: Colours.text_ccc,
                                   //           width: 1.0,
                                   //         ),
                                   //         borderRadius:
                                   //         BorderRadius.circular(8.0),
                                   //       ),
                                   //       child: Text('已结清',
                                   //           style: TextStyle(
                                   //             color: Colours.text_ccc,
                                   //             fontSize: 28.sp,
                                   //             fontWeight: FontWeight.w500,
                                   //           )),
                                   //     )),
                                   Expanded(child:  Text(controller.checkOrderType(productSalesCredit.orderType),
                                       textAlign:TextAlign.right,
                                       style: TextStyle(
                                         color:  productSalesCredit.orderStatus ==1
                                             ?Colours.text_ccc
                                             :Colours.text_999,
                                         fontSize: 28.sp,
                                         fontWeight: FontWeight.w400,
                                       )
                                   )),
                                   // Expanded(child:Container(
                                   //   child: Text(
                                   //     textAlign:TextAlign.right,
                                   //     productSalesCredit.orderStatus ==1
                                   //         ?'已结清'
                                   //         :'未结清',
                                   //       style: TextStyle(
                                   //         color:  productSalesCredit.orderStatus ==1
                                   //         ?Colours.text_ccc
                                   //         :Colours.text_999,
                                   //         fontSize: 28.sp,
                                   //         fontWeight: FontWeight.w400,
                                   //       )
                                   //   ),
                                   // ) )
                                 ],
                                ),
                                SizedBox(height: 24.w,),
                                Row(
                                  children: [
                                    Expanded(child: Row(
                                      children: [
                                        Expanded(child: Text(productSalesCredit.customerName??'',
                                            style: TextStyle(
                                              color:productSalesCredit.orderStatus ==1
                                                  ? Colours.text_ccc
                                                  : Colours.text_333,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w500,
                                            ))),
                                        // Visibility(
                                        //     visible: (productSalesCredit.orderType == OrderType.SALE_RETURN.value) ||
                                        //         (productSalesCredit.orderType == OrderType.PURCHASE_RETURN.value)||
                                        //         (productSalesCredit.orderType == OrderType.REFUND.value),
                                        //     child: Container(
                                        //       margin: EdgeInsets.symmetric(
                                        //           horizontal: 16.w),
                                        //       padding: EdgeInsets.symmetric(
                                        //           horizontal: 6.w,
                                        //           vertical: 2.w),
                                        //       decoration: (BoxDecoration(
                                        //           borderRadius:
                                        //           BorderRadius.circular(
                                        //               (36)),
                                        //           border: Border.all(
                                        //               color: productSalesCredit.orderStatus ==1
                                        //                   ? Colours.text_ccc
                                        //                   :Colors.orange,
                                        //               width: 3.w),
                                        //           color: Colors.white)),
                                        //       child: Text(
                                        //         '退',
                                        //         style: TextStyle(
                                        //           fontSize: 24.sp,
                                        //           color: productSalesCredit.orderStatus ==1
                                        //             ? Colours.text_ccc
                                        //             :Colors.orange,
                                        //         ),
                                        //       ),
                                        //     )),
                                      ],
                                    )),
                                    Expanded(child: Row(
                                      children: [
                                        Text('欠款:',
                                            style: TextStyle(
                                              color: Colours.text_ccc,
                                              fontSize: 28.sp,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        SizedBox(width: 10.w),
                                            Text(
                                                (productSalesCredit.orderType == OrderType.SALE_RETURN.value) ||
                                                        (productSalesCredit.orderType == OrderType.PURCHASE_RETURN.value) ||
                                                        (productSalesCredit.orderType == OrderType.REFUND.value)
                                                    ? DecimalUtil.formatNegativeAmount(productSalesCredit.creditAmount)
                                            : DecimalUtil.formatAmount(productSalesCredit.creditAmount),
                                            style: TextStyle(
                                              color:productSalesCredit.orderStatus ==1
                                                  ? Colours.text_ccc
                                                  : Colours.text_333,
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w400,
                                            ))],
                                    ))]),
                                SizedBox(height: 16.w),
                                Row(children: [
                                  Expanded(child:  Container(
                                    alignment: Alignment.centerLeft,
                                    child:  Text(controller.judgeUnit(productSalesCredit),
                                        style: TextStyle(
                                          color:productSalesCredit.orderStatus ==1
                                              ? Colours.text_ccc
                                              : Colours.text_999,
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ),),
                                  Expanded(child: Row(
                                   // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('还款:',
                                          style: TextStyle(
                                            color: Colours.text_ccc,
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      SizedBox(width: 10.w),
                                      Text(   (productSalesCredit.orderType == OrderType.SALE_RETURN.value) ||
                                          (productSalesCredit.orderType == OrderType.PURCHASE_RETURN.value) ||
                                          (productSalesCredit.orderType == OrderType.REFUND.value)
                                          ? DecimalUtil.formatNegativeAmount(productSalesCredit.repaymentAmount)
                                         : DecimalUtil.formatAmount(productSalesCredit.repaymentAmount),
                                          style: TextStyle(
                                            color:productSalesCredit.orderStatus ==1
                                                ? Colours.text_ccc
                                                : Colours.text_333,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ],
                                  ))


                                ],)
                              ],
                            ),
                          ));
                    },
                    //separatorBuilder是分隔符组件，可以直接拿来用
                    separatorBuilder: (context, index) => Container(
                      height: 2.w,
                      color: Colours.divider,
                      width: double.infinity,
                    ),
                    itemCount: state.items?.length??0,
                  ));
              })),
        ],
      ),
    );
  }
}
