import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/title_bar.dart';

import 'product_owner_list_container.dart';

class ProductOwnerListView extends StatelessWidget {
  ProductOwnerListView({super.key});

  final controller = Get.find<ProductOwnerListContainer>();
  final state = Get.find<ProductOwnerListContainer>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          title: '货主列表',
        ),
        body: Column(
          children: [
            Expanded(
                child: GetBuilder<ProductOwnerListContainer>(
                    id: 'product_owner_list',
                    builder: (_) {
                      return state.productOwnerList.isEmpty
                          ? EmptyLayout(hintText: '什么都没有'.tr)
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                var supplierDTO = state.productOwnerList[index];
                                return InkWell(
                                  onTap: () =>
                                      controller.toSelectProductOwner(supplierDTO),
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 32.w, horizontal: 40.w),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              supplierDTO.supplierName ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 32.sp,
                                                  color: Colours.text_333),
                                            ),
                                            SizedBox(height: 16.w),
                                            Text(
                                              supplierDTO.remark ?? '',
                                              style: TextStyle(
                                                  fontSize: 30.sp,
                                                  color: Colours.text_666),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                            child: Text(
                                              supplierDTO.phone ?? '',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 32.sp,
                                                  color: Colours.text_333),
                                            )),
                                  IconButton(
                                    onPressed: () =>controller.showBottomSheet(context, supplierDTO),
                                    icon: Icon(Icons.more_vert,
                                        color: Colors.grey))
                                      ],
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
                              itemCount: state.productOwnerList.length,
                            );
                    })),
            Container(
              height: 100.w,
              width: double.infinity,
              margin: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 10.w),
              child: Center(
                child: ElevatedButton(
                  onPressed: () => controller.addProductOwner(),
                  child: Text('+ 新增货主',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(Size(300, 50)), // 设置
                    backgroundColor: WidgetStateProperty.all(Colours.primary),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
