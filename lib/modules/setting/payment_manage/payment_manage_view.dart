import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/image.dart';

import 'payment_manage_controller.dart';

class PaymentManageView extends StatelessWidget {
  PaymentManageView({super.key});

  final controller = Get.find<PaymentManageController>();
  final state = Get.find<PaymentManageController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: AppBar(
          title: Text( state.select == IsSelectType.TRUE
              ? '选择支付方式'
              :'支付方式管理',
            style: TextStyle(color: Colors.white),),
          leading: BackButton(color: Colors.white,),),
        body: Column(
          children: [
            GetBuilder<PaymentManageController>(
                id: 'paymentDetail',
                init: controller,
                builder: (_) {
                  return
                    Expanded(child:ListView.separated(
                      itemBuilder: (context, index) {
                        var bankDTO = state.paymentMethodDTOList![index];
                        return Slidable(
                          enabled: state.select != IsSelectType.TRUE,
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.25,
                              children: [
                                SlidableAction(
                                  label: '删除',
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete_outline_rounded,
                                  onPressed: (context) =>
                                      controller.toDeleteLedger(bankDTO.id),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () => controller.toSelect(bankDTO),
                              child:
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(top: 32.w,bottom: 32.w,left: 40.w),
                                child:Row(
                                children: [
                                  Visibility(
                                    visible:state.select == IsSelectType.TRUE,
                                      child: Container(
                                      width: 80.w,
                                      child:
                                      Icon( Icons.circle_outlined,
                                        size: 40.w,))),
                                Container(
                                  width: 150.w,
                                  child: LoadAssetImage(
                                  bankDTO.icon ?? 'payment_common',
                                  format: ImageFormat.png,
                                  height: 50.w,
                                  width: 50.w,
                                ),),
                                  Text(bankDTO.name ?? '',
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    color: Colours.text_333
                                  ),),
                                ],
                              ) ,),
                            )
                        );
                      },
                      //separatorBuilder是分隔符组件，可以直接拿来用
                      separatorBuilder: (context, index) => Container(
                        height: 2.w,
                        color: Colours.divider,
                        width: double.infinity,
                      ),
                      itemCount: state.paymentMethodDTOList?.length ?? 0,
                    ));
                }),
            Container(
              height: 90.w,
              width: double.infinity,
              margin: EdgeInsets.only(right: 20.w, left: 20.w, top: 10.w),
              child: ElevatedButton(
                onPressed: () => controller.addPaymentMethod(),
                child: Text('+ 新增支付方式',
                    style: TextStyle(
                      color: Colours.primary,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                    )),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(300, 50)), // 设置
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}
