import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';

import 'daily_account_cost_detail_controller.dart';

class DailyAccountCostDetailView extends StatelessWidget {
  DailyAccountCostDetailView({super.key});

  final controller = Get.find<DailyAccountCostDetailController>();
  final state = Get.find<DailyAccountCostDetailController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
      title: '费用详情'),
      body:  SingleChildScrollView(child:  Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 40.w),
              child: Row(
                children: [
                  Text('产地费用'),
                  const Spacer(),
                  Text('合计：',
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),),
                  Text(controller.totalExternalOrderAmount(),
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),),
                ],
              )),
          Card(
              elevation: 6,
              shadowColor: Colors.black45,
              margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.w)),
              ),
              child:state.externalOrderDTO.isEmpty
                  ? EmptyLayout(hintText: '什么都没有'.tr)
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var externalOrderBase = state.externalOrderDTO[index];
                  return  InkWell(
                      onTap: ()=>Get.toNamed(RouteConfig.costDetail,arguments: {'id':externalOrderBase.id}),
                      child:Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 32.w,horizontal: 40.w),
                        child:Row(
                          children: [
                            Text(externalOrderBase.costIncomeName??'',
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w500,
                              ),),
                            const Spacer(),
                            Text(DecimalUtil.formatAmount(externalOrderBase.totalAmount),
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),),
                          ],
                        ),
                      ));},

                itemCount: state.externalOrderDTO.length,
              )),

          Container(
              padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 40.w),
              child: Row(
                children: [
                  Text('销售地费用'),
                  const Spacer(),
                  Text('合计：',
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),),
                  Text(controller.totalDiscountExternalOrderAmount(),
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),),
                ],
              )),
          Card(
              elevation: 6,
              shadowColor: Colors.black45,
              margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.w)),
              ),
              child: state.discountExternalOrderDTO.isEmpty
                  ? EmptyLayout(hintText: '什么都没有'.tr)
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var discountExternalOrderBase = state.discountExternalOrderDTO[index];
                  return  InkWell(
                      onTap: ()=>Get.toNamed(RouteConfig.costDetail,arguments: {'id':discountExternalOrderBase.id}),
                      child:Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 32.w,horizontal: 40.w),
                        child:Row(
                          children: [
                            Text(discountExternalOrderBase.costIncomeName??'',
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w500,
                              ),),
                            const Spacer(),
                            Text(DecimalUtil.formatAmount(discountExternalOrderBase.totalAmount),
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),),
                          ],
                        ),
                      ));},
                itemCount: state.discountExternalOrderDTO.length,
              ))
        ],
      ))

    );
  }
}
