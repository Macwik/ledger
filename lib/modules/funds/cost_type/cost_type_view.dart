import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/costIncome/cost_income_label_type_dto.dart';
import 'package:ledger/enum/cost_order_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/title_bar.dart';

import 'cost_type_controller.dart';

class CostTypeView extends StatelessWidget {
  CostTypeView({super.key});

  final controller = Get.find<CostTypeController>();
  final state = Get.find<CostTypeController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          title: state.costOrderType != CostOrderType.INCOME? '请选择费用类别'.tr:'请选择收入类别'.tr,
        ),
        body: SingleChildScrollView(
          child:Column(
            children: [
              Visibility(
                  visible: state.costOrderType != CostOrderType.INCOME,
                  child: Column(
                children: [
                  GetBuilder<CostTypeController>(
                      id: 'purchase_cost',
                      builder: (_) {
                        return ExpansionTile(
                          title: Text('采购费用'),
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),//禁用滑动属性
                              itemBuilder: (context, index) {
                                CostIncomeLabelTypeDTO? costLabel = state.costLabelTypeDTO?[index];
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    extentRatio: 0.25,
                                    children: [
                                      SlidableAction(
                                        label: '删除',
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete,
                                        onPressed: (context)=> controller.toDeleteOrder(costLabel!.id!, 0),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(
                                        right: 40.w, left: 40.w),
                                    child: InkWell(
                                      onTap: ()=>Get.back(result: costLabel),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.w, vertical: 32.w),
                                        child: Row(
                                          children: [
                                            Text(
                                              costLabel?.labelName ?? '',
                                              style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 32.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              //separatorBuilder是分隔符组件，可以直接拿来用
                              separatorBuilder: (context, index) => Container(
                                height: 2.w,
                                color: Colours.divider,
                                width: double.infinity,
                              ),
                              itemCount: state.costLabelTypeDTO?.length ?? 0,
                            ),
                            // 此处放置content部分的代码
                          ],
                          initiallyExpanded: true, // 设置初始展开状态
                        );
                      }),
                  Container(
                    width: double.infinity,
                    height: 100.w,
                    margin: EdgeInsets.only(right: 20.w, left: 20.w, top: 10.w),
                    child: ElevatedButton(
                      onPressed: ()=> controller.toAddCostType(),
                      child: Text(
                        '+ 添加费用类别',
                        style: TextStyle(
                          color: Colours.primary,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(300, 50)), // 设置
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                  ),
                ],
              )),
              Visibility(
                  visible: state.costOrderType != CostOrderType.COST,
                  child:
              Column(
                children: [
                  GetBuilder<CostTypeController>(
                      id: 'daily_cost',
                      builder: (_) {
                        return ExpansionTile(
                          title: Text('日常收入类型'),
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),//禁用滑动属性
                              itemBuilder: (context, index) {
                                CostIncomeLabelTypeDTO? dailyLabel = state.dailyLabelTypeDTO?[index];
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    extentRatio: 0.25,
                                    children: [
                                      SlidableAction(
                                        label: '删除',
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete,
                                        onPressed: (context) {
                                          controller.toDeleteOrder(dailyLabel!.id!, 1);
                                        },
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(
                                        right: 40.w, left: 40.w),
                                    child: InkWell(
                                      onTap: ()=>Get.back(result: dailyLabel),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.w, vertical: 32.w),
                                        child: Row(
                                          children: [
                                            Text(
                                              dailyLabel?.labelName ?? '',
                                              style: TextStyle(
                                                color: Colours.text_333,
                                                fontSize: 32.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              //separatorBuilder是分隔符组件，可以直接拿来用
                              separatorBuilder: (context, index) => Container(
                                height: 2.w,
                                color: Colours.divider,
                                width: double.infinity,
                              ),
                              itemCount: state.dailyLabelTypeDTO?.length ?? 0,
                            ),
                          ],
                          initiallyExpanded: true, // 设置初始展开状态
                        );
                      }),
                  Container(
                    width: double.infinity,
                    height: 100.w,
                    margin: EdgeInsets.only(right: 20.w, left: 20.w, top: 10.w),
                    child: ElevatedButton(
                      onPressed: ()=> controller.toAddIncomeType(),
                      child: Text(
                        '+ 添加收入种类',
                        style: TextStyle(
                          color: Colours.primary,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(300, 50)), // 设置
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ) ,
        )
    );
  }
}
