import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';

import 'repayment_time_manage_controller.dart';

class RepaymentTimeManageView extends StatelessWidget {
  RepaymentTimeManageView({super.key});

  final controller = Get.find<RepaymentTimeManageController>();
  final state = Get.find<RepaymentTimeManageController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          title: '还款时间设置',
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 40.w),
              child: GetBuilder<RepaymentTimeManageController>(
                id: 'repayment_time_manage',
                builder: (_) {
                  return Row(
                    children: [
                      Text(
                        '还款时间：',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 34.sp,
                            color: Colours.text_666),
                      ),
                      Expanded(
                          child: Text(
                        '${state.salesLineDTO?.startTime}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 34.sp,
                            color: Colours.text_333),
                      )),
                      Text(
                        '至',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 30.sp,
                            color: Colours.text_999),
                      ),
                      Expanded(
                          child: Text(
                        '${state.salesLineDTO?.endTime}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 34.sp,
                            color: Colours.text_333),
                      )),
                    ],
                  );
                },
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 40.w),
              width: double.infinity,
              child: Text('还款时间是指 除老板外其他人可以保存还款的时间段',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colours.text_999,
                      fontSize: 30.sp)),
            ),
            Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 40.w),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.showTimeRange(context);
                  },
                  child: Text(
                    '设置时间',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 36.sp),
                  ),
                ))
          ],
        ));
  }
}
