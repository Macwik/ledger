import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/empty_layout.dart';

import 'custom_list_controller.dart';

class CustomListView extends StatelessWidget {
  CustomListView({super.key});

  final controller = Get.find<CustomListController>();
  final state = Get.find<CustomListController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Colours.primary,
        title: GetBuilder<CustomListController>(
          id: 'custom_list_title',
          init: controller,
          global: false,
          builder: (_) {
            return Text(
              controller.state.orderType == OrderType.SALE.value ? '供应商' : '客户',
              style: TextStyle(color: Colors.white),
            );
          },
        ),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 120.w,
                  color: Colors.white60,
                  padding: EdgeInsets.all(10.w),
                  child: SearchBar(
                    leading: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: '请输入客户名称',
                    onChanged: (value) => controller.searchCustom(value),
                  ),
                ),
              ),
              Container(
                  color: Colors.white60,
                  child: IconButton(
                    onPressed: () {
                      controller.toAddCustom();
                    },
                    icon: Icon(Icons.add),
                    color: Colors.redAccent,
                  ))
            ],
          ),
          GetBuilder<CustomListController>(
              id: 'custom_list',
              init: controller,
              builder: (_) {
                return Flexible(
                  child: state.customList?.isEmpty ?? true
                      ? EmptyLayout(hintText: '什么都没有'.tr)
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            CustomDTO customDTO = state.customList![index];
                            return InkWell(
                              onTap: () => Get.back(result: customDTO),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10.w),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(customDTO.customName ?? '',
                                                style: TextStyle(
                                                  color: customDTO.invalid == 1
                                                      ? Colours.text_ccc
                                                      : Colours.text_333,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Visibility(
                                              visible: customDTO.invalid == 1,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 2.w,
                                                    bottom: 2.w,
                                                    left: 4.w,
                                                    right: 4.w),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colours.text_ccc,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Text('已停用',
                                                    style: TextStyle(
                                                      color: Colours.text_999,
                                                      fontSize: 26.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                              ),
                                            )
                                          ],
                                        )),
                                    Row(
                                      children: [
                                        Text(
                                          '欠款：',
                                          style: TextStyle(
                                            color: Colours.text_ccc,
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          customDTO.creditAmount.toString(),
                                          style: TextStyle(
                                            color: customDTO.invalid == 1
                                                ? Colours.text_ccc
                                                : Colours.text_666,
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Container(
                            height: 2.w,
                            color: Colours.divider,
                            width: double.infinity,
                          ),
                          itemCount: state.customList?.length ?? 0,
                        ),
                );
              }),
        ],
      ),
    );
  }
}
