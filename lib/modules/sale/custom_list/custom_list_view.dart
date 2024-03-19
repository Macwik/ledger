import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/contact/contact_dto.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/res/export.dart';
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
      appBar: TitleBar(
        title:  '请选要导入的内容',
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
                            return InkWell(
                              onTap: () => Get.back(result: contactDTO),
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
                                            Text(contactDTO.name ?? '',
                                                style: TextStyle(
                                                  color: Colours.text_333,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Container(
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
                                          ],
                                        )),
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
                          itemCount: state.contactList?.length ?? 0,
                        ),
                );
              }),
        ],
      ),
    );
  }
}
