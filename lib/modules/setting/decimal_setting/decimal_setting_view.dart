import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/calculate_scale.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/modules/setting/decimal_setting/decimal_setting_controller.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/will_pop.dart';


class DecimalSettingView extends StatelessWidget {
  DecimalSettingView({super.key});

  final controller = Get.find<DecimalSettingController>();
  final state = Get.find<DecimalSettingController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: AppBar(
          title: Text('金额小数设置',style: TextStyle(color: Colors.white),),
          leading: BackButton(color: Colors.white,
              onPressed: () {
                Get.back(result: ProcessStatus.OK);
              },
          ),),
        body:  MyWillPop(
            onWillPop: () async {
              Get.back(result: ProcessStatus.OK);
              return true;
            },
            child:GetBuilder<DecimalSettingController>(
          id: 'decimal_setting_calculate_change',
            builder: (_)=> Column(
              children: [
                InkWell(
                  onTap: ()=> controller.changeCalculate(CalculateScale.KEEP_INTEGER.value),
                  child:Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 32.w,horizontal: 32.w),
                      color: Colors.white,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            '保留到个位',
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 32.sp,
                            ),
                          ),
                          const Spacer(),
                          Visibility(
                              visible: state.calculateScale?.scale == CalculateScale.KEEP_INTEGER.value,
                              child: Icon(
                                Icons.check,
                                color: Colors.orange,
                              ))
                        ],
                      )) ,
                ),
                Container(
                  color: Colours.divider,
                  height: 1.w,
                  width: double.infinity,
                ),
                InkWell(
                  onTap: ()=> controller.changeCalculate(CalculateScale.KEEP_ONE_DECIMAL.value),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 32.w,horizontal: 32.w),
                      color: Colors.white,
                      width: double.infinity,
                      child: Row(children: [
                        Text('保留到小数点后一位',
                          style: TextStyle(
                            color: Colours.text_333,
                            fontSize: 32.sp,
                          ),
                        ),
                        const Spacer(),
                        Visibility(
                            visible: state.calculateScale?.scale == CalculateScale.KEEP_ONE_DECIMAL.value,
                            child: Icon(
                              Icons.check,
                              color: Colors.orange,
                            ))
                      ],
                      )),
                ),
                Container(
                  color: Colours.divider,
                  height: 1.w,
                  width: double.infinity,
                ),
                InkWell(
                  onTap: ()=> controller.changeCalculate(CalculateScale.KEEP_TWO_DECIMALS.value),
                  child:  Container(
                      padding: EdgeInsets.symmetric(vertical: 32.w,horizontal: 32.w),
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            '保留到小数点后两位',
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 32.sp,
                            ),
                          ),
                          const Spacer(),
                          Visibility(
                              visible: state.calculateScale?.scale == CalculateScale.KEEP_TWO_DECIMALS.value,
                              child:Icon(Icons.check,color: Colors.orange,) )
                        ],
                      )),
                ),
              ],
            )))
       );
  }
}
