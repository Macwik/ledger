import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/title_bar.dart';

import 'unit_controller.dart';

class UnitView extends StatelessWidget {
  UnitView({super.key});

  final controller = Get.find<UnitController>();
  final state = Get.find<UnitController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          title: '单位选择'.tr,
        ),
        body: Column(
          children: [
            Container(
                height: 90.w,
                width: double.infinity,
                margin: EdgeInsets.only(
                    right: 20.w, left: 20.w, top: 10.w, bottom: 10.w),
                child: ElevatedButton(
                  onPressed: () => controller.toMultiUnit(),
                  child: Text('开启多单位',
                      style: TextStyle(
                        color: Colours.primary,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  style: ButtonStyle(
                      //fixedSize: MaterialStateProperty.all(Size(300, 50)), // 设置
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colours.primary),
                      )),
                )),
            Expanded(
                child: GetBuilder<UnitController>(
                    id: 'unitList',
                    init: controller,
                    builder: (_) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          var unitDTO = state.unitList![index];
                          return InkWell(
                              onTap: () => controller.selectUnit(unitDTO),
                              child: ListTile(
                                tileColor: Colors.white,
                                title: Text(unitDTO.unitName ?? ''),
                                leading: Radio(
                                  value: state.unitDetailDTO?.unitId, //被选中的
                                  groupValue: unitDTO.id, //所有的
                                  onChanged: (value) =>
                                      controller.selectUnit(unitDTO),
                                ),
                              ));
                        },
                        //separatorBuilder是分隔符组件，可以直接拿来用
                        separatorBuilder: (context, index) => Container(
                          height: 2.w,
                          color: Colours.divider,
                          width: double.infinity,
                        ),
                        itemCount: state.unitList?.length ?? 0,
                      );
                    })),
          ],
        ));
  }
}
