import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/contact/contact_dto.dart';
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
        title: '请选要导入的内容',
        actionName: '批量导入',
        actionPressed: () {
          state.batch.value = !state.batch.value;
        },
      ),
      body: Column(
        children: [
          GetBuilder<CustomListController>(
              id: 'contact_list',
              builder: (_) {
                return Flexible(
                  child: state.contactList?.isEmpty ?? true
                      ? EmptyLayout(hintText: '什么都没有'.tr)
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            ContactDTO contactDTO = state.contactList![index];
                            return Container(
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
                                          Expanded(
                                            child: ButtonBar(
                                              alignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Obx(() => Visibility(
                                                    visible: state.batch.value,
                                                    child: Checkbox(
                                                      value: false,
                                                      onChanged:
                                                          (bool? selected) {},
                                                      activeColor:
                                                          Colours.primary,
                                                    ))),
                                                Text(contactDTO.name ?? '',
                                                    style: TextStyle(
                                                      color: Colours.text_333,
                                                      fontSize: 32.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: ButtonBar(
                                              alignment: MainAxisAlignment.end,
                                              children: [
                                                state.customNameSet.contains(
                                                        contactDTO.name ?? '')
                                                    ? ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text('已导入'))
                                                    : ElevatedButton(
                                                        onPressed: () {
                                                          controller.addCustom(
                                                              contactDTO.name ??
                                                                  '',
                                                              contactDTO
                                                                      .phone ??
                                                                  '');
                                                        },
                                                        child: Text('导入'))
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
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
