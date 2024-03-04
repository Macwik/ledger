import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/widget/empty_layout.dart';

import 'daily_account_cost_detail_controller.dart';

class DailyAccountCostDetailView extends StatelessWidget {
  DailyAccountCostDetailView({super.key});

  final controller = Get.find<DailyAccountCostDetailController>();
  final state = Get.find<DailyAccountCostDetailController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
      centerTitle:true,
      title: Text('费用详情',style: TextStyle(color: Colors.white),),
      leading: BackButton(
       onPressed: ()=>  Get.back(),
        color: Colors.white,),),
      body:  Column(
            children: [
              Expanded(
                child: state.externalOrderBaseDTOList?.isEmpty ?? true
                    ? EmptyLayout(hintText: '什么都没有'.tr)
                    : ListView.separated(
                  itemBuilder: (context, index) {
                    var externalOrderBase = state.externalOrderBaseDTOList![index];
                    return
                      InkWell(
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
                  separatorBuilder: (context, index) => Container(
                    height: 2.w,
                    color: Colours.divider,
                    width: double.infinity,
                  ),
                  itemCount: state.externalOrderBaseDTOList?.length ?? 0,
                ),
              ),
            ],
          ),
    );
  }
}
