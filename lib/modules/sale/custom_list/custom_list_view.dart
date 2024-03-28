import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/contact/contact_dto.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';

import 'custom_list_controller.dart';

class CustomListView extends StatelessWidget {
  CustomListView({super.key});

  final controller = Get.find<CustomListController>();
  final state = Get.find<CustomListController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
        title: state.customType== CustomType.CUSTOM ? '添加客户' :'添加供应商',
        backPressed: () => Get.back(result: ProcessStatus.OK),
      ),
      body: Column(
        children: [
          GetBuilder<CustomListController>(
              id: 'contact_list',
              builder: (_) {
                return Flexible(
                  child: state.contactList.isEmpty
                      ? EmptyLayout(hintText: '什么都没有'.tr)
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            ContactDTO contactDTO = state.contactList[index];
                            return Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ButtonBar(
                                      alignment: MainAxisAlignment.start,
                                      children: [
                                        ///批量导入选择框
                                        Text(contactDTO.name ?? '',
                                            style: TextStyle(
                                              color: Colours.text_333,
                                              fontSize: 36.sp,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ButtonBar(
                                      alignment: MainAxisAlignment.end,
                                      children: [
                                        state.customNameSet
                                                .contains(contactDTO.name ?? '')
                                            ? ElevatedButton(
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0),
                                                  // 将阴影值设置为0
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                          Size(200.w, 80.w)),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          EdgeInsets.zero),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  '已导入',
                                                  style: TextStyle(
                                                      fontSize: 30.sp,
                                                      color: Colours.text_666),
                                                ))
                                            : ElevatedButton(
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0),
                                                  // 将阴影值设置为0
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                          Size(200.w, 80.w)),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          EdgeInsets.zero),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      side: BorderSide(
                                                        width: 1.0,
                                                        color: Colours.text_ccc,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  controller.addCustom(
                                                      contactDTO.name ?? '',
                                                      contactDTO.phone ?? '',
                                                      state.isAddressList ==
                                                              IsSelectType
                                                                  .FALSE.value
                                                          ? '其他账本导入' : '通讯录导入');
                                                },
                                                child: Text(
                                                  '导入',
                                                  style: TextStyle(
                                                      fontSize: 32.sp,
                                                      color: Colours.text_666),
                                                ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Container(
                            height: 2.w,
                            color: Colours.divider,
                            width: double.infinity,
                          ),
                          itemCount: state.contactList?.length ?? 0,
                        ),
                );
              }),
        ],
      ),
    );
  }
}
