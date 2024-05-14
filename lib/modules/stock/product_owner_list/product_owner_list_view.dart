import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/title_bar.dart';

import 'product_owner_list_container.dart';

class ProductOwnerListView extends StatelessWidget {
  ProductOwnerListView({super.key});

  final controller = Get.find<ProductOwnerListContainer>();
  final state = Get.find<ProductOwnerListContainer>().state;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitleBar(
          title:  '货主列表',),
        body: Column(
          children: [
            Expanded(child:
            ListView.separated(
              itemBuilder: (context, index) {
               // var bankDTO = state.paymentMethodDTOList![index];
                return Slidable(
                    //enabled: state.select != IsSelectType.TRUE,
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.5,
                      children: [
                        SlidableAction(
                          label: '备注',
                          backgroundColor: Colors.blueAccent,
                         // icon: Icons.delete_outline_rounded,
                          onPressed: (context) => controller.addProductOwnerRemark(),
                        ),
                        SlidableAction(
                          label: '删除',
                          backgroundColor: Colors.red,
                          icon: Icons.delete_outline_rounded,
                          onPressed: (context) => controller.toDeleteProductOwner(),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => controller.toSelectProductOwner(),
                      child:
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 32.w,horizontal: 40.w),
                        child:Row(
                          children: [
                            Column(
                              children: [
                                Text('name',
                                  style: TextStyle(
                                      fontSize: 32.sp,
                                      color: Colours.text_333
                                  ),),
                                SizedBox(height:16.w),
                                Text('remark',
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Colours.text_666
                                  ),),
                              ],
                            ),
                            Expanded(
                                child: Text('133****4444',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 32.sp,
                                  color: Colours.text_333
                              ),)),
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
              itemCount: 10,
            )),
            Container(
              height: 100.w,
              width: double.infinity,
              margin: EdgeInsets.only(right: 20.w, left: 20.w,bottom: 10.w),
              child: Center(
                child:ElevatedButton(
                  onPressed: () => controller.addProductOwner(),
                  child: Text('+ 新增货主',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(300, 50)), // 设置
                    backgroundColor: MaterialStateProperty.all(Colours.primary),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
